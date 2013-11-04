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
@isTest
private class Twilio_TestRest {

    final static String accountSid = 'AC03c2fcd60e144e7cbeed179fcbf812a3';
    final static String authToken = '12345678901234567890123456789012';
    
    static testMethod void testTwilioRestResponse() {
        String url = 'https://api.twilio.com';
        String queryString = 'a=1&b=2';
        String responseText = 'This is a test';
        TwilioRestResponse response = new TwilioRestResponse(url+'?'+queryString,responseText,200);
        
        System.assertEquals(url, response.getUrl());
        System.assertEquals(responseText, response.getResponseText());
        System.assertEquals(200, response.getHttpStatus());
        System.assertEquals(queryString, response.getQueryString());
        System.assertEquals(false, response.isError());
        System.assertEquals(false, response.isClientError());
        System.assertEquals(false, response.isServerError());
        System.assertEquals(false, response.isJson());
        System.assertEquals(false, response.isXml());
        
        response.setError(true);
        System.assert(response.isError());
        
        response.setHttpStatus(400);
        System.assertEquals(400, response.getHttpStatus());
        System.assertEquals(true, response.isClientError());
        System.assertEquals(false, response.isServerError());
        
        response.setHttpStatus(503);
        System.assertEquals(503, response.getHttpStatus());
        System.assertEquals(false, response.isClientError());
        System.assertEquals(true, response.isServerError());
        
        String json = '{"foo":1,"bar":2}';
        response.setResponseText(json);
        System.assertEquals(json, response.getResponseText());
        
        response.setContentType('application/json');
        System.assertEquals(true, response.isJson());
        System.assertEquals(false, response.isXml());
        Map<String,Object> jsonMap = response.toMap();
        System.assertEquals(2, jsonMap.size());
        System.assert(jsonMap.containsKey('foo'));
        System.assert(jsonMap.containsKey('bar'));
        System.assertEquals('1', jsonMap.get('foo'));
        System.assertEquals('2', jsonMap.get('bar'));
        
        response.setContentType('application/xml');
        System.assertEquals(false, response.isJson());
        System.assertEquals(true, response.isXml());
        
        Exception restEx = null;
        try {
            Map<String,Object> xmlMap = response.toMap();
        } catch (Exception e) {
            restEx = e;
        }
        System.assert(restEx instanceof TwilioRestException);
        
        
        response.setUrl('test');
        System.assertEquals('test', response.getUrl());
        
        response.setQueryString('test');
        System.assertEquals('test', response.getQueryString());
    }
    
    static testmethod void testTwilioRestClient() {
        TwilioRestClient client = new TwilioRestClient(accountSid, authToken);
        
        client.setNumRetries(3);
        System.assertEquals(3, client.getNumRetries());
        
        Exception e = null;
        try {
            client.safeRequest('https://api.twilio.com', 'PUT', new Map<String,String>{'key'=>'val'});
        } catch (TwilioRestException tre) {
            e = tre;
        }
        System.assert(e instanceof TwilioRestException);
        
        e = null;
        try {
            client.safeRequest('https://api.twilio.com', 'DELETE', null);
        } catch (TwilioRestException tre) {
            e = tre;
        }
        System.assert(e instanceof TwilioRestException);        
        
        client = new TwilioRestClient(accountSid,authToken,'https://anotherendpoint.twilio.com');
        System.assertEquals('https://anotherendpoint.twilio.com', client.getEndpoint());
        
        e = null;
        try {
            client = new TwilioRestClient(null,authToken);
        } catch (TwilioRestException tre) {
            e = tre;
        }
        System.assert(e instanceof TwilioRestException);
        
        e = null;
        try {
            client = new TwilioRestClient('badSid',authToken);
        } catch (TwilioRestException tre) {
            e = tre;
        }
        System.assert(e instanceof TwilioRestException);
        
        e = null;
        try {
            client = new TwilioRestClient('ACbadSid',authToken);
        } catch (TwilioRestException tre) {
            e = tre;
        }
        System.assert(e instanceof TwilioRestException);
        
        e = null;
        try {
            client = new TwilioRestClient(accountSid,null);
        } catch (TwilioRestException tre) {
            e = tre;
        }
        System.assert(e instanceof TwilioRestException);
        
        e = null;
        try {
            client = new TwilioRestClient(accountSid,'badToken');
        } catch (TwilioRestException tre) {
            e = tre;
        }
        System.assert(e instanceof TwilioRestException);    
    }
    
    static testmethod void testValidateRequest() {
        //The Twilio authToken is the encryption key
        String methodAuthToken = '1c892n40nd03kdnc0112slzkl3091j20';
        TwilioRestClient client = new TwilioRestClient(accountSid,methodAuthToken);
        
        // This is the signature we expect
        String expected_sig = 'fF+xx6dTinOaCdZ0aIeNkHr/ZAA=';
        
        //This is the url that twilio requested
        String url = 'http://www.postbin.org/1ed898x';

        //These are the post params twilio sent in its request
        Map<String,String> params = new Map<String,String>{
            'AccountSid'=>'AC9a9f9392lad99kla0sklakjs90j092j3',
            'ApiVersion'=>'2010-04-01',
            'CallSid'=>'CAd800bb12c0426a7ea4230e492fef2a4f',
            'CallStatus'=>'ringing',
            'Called'=>'+15306384866',
            'CalledCity'=>'OAKLAND',
            'CalledCountry'=>'US',
            'CalledState'=>'CA',
            'CalledZip'=>'94612',
            'Caller'=>'+15306666666',
            'CallerCity'=>'SOUTH LAKE TAHOE',
            'CallerCountry'=>'US',
            'CallerName'=>'CA Wireless Call',
            'CallerState'=>'CA',
            'CallerZip'=>'89449',
            'Direction'=>'inbound',
            'From'=>'+15306666666',
            'FromCity'=>'SOUTH LAKE TAHOE',
            'FromCountry'=>'US',
            'FromState'=>'CA',
            'FromZip'=>'89449',
            'To'=>'+15306384866',
            'ToCity'=>'OAKLAND',
            'ToCountry'=>'US',
            'ToState'=>'CA',
            'ToZip'=>'94612'
        };
        boolean result = client.validateRequest(expected_sig, url, params);

        System.assertEquals(true,result);
        
        // Now tamper with something, and the result should be false
        params.put('CalledState', 'NV');
        result = client.validateRequest(expected_sig, url, params);

        System.assertEquals(false,result);
        
        // Pass nulls, and the result should still be false
        result = client.validateRequest(null, null, null);

        System.assertEquals(false,result);
    }
}