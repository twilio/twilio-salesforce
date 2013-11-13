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
 * The Class TwilioRestClient.
 */
public class TwilioRestClient {

    /** The Constant VERSION. */
    private static final String VERSION = '3.2.0';

    /** The endpoint. */
    private String endpoint = 'https://api.twilio.com';

    /** The Constant DEFAULT_VERSION. */
    public static final String DEFAULT_VERSION = '2010-04-01';

    /** The account sid. */
    private String accountSid;

    /** The auth token. */
    private String authToken;

    /** The num retries. */
    private Integer numRetries = 3;
 
    /** The auth account. */
    private TwilioAccount authAccount;

    /**
     * Explcitly construct a TwilioRestClient with the given API credentials.
     * 
     * @param accountSid
     *            the 34 character Account identifier (starting with 'AC'). This
     *            can be found on your Twilio dashboard page.
     * @param authToken
     *            the 32 character AuthToken. This can be found on your Twilio
     *            dashboard page.
     * 
     */
    public TwilioRestClient(String accountSid, String authToken) {
        this(accountSid, authToken, null);
    }

    /**
     * Explcitly construct a TwilioRestClient with the given API credentials and
     * endpoint.
     * 
     * @param accountSid
     *            the 34 character Account identifier (starting with 'AC'). This
     *            can be found on your Twilio dashboard page.
     * @param authToken
     *            the 32 character AuthToken. This can be found on your Twilio
     *            dashboard page.
     * @param endpoint
     *            the url of API endpoint you wish to use. (e.g. -
     *            'https://api.twilio.com')
     */
    public TwilioRestClient(String accountSid, String authToken, String endpoint) {

        validateAccountSid(accountSid);
        validateAuthToken(authToken);

        this.accountSid = accountSid;
        this.authToken = authToken;

        if ((endpoint != null) && (!endpoint.equals(''))) {
            this.endpoint = endpoint;
        }
        this.authAccount = new TwilioAccount(this);
        this.authAccount.setSid(this.accountSid);
        this.authAccount.setAuthToken(this.authToken);

    }
    
    /**
     * Gets the num retries.
     * 
     * @return the num retries
     */
    public Integer getNumRetries() {
        return numRetries;
    }

    /**
     * Sets the num retries.
     * 
     * @param numRetries
     *            the new num retries
     */
    public void setNumRetries(Integer numRetries) {
        this.numRetries = numRetries;
    }

    // Check for a valid 32 character auth token
    /**
     * Validate auth token.
     * 
     * @param authToken
     *            the auth token
     */
    private void validateAuthToken(String authToken) {
        if (authToken == null || authToken.length() != 32)
            throw new TwilioRestException('AuthToken \'' + authToken + '\' is not valid.');
    }

    // Check for a valid 34 character account sid starting with 'AC'
    /**
     * Validate account sid.
     * 
     * @param accountSid
     *            the account sid
     */
    private void validateAccountSid(String accountSid) {
        if (accountSid == null || !accountSid.startsWith('AC') || accountSid.length() != 34)
            throw new TwilioRestException('AccountSid \'' + accountSid + '\' is not valid.  It should be the 34 character unique identifier starting with \'AC\'');
    }

    
    /*
     * 
     * Method builders
     */
    /**
     * Builds the method.
     * 
     * @param method
     *            the method
     * @param path
     *            the path
     * @param params
     *            the params
     * @return the http uri request
     */
    private HttpRequest buildMethod(String method, String path,
            Map<String,String> params) {
        if (method.equalsIgnoreCase('GET')) {
            return generateGetRequest(path, params);
        } else if (method.equalsIgnoreCase('POST')) {
            return generatePostRequest(path, params);
        } else if (method.equalsIgnoreCase('PUT')) {
            return generatePutRequest(path, params);
        } else if (method.equalsIgnoreCase('DELETE')) {
            return generateDeleteRequest(path, params);
        } else {
            throw new TwilioRestException('Unknown Method: ' + method);
        }
    }
    
