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
/** This class allows you to inject an HTTPResponse-like object into the
  * HTTP-like service that will be called by TwilioRestClient during tests only.
  * By knowing what method and URI the code will request from HTTP, you can ensure
  * it gets an appropriate response during your test. 
  *
  * Usage:
  *    Twilio_TestHTTPMock.getInstance().putResponse(
  *         'GET',
  *         'https://api.twilio.com/2010-04-01/Accounts/ACbaabc55eacf55afdae555e555c5cc55a.json',
  *         new Twilio_TestHTTPMock.Response(
  *             '{ "sid": "ACbaabc55eacf55afdae555e555c5cc55a","friendly_name": "My Test Account" }',
  *             200)
  *         );
  */
public class Twilio_TestHTTPMock {

    /** singleton */
    private final static Twilio_TestHTTPMock instance = new Twilio_TestHTTPMock();
    /** get singleton */
    public static Twilio_TestHTTPMock getInstance() { return Twilio_TestHTTPMock.instance; }

    /** 404 NOT FOUND error */
    private static Response response404 = new Response('{"status": 404, "message": "The requested resource was not found"}', 404);

    /** instance methods */
    private Map<String,Map<String,Response>> methodMap = new Map<String,Map<String,Response>>();
    
    /** Mock HTTP.send(HTTPRequest) function, returns a preregistered Response or a 404 */
    public Response send(HTTPRequest req) {
        System.debug('Twilio_TestHTTPMock::send() Request.Method: '+req.getMethod());
        System.debug('Twilio_TestHTTPMock::send() Request.Endpoint: '+req.getEndpoint());

        Response res = getResponse(req.getMethod(), req.getEndpoint());
        if (res==null) {
            res = response404;      
        }
        System.debug('Twilio_TestHTTPMock::send() Response.Body: '+res.getBody());

        return res;
    }
    
    /** Looks up the response for a specific HTTP method and URI. Returns null if none found. */
    public Response getResponse(String method, String uri) {
        Response res = null;
        Map<String,Response> resourceMap = this.methodMap.get(method.toUpperCase());        
        if (resourceMap!=null) {
            res = resourceMap.get(uri.toUpperCase());
            system.debug('uri:'+uri.toUpperCase());
            system.debug('Resource Map:'+resourceMap+' , Keys :'+resourceMap.keySet());
            if (res!=null) {
                System.debug('Twilio_TestHTTPMock::getResponse() Found Resource for '+method+' '+uri+' = '+res);
            } else {
                System.debug('Twilio_TestHTTPMock::getResponse() Did not find Resource for '+method+' '+uri);
            }
        } else {
            System.debug('Twilio_TestHTTPMock::getResponse() Did not find Resource Map for '+method);
        }
        return res;
    }
    
    /** Registers a response to be returned for a particular HTTP method and URI */
    public void putResponse(String method, String uri, Response res) {
        String methodKey = method.toUpperCase();
        String uriKey = uri.toUpperCase();
        
        Map<String,Response> resourceMap = this.methodMap.get(methodKey);
        if (resourceMap==null) {
            resourceMap = new Map<String,Response>();
            this.methodMap.put(methodKey, resourceMap);
            
        }
        resourceMap.put(uriKey,res);
        system.debug('Put ResourceMap:'+resourceMap);
        System.debug('Twilio_TestHTTPMock::putResponse() Added resource '+methodKey+' '+uriKey);
        
    }
    
    /** Response class - mock equivalent to HTTPResponse */
    public class Response {
        
        private String body;
        private final Map<String,String> headers = new Map<String,String>();
        private Integer statusCode;
        
        public Response(String body, Integer statusCode) {
            this.body = body;
            this.statusCode = statusCode;
            this.headers.put('Content-Type','application/json'); // default
        }
        
        public void setHeader(String key, String value)
        {
            this.headers.put(key,value);
        }
        
        public Integer getStatusCode() {
            return this.statusCode;
        }
        
        public String getBody() {
            return this.body;
        }
        
        public String getHeader(String name) {
            return headers.get(name);
        }
    }
}