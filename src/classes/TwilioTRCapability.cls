/*
Copyright (c) 2012 Twilio, Inc.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
/**
 * Generates capability tokens that authorize Twilio TaskRouter running in
 * the user's browser.
 */
global class TwilioTRCapability {

    private class IllegalStateException extends Exception {}

	final String taskRouterUrlBase = 'https://taskrouter.twilio.com';
    final String taskRouterVersion = 'v1';
    final String taskRouterEventsUrlBase = 'https://event-bridge.twilio.com/v1/wschannels';

    private String accountSid;
    private String authToken;
    private String workspaceSid;
    private String workerSid;
    private List<TwilioCapabilityPolicy> policies;

    /**
     * Create a new TwilioCapability with zero permissions. Next steps are to
     * grant access to resources by configuring this token through the functions
     * allowXXXX.
     * 
     * @param accountSid  the account sid to which this token is granted access
     * @param authToken   the secret key used to sign the token. Note, this auth token is not visible to the user of the token.
     * @param workspaceSid
     * @param workerSid
     */

    global TwilioTRCapability(String accountSid, String authToken, String workspaceSid, String workerSid) {
        this.accountSid = accountSid;
        this.authToken = authToken;
        this.workspaceSid = workspaceSid;
        this.workerSid = workerSid;
        this.policies = new List<TwilioCapabilityPolicy>();
        this.AllowWorkerWebsockets();
        this.AllowWorkerActivityListFetch();
    }
    
    
	public void allowWorkerActivityUpdates()
    {
        String url = GetWorkerUrl();
        TwilioCapabilityPolicy policy = new TwilioCapabilityPolicy(url, 'POST', true);
        policy.postFilter.put('ActivitySid', TwilioCapabilityPolicy.required);
        policies.add(policy);
    }

    public void allowWorkerFetchAttributes()
    {
        String url = GetWorkerUrl();
        policies.add(new TwilioCapabilityPolicy(url, 'GET', true));
    }

    public void allowTaskReservationUpdates()
    {
        String url = GetWorkspaceUrl() + '/Tasks/**';
        TwilioCapabilityPolicy policy = new TwilioCapabilityPolicy(url, 'POST', true);
        policy.postFilter.put('ReservationStatus', TwilioCapabilityPolicy.required);
        policies.add(policy);
    }

    private string getWorkspaceUrl()
    {
        return taskRouterUrlBase + '/' + taskRouterVersion + '/Workspaces/' + workspaceSid;
    }

    private string getWorkerUrl()
    {
        return GetWorkspaceUrl() + '/Workers/' + workerSid;
    }

    private void allowWorkerWebsockets()
    {
        String wsUrl = taskRouterEventsUrlBase + '/' + accountSid + '/' + workerSid;
        this.policies.add(new TwilioCapabilityPolicy(wsUrl, 'GET', true));
        this.policies.add(new TwilioCapabilityPolicy(wsUrl, 'POST', true));
    }

    private void allowWorkerActivityListFetch()
    {
        String url = GetWorkspaceUrl() + '/Activities';
        this.policies.add(new TwilioCapabilityPolicy(url, 'GET', true));
    }

    /**
     * Generates a new token based on the credentials and permissions that
     * previously has been granted to this token.
     * 
     * @return the newly generated token that is valid for 3600 seconds
     */
    global String generateToken() {
        return generateToken(3600);
    }

    /**
     * Generates a new token based on the credentials and permissions that
     * previously has been granted to this token.
     * 
     * @param expiresAt
     *            the expiration instance of the token.
     * @return the newly generated token that is valid for ttl seconds
     */
    public string generateToken(long ttl)
    {

         // Build these scopes lazily when we generate tokens so we know
        // if we have a default or incoming client name to use   
        Map<String, Object> payload = new Map<String, Object>();
        payload.put('iss', accountSid);
        payload.put('exp', System.currentTimeMillis()/1000 + ttl);
        payload.put('version', taskRouterVersion);
        payload.put('worker_sid', workerSid);
        payload.put('account_sid', accountSid);        
        payload.put('workspace_sid', workspaceSid);
        payload.put('channel', workerSid);
        List<Map<String, Object>> ps = new  List<Map<String, Object>>();

        // Loop through the Policies and get their Map Representation
        for (TwilioCapabilityPolicy policy: policies) {
        	ps.add(policy.toMap());
        }
        payload.put('policies', ps);
       	return jwtEncode(payload, this.authToken);
    }
 
    /* PRIVATE METHODS */ 
    /**
     * Construct JWT token consisting of header, payload, and signature
     *
     * See http://self-issued.info/docs/draft-jones-json-web-token.html
     */
    private static String jwtEncode(Map<String, Object> payload, String key) {
        Map<String, Object> header = new Map<String, Object>();
        header.put('typ', 'JWT');
        header.put('alg', 'HS256');

        List<String> segments = new List<String>();
        segments.add(urlSafeEncodeBase64(JSON.serialize(header)));
        segments.add(urlSafeEncodeBase64(JSON.serialize(payload)));

        String signature = sign(join(segments, '.'), key);
        segments.add(signature);
        return join(segments, '.');
    }

    private static String urlSafeEncodeBase64(String data) {
        return urlSafeEncodeBase64(Blob.valueOf(data));
    }

    private static String urlSafeEncodeBase64(Blob data) {
        String encodedString = EncodingUtil.base64Encode(data);
        return encodedString.replace('+','-').replace('/','_').replace('=', ''); // make URL-safe
    }
    
    /**
     * Construct a String containing the contents of 'vals' separated by 'sep'
     */
    private static String join(List<String> vals, String sep) {
        String sb = '';
        for (Iterator<String> it=vals.iterator(); it.hasNext(); ) {
            String value = it.next();
            if (sb.length() != 0)
                sb += sep;
            sb += value;
        }
        return sb;
    }

    /**
     * Generate a signature for the token
     *
     * See http://self-issued.info/docs/draft-jones-json-web-signature.html
     *   and http://discussion.forum.nokia.com/forum/showthread.php?130974-Help-required-How-to-generate-a-MAC-(HMAC-SHA1)-with-Java
     */
    private static String sign(String data, String key) {
        Blob mac = Crypto.generateMac('hmacSHA256', Blob.valueOf(data), Blob.valueOf(key));
        String result = urlSafeEncodeBase64(mac);
        return result;
    }
}