    private HttpRequest buildMethod(String method, String path, List<TwilioNameValuePair> params)
    {
        if (method.equalsIgnoreCase('GET')) {
            return generateGetRequest(path, params);
        } else if (method.equalsIgnoreCase('POST')) {
            return generatePostRequest(path, params);
        } else if (method.equalsIgnoreCase('PUT')) {
            return generatePutRequest(path, params);
        } else if (method.equalsIgnoreCase('DELETE')) {
            return generateDeleteRequest(path, params);
        } else {
            throw new TwilioRestException('Unknown Method: ' + method);
        }
    }

    /**
     * Generate get request.
     * 
     * @param path
     *            the path
     * @param params
     *            the params
     * @return the http get
     */
    private HttpRequest generateGetRequest(String path, Map<String,String> params) {

        URL uri = buildUri(path, params);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('GET');
        return req;
    }
    
    private HttpRequest generateGetRequest(String path, List<TwilioNameValuePair> params) {

        URL uri = buildUri(path, params);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('GET');
        return req;
    }

    /**
     * Generate post request.
     * 
     * @param path
     *            the path
     * @param params
     *            the params
     * @return the http post
     */
    private HttpRequest generatePostRequest(String path, Map<String,String> params) {
        URL uri = buildUri(path);

        String entity = buildEntityBody(params);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('POST');
        req.setBody(entity);

        return req;
    }

    private HttpRequest generatePostRequest(String path, List<TwilioNameValuePair> params) {
        URL uri = buildUri(path);

        String entity = buildEntityBody(params);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('POST');
        req.setBody(entity);

        return req;
    }
    /**
     * Generate put request.
     * 
     * @param path
     *            the path
     * @param params
     *            the params
     * @return the http put
     */
    private HttpRequest generatePutRequest(String path, Map<String,String> params) {
        URL uri = buildUri(path);

        String entity = buildEntityBody(params);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('PUT');
        req.setBody(entity);

        return req;
    }

    private HttpRequest generatePutRequest(String path, List<TwilioNameValuePair> params) {
        URL uri = buildUri(path);

        String entity = buildEntityBody(params);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('PUT');
        req.setBody(entity);

        return req;
    }
    /**
     * Generate delete request.
     * 
     * @param path
     *            the path
     * @param params
     *            the params
     * @return the http delete
     */
    private HttpRequest generateDeleteRequest(String path,
            Map<String,String> params) {
        URL uri = buildUri(path);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('DELETE');
        return req;
    }

    private HttpRequest generateDeleteRequest(String path,List<TwilioNameValuePair> params) {
        URL uri = buildUri(path);

        HttpRequest req = new HttpRequest();
        req.setEndpoint(uri.toExternalForm());
        req.setMethod('DELETE');
        return req;
    }
    /*
     * 
     * Helper functions for building methods
     */
    /**
     * Builds the entity body.
     * 
     * @param params
     *            the params
     * @return the url encoded form entity
     */
    private String buildEntityBody(Map<String,String> params) {
        String entityBody='';
        if (params != null) {
            for (String key : params.keySet()) {
                try {
                    entityBody += (entityBody=='' ? '' : '&')
                                    + key + '=' + EncodingUtil.urlEncode(params.get(key), 'UTF-8');
                } catch (Exception e) {
                    System.debug('ERROR: ' + e);
                }
            }
        }
        return entityBody;
    }

    private String buildEntityBody(List<TwilioNameValuePair> params) {
        String entityBody='';
        if (params != null) {
            for (TwilioNameValuePair param : params) {
                try {
                    entityBody += (entityBody=='' ? '' : '&')
                                    + param.getName() + '=' + EncodingUtil.urlEncode(param.getValue(), 'UTF-8');
                } catch (Exception e) {
                    System.debug('ERROR: ' + e);
                }
            }
        }
        return entityBody;
    }
    /**
     * Builds the uri.
     * 
     * @param path
     *            the path
     * @return the uRI
     */
    private URL buildUri(String path) {
        return buildUri(path, new Map<String,String>());
    }

