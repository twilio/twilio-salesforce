@isTest
private class Twilio_TestRest {

	final static String accountSid = 'AC03c2fcd60e144e7cbeed179fcbf812a3';
	final static String authToken = '12345678901234567890123456789012';
	
    static testMethod void testTwilioRestResponse() {
        String url = 'http://api.twilio.com';
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
    	TwilioRestClient client = (new TwilioAPI()).getClient();
    	
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
}