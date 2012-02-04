@isTest
private class Twilio_TestRest {

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
    	
    	// TODO assert PUT
    	try {
	    	client.safeRequest('https://api.twilio.com', 'PUT', new Map<String,String>{'key'=>'val'});
    	} catch (TwilioRestException tre) {
    		
    	}
    	// TODO assert DELETE
    	try {
    		client.safeRequest('https://api.twilio.com', 'DELETE', null);
    	} catch (TwilioRestException tre) {
    		
    	}
    }
}