    /**
     * Builds the uri.
     * 
     * @param path
     *            the path
     * @param queryStringParams
     *            the query string params
     * @return the uRI
     */
    private URL buildUri(String path, Map<String,String> queryStringParams) {
        String sb = path;

        if (queryStringParams != null && queryStringParams.size() > 0) {
            sb += '?';
            sb += buildEntityBody(queryStringParams);
        }

        URL uri;
        try {
            uri = new URL(sb);
        } catch (Exception e) {
            throw new TwilioRestException('Invalid uri: '+sb, e);
        }

        return uri;
    }

    private URL buildUri(String path, List<TwilioNameValuePair> queryStringParams) {
        String sb = path;

        if (queryStringParams != null && queryStringParams.size() > 0) {
            sb += '?';
            sb += buildEntityBody(queryStringParams);
        }

        URL uri;
        try {
            uri = new URL(sb);
        } catch (Exception e) {
            throw new TwilioRestException('Invalid uri: '+sb, e);
        }

        return uri;
    }
    /**
     * sendRequst Sends a REST Request to the Twilio REST API.
     * 
     * @param path
     *            the URL (absolute w.r.t. the endpoint URL - i.e.
     *            /2010-04-01/Accounts)
     * @param method
     *            the HTTP method to use, defaults to GET
     * @param vars
     *            for POST or PUT, a map of data to send, for GET will be
     *            appended to the URL as querystring params
     * 
     *            This method is public for backwards compatibility with the old
     *            twilio helper library
     * @return the twilio rest response
     */
    public TwilioRestResponse request(String path, String method,
            Map<String, String> vars) {

        HttpRequest request = setupRequest(path, method, vars);

        String responseBody;
        Integer statusCode;
        String contentType;
        if (Test.isRunningTest()) {
            // can't execute HTTP requests during test execution
            system.debug('Request :'+request);
            Twilio_TestHTTPMock.Response responseMock = Twilio_TestHTTPMock.getInstance().send(request);
            system.debug(responseMock);
            responseBody = (responseMock.getBody()==null)?'':responseMock.getBody();
            statusCode = responseMock.getStatusCode();
            contentType = responseMock.getHeader('Content-Type');
        } else {
            // execute HTTP request
            HttpResponse response = (new Http()).send(request);
            responseBody = (response.getBody()==null)?'':response.getBody();
            system.debug(responseBody+'-----------------------------------------'+response);
            statusCode = response.getStatusCode();
            contentType = response.getHeader('Content-Type');
        }
        TwilioRestResponse restResponse = new TwilioRestResponse(request.getEndpoint(),
                     responseBody, statusCode);
        restResponse.setContentType(contentType);
            
        return restResponse;
    }

    private static List<TwilioNameValuePair> generateParameters(Map<String, String> vars) 
    {
        List<TwilioNameValuePair> qparams = new List<TwilioNameValuePair>();

        if (vars != null) 
        {
            for (String var : vars.keySet()) 
            {
                qparams.add(new TwilioNameValuePair(var, vars.get(var)));
            }
        }

        return qparams;
    }
        
    public TwilioRestResponse request(String path, String method,List<TwilioNameValuePair> paramList) {
    
        HttpRequest request = setupRequest(path, method, paramList);

                String responseBody;
                Integer statusCode;
                String contentType;
                if (Test.isRunningTest()) {
                        // can't execute HTTP requests during test execution
                    	system.debug('Request :'+request);
                        Twilio_TestHTTPMock.Response responseMock = Twilio_TestHTTPMock.getInstance().send(request);
                        responseBody = (responseMock.getBody()==null)?'':responseMock.getBody();
                        statusCode = responseMock.getStatusCode();
                        contentType = responseMock.getHeader('Content-Type');
                        system.debug('Response Mock :'+responseMock);
                } else {
                        // execute HTTP request
                        HttpResponse response = (new Http()).send(request);
                        responseBody = (response.getBody()==null)?'':response.getBody();
                        system.debug(responseBody+'-----------------------------------------'+response);
                        statusCode = response.getStatusCode();
                        contentType = response.getHeader('Content-Type');
                }
                TwilioRestResponse restResponse = new TwilioRestResponse(request.getEndpoint(),
                                         responseBody, statusCode);
                restResponse.setContentType(contentType);
                        
                return restResponse;
    }
    /**
     * Setup request.
     * 
     * @param path
     *            the path
     * @param method
     *            the method
     * @param vars
     *            the vars
     * @return the http uri request
     */
    private HttpRequest setupRequest(String path, String method,
            Map<String, String> params) {
        
        String normalizedPath = path.toLowerCase();
        String sb = '';

        // If we've given a fully qualified uri then skip building the endpoint
        if (normalizedPath.startsWith('http://')
                || normalizedPath.startsWith('https://')) {
            sb += path;
        } else {
            sb += this.getEndpoint();

            if (!normalizedPath.startsWith('/')) {
                sb += '/';
            }
            sb += path;
        }

        path = sb;
        
        HttpRequest request = buildMethod(method, path, params);

        request.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        request.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
        request.setHeader('Accept', 'application/json');
        request.setHeader('Accept-Charset', 'utf-8');
        request.setHeader('Authorization',
                    'Basic '+EncodingUtil.base64Encode(Blob.valueOf(this.accountSid + ':' + this.authToken)));
        
        return request;
    }
    
