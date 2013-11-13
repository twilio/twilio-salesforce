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
 * Generates capability tokens that authorize Twilio Client running in
 * the user's browser or mobile device to contact Twilio directly to
 * make outgoing calls or receive incoming calls.
 */
global class TwilioCapability {

    private class IllegalStateException extends Exception {}

    private String accountSid;
    private String authToken;
    private List<String> scopes;

    // Incoming Parameter holding until generate token time
    private boolean buildIncomingScope = false;
    private String incomingClientName = null;

    // Outgoing Paramater holding until generate token time
    private boolean buildOutgoingScope = false;
    private String appSid = null;
    private Map<String, String> outgoingParams = null;

    /**
     * Create a new TwilioCapability with zero permissions. Next steps are to
     * grant access to resources by configuring this token through the functions
     * allowXXXX.
     * 
     * @param accountSid  the account sid to which this token is granted access
     * @param authToken   the secret key used to sign the token. Note, this auth token is not visible to the user of the token.
     */
    global TwilioCapability(String accountSid, String authToken) {
        this.accountSid = accountSid;
        this.authToken = authToken;
        this.scopes = new List<String>();

    }

    /**
     * Allow the user of this token to make outgoing connections.
     * 
     * @param applicationSid
     *            the application to which this token grants access
     */
    global void allowClientOutgoing(String appSid) {
        allowClientOutgoing(appSid, null);
    }

    /**
     * Allow the user of this token to make outgoing connections.
     * 
     * @param applicationSid
     *            the application to which this token grants access
     * @param params
     *            signed parameters that the user of this token cannot
     *            overwrite.
     */
    global void allowClientOutgoing(String appSid, Map<String, String> params) {
        this.buildOutgoingScope = true;
        this.outgoingParams = params;
        this.appSid = appSid;
    }
    
    /**
     * If the user of this token should be allowed to accept incoming
     * connections then configure the TwilioCapability through this method and
     * specify the client name.
     * 
     * @param clientName
     */
    global void allowClientIncoming(String clientName) {
        // Save the default client name
        this.incomingClientName = clientName;
        this.buildIncomingScope = true;
    }

    /**
     * Allow the user of this token to access their event stream.
     * 
     * @param filters
     *            key/value filters to apply to the event stream
     */
    global void allowEventStream(Map<String, String> filters) {
        Map<String, String> value = new Map<String, String>();
        value.put('path', '/2010-04-01/Events');
        if (filters != null) {
            value.put('params', generateParamString(filters));
        }
        this.scopes.add(buildScopeString('stream', 'subscribe', value));
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
    global String generateToken(long ttl) {
        // Build these scopes lazily when we generate tokens so we know
        // if we have a default or incoming client name to use
        buildIncomingScope();
        buildOutgoingScope();       
        Map<String, Object> payload = new Map<String, Object>();
        payload.put('iss', this.accountSid);
        payload.put('exp', String.valueOf(System.currentTimeMillis()/1000 + ttl));
        payload.put('scope', join(this.scopes, ' '));
        return jwtEncode(payload, this.authToken);
    }


    /* PRIVATE METHODS */
    
    /**
     *  Construct the scope string for outgoing calls
     */
    private void buildOutgoingScope() {
        if (this.buildOutgoingScope) {
            Map<String, String> values = new Map<String, String> { 'appSid' => appSid };

            if (this.incomingClientName != null) {
                values.put('clientName', this.incomingClientName);
            }

            // Build outgoing scopes
            if (this.outgoingParams != null && !this.outgoingParams.isEmpty()) {
                values.put('appParams', generateParamString(this.outgoingParams));
            }
            this.scopes.add(buildScopeString('client', 'outgoing', values));
        }
    }
    
    /**
     *  Construct the scope string for incoming calls
     */
    private void buildIncomingScope() {
        if (this.buildIncomingScope) {
            Map<String, String> value = new Map<String, String>();

            // Incoming name, which takes precedence over the default client name.
            // However, we do NOT accept a null clientName here.
            if (this.incomingClientName != null) {
                value.put('clientName', this.incomingClientName);
            } else {
                throw new IllegalStateException('No client name set');
            }
            this.scopes.add(buildScopeString('client', 'incoming', value));
        }
    }
    
    /**
     * Construct JWT scope string in the format "scope:<service>:<privilege>?<params>"
     */
    private static String buildScopeString(String service, String privilege,
            Map<String, String> params) {
        String scope = 'scope:'+service+':'+privilege;
        if (params!=null && !params.isEmpty()) {
            scope += '?'+generateParamString(params);
        }
        return scope;
    }

    /**
     * Construct URL-style query param string, e.g. key1=val1&key2=val2&...keyN=valN
     */
    private static String generateParamString(Map<String, String> params) {
        String queryString = '';
        
        Set<String> keySet = params.keySet();
        for (String key : keySet) {
            if (queryString.length() > 0) {
                queryString += '&';
            }
            queryString += EncodingUtil.urlEncode(key, 'UTF-8') + '='
                + EncodingUtil.urlEncode(params.get(key), 'UTF-8');
        }
        return queryString;
    }

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
    
    /* UNIT TESTS FOR PRIVATE METHODS */
    static testMethod void testGenerateParamString() {
        System.assertEquals('', generateParamString(new Map<String,String>()));
        System.assertEquals('a=b', generateParamString(new Map<String,String> {'a'=>'b'} ));
        System.assertEquals('cat=dog&foo=bar', generateParamString(new Map<String,String> {'foo'=>'bar', 'cat' => 'dog'} ));
        System.assertEquals('e=f&c=d&a=b', generateParamString(new Map<String,String> {'a'=>'b', 'c'=>'d', 'e'=>'f' } ));
        System.assertEquals('split+key2=split+val2&split+key1=split+val1', generateParamString(new Map<String,String> {'split key1'=>'split val1', 'split key2'=>'split val2'} ));
    }
    
    static testMethod void testEncodeBase64() {
        System.assertEquals('',urlSafeEncodeBase64(''));
        System.assertEquals('QQ',urlSafeEncodeBase64('A'));     
        System.assertEquals('QUI',urlSafeEncodeBase64('AB'));
        System.assertEquals('QUJDRA',urlSafeEncodeBase64('ABCD'));
    }
    
    static testMethod void testJoin() {
        System.assertEquals('', join(new List<String>(),','));
        System.assertEquals('a', join(new List<String>{'a'},','));
        System.assertEquals('a,b,c,d,e', join(new List<String>{'a','b','c','d','e'},','));
    }
    
    /* ACCESSOR METHODS FOR EXTERNAL TESTS */
    
    public boolean test_buildOutgoingScope {
        get {
            if (!Test.isRunningTest()) throw new TestOnlyException('Test must be running to use this method');
            return this.buildOutgoingScope;
        }
    }
    
    public String test_appSid {
        get {
            if (!Test.isRunningTest()) throw new TestOnlyException('Test must be running to use this method');
            return this.appSid;
        }
    }
    
    public Map<String,String> test_outgoingParams {
        get {
            if (!Test.isRunningTest()) throw new TestOnlyException('Test must be running to use this method');
            return this.outgoingParams;
        }
    }
    
    public List<String> test_scopes {
        get {
            if (!Test.isRunningTest()) throw new TestOnlyException('Test must be running to use this method');
            return this.scopes;
        }
    }
    
    public String test_incomingClientName {
        get {
            if (!Test.isRunningTest()) throw new TestOnlyException('Test must be running to use this method');
            return this.incomingClientName;
        }
    }
    
    private class TestOnlyException extends Exception {}
}