    private HttpRequest setupRequest(String path, String method,
            List<TwilioNameValuePair> params) {
        
        String normalizedPath = path.toLowerCase();
        String sb = '';

        // If we've given a fully qualified uri then skip building the endpoint
        if (normalizedPath.startsWith('http://')
                || normalizedPath.startsWith('https://')) {
            sb += path;
        } else {
            sb += this.getEndpoint();

            if (!normalizedPath.startsWith('/')) {
                sb += '/';
            }
            sb += path;
        }

        path = sb;
        
        HttpRequest request = buildMethod(method, path, params);

        request.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
        request.setHeader('User-Agent', 'twilio-salesforce-' + VERSION);
        request.setHeader('Accept', 'application/json');
        
        request.setHeader('Authorization',
                    'Basic '+EncodingUtil.base64Encode(Blob.valueOf(this.accountSid + ':' + this.authToken)));
        
        return request;
    }

    /**
     * Make a request, handles retries + back-off for server/network errors
     * 
     * @param path
     *            the URL (absolute w.r.t. the endpoint URL - i.e.
     *            /2010-04-01/Accounts)
     * @param method
     *            the HTTP method to use, defaults to GET
     * @param vars
     *            for POST or PUT, a map of data to send, for GET will be
     *            appended to the URL as querystring params
     * @return The response
     */
    public TwilioRestResponse safeRequest(String path, String method,
            Map<String, String> vars) {
        TwilioRestResponse response = null;
        for (Integer retry = 0; retry < this.numRetries; retry++) {
            response = request(path, method, vars);
            if (response.isClientError()) {
                System.debug('Twilio REST API Client Error: '+response.getResponseText());
                throw new TwilioRestException(response);
            } else if (response.isServerError()) {
                // TODO handle backoff scenario
                //try {
                //  Thread.sleep(100 * retry); // Backoff on our sleep
                //} catch (Exception e) {
                //}
                continue;
            }

            return response;
        }
        Integer errorCode = response == null ? -1 : response.getHttpStatus();
        throw new TwilioRestException('Cannot fetch: ' + method + ' ' + path,
                errorCode);
    }

    public TwilioRestResponse safeRequestPair(String path, String method,
            List<TwilioNameValuePair> paramList) 
    {
        TwilioRestResponse response = null;
        for (Integer retry = 0; retry < this.numRetries; retry++) 
        {
            response = request(path, method, paramList);    
        if (response.isClientError()) {
                System.debug('Twilio REST API Client Error: '+response.getResponseText());
                throw new TwilioRestException(response);
            } else if (response.isServerError()) {
                 continue;
            }

            return response;
        }
        Integer errorCode = response == null ? -1 : response.getHttpStatus();
        throw new TwilioRestException('Cannot fetch: ' + method + ' ' + path,
                errorCode);
    }
    
    /**
     * Perform a GET request against the given fully qualified uri.
     * 
     * @param fullUri  the full uri, including protocol://hostname/path
     * @return         the response from the query
     */
    public TwilioRestResponse get(String fullUri) {
        TwilioRestResponse response = null;

        for (Integer retry = 0; retry < this.numRetries; retry++) {
            response = request(fullUri, 'GET', new Map<String,String>());
            if (response.isClientError()) {
                throw new TwilioRestException(response);
            } else if (response.isServerError()) {
                //try {
                //  Thread.sleep(100 * retry); // Backoff on our sleep
                //} catch (InterruptedException e) {
                //}
                continue;
            }

            return response;
        }
        Integer errorCode = response == null ? -1 : response.getHttpStatus();
        throw new TwilioRestException('Cannot fetch: ' + fullUri + ' ',
                errorCode);
    }

    /**
     * Get the current endpoint this client is pointed at.
     * 
     * @return String the api endpoint
     */
    public String getEndpoint() {
        return endpoint;
    }

    /**
     * Set the endpoint this rest client uses.
     * 
     * @param endpoint
     *            The location of the endpoint (e.g. https://api.twilio.com)
     */
    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    /*
     * Resource related methods
     */
    /**
     * Get a list of Account objects.
     *
     * For more info see http://www.twilio.com/docs/api/rest/account
     * 
     * @param params
     *            Filter the list with the given params. See the Twilio docs for
     *            available filters.
     * @return the list of accounts.
     */
    public TwilioAccountList getAccounts(Map<String, String> params) {
        TwilioAccountList aclist = new TwilioAccountList(this, params);
        aclist.setRequestAccountSid(this.accountSid);
        return aclist;
    }

    /**
     * Get all accounts.
     *
     * For more info see http://www.twilio.com/docs/api/rest/account
     * 
     * @return the list of accounts.
     */
    public TwilioAccountList getAccounts() {
        return this.getAccounts(new Map<String, String>());
    }

    /**
     * A shortcut for the most common case, returning the Account object for
     * this authenticated client.
     * 
     * @return Account that maps to the authenticated account.
     */
    public TwilioAccount getAccount() {
        return this.authAccount;
    }
/*shs
    public TwilioAccount getAccount(map<string,string> s) {     
        TwilioAccount account = new TwilioAccount(this,s);

        return account;
    }
    */
    /**
     * Get an account by account sid.
     * 
     * @param sid
     *            The sid of the account you want to fetch.
     * @return the account
     */
    public TwilioAccount getAccount(String sid) {
        TwilioAccount account = new TwilioAccount(this);
        account.setSid(sid);
        account.setRequestAccountSid(sid);

        return account;
    }

    public String getAccountSid() {
        return this.accountSid;
    }
    
    /**
     * Validate the signature on an incoming call from Twilio
     *
     * @param expectedSignature 
     *      The received signature. In an Apex REST method, this will be
     *      <code>RestContext.request.headers.get('X-Twilio-Signature')</code>.
     *              
     * @param url 
     *      The endpoint URL, for example 
     *      <code>https://mysite.force.com/services/apexrest/twiliosms</code>.
     *      In an Apex REST method, this will be <code>'https://' + 
     *      RestContext.request.headers.get('Host') + '/services/apexrest' + 
     *      RestContext.request.requestURI</code>.
     *
     * @param params 
     *      The params map from the incoming message. In an Apex REST method, 
     *      this will be <code>RestContext.request.params</code>.
     *
     * @return true if the signature is valid, false otherwise
     */
    public boolean validateRequest(String expectedSignature, String url, Map<String,String> params) {
        try {
            // sort the params alphabetically, and append the key and value of each to the url
            String data = url;        
            if(params!=null){
                List<String> sortedKeys = new List<String>(params.keySet());
                sortedKeys.sort();
                
                for (String s: sortedKeys) {
                    data += s;
                    String v='';
                    if (params.get(s)!=null)
                        v=params.get(s);
                    data += v;
                }
            }

            //compute the hmac on input data bytes, with AuthToken as key
            Blob mac = Crypto.generateMac('hmacSHA1', Blob.valueOf(data), Blob.valueOf(authToken));
           
            //base64-encode the hmac
            String signature = EncodingUtil.base64Encode(mac);
            
            return signature.equals(expectedSignature);
        } catch (Exception e) {
            return false;
        }
    }
}