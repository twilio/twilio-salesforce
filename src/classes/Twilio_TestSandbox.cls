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
private class Twilio_TestSandbox {

	final static String authToken = '12345678901234567890123456789012';
	
    static testmethod void testTwilioSandbox_get() {
        String json='{"pin": "63729915",'
			+'"account_sid": "AC03c2fcd60e144e7cbeed179fcbf812a3",'
			+'"phone_number": "+14154132865",'
			+'"application_sid": "AP1d510128c851af26b0a14d50b5577e69",'
			+'"voice_url": "http://demo.twilio.com/welcome",'
			+'"voice_method": "GET",'
			+'"sms_url": "http://demo.twilio.com/welcome/sms",'
			+'"sms_method": "POST",'
			+'"status_callback": "",'
			+'"status_callback_method": "POST",'
			+'"date_created": "Mon, 10 Nov 2008 20:52:56 +0000",'
			+'"date_updated": "Mon, 11 Nov 2008 20:52:56 +0000",'
			+'"api_version": "2010-04-01",'
			+'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Sandbox.json"}';
       
       
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Sandbox.json',
			new Twilio_TestHTTPMock.Response(json,200)
			);
			
		// Get an API client and request the Twilio Call
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
        TwilioSandbox sandbox = client.getAccount().getSandbox();
        
        // assert correct behavior
        System.assertEquals('63729915',sandbox.getPin());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',sandbox.getAccountSid());
        System.assertEquals('+14154132865',sandbox.getPhoneNumber());
        System.assertEquals('AP1d510128c851af26b0a14d50b5577e69',sandbox.getApplicationSid());
        System.assertEquals('2010-04-01',sandbox.getApiVersion());
        System.assertEquals('http://demo.twilio.com/welcome',sandbox.getVoiceUrl());
        System.assertEquals('GET',sandbox.getVoiceMethod());
        System.assertEquals('http://demo.twilio.com/welcome/sms',sandbox.getSmsUrl());
        System.assertEquals('POST',sandbox.getSmsMethod());
        System.assertEquals('',sandbox.getStatusCallback());
        System.assertEquals('POST',sandbox.getStatusCallbackMethod());
        System.assertEquals(Datetime.newInstanceGmt(2008,11,10,20,52,56),sandbox.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2008,11,11,20,52,56), sandbox.getDateUpdated());
        System.assertEquals('/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Sandbox.json',sandbox.getUri());
        
        TwilioSandbox sandbox1 = new TwilioSandbox(client,new map<string,object>());
    }
    
    static testmethod void testTwilioSandbox_post() {
        String json='{"pin": "63729915",'
			+'"account_sid": "AC03c2fcd60e144e7cbeed179fcbf812a3",'
			+'"phone_number": "+14154132865",'
			+'"application_sid": "AP1d510128c851af26b0a14d50b5577e69",'
			+'"voice_url": "http://demo.twilio.com/welcome",'
			+'"voice_method": "POST",'
			+'"sms_url": "http://demo.twilio.com/welcome/sms",'
			+'"sms_method": "POST",'
			+'"status_callback": "",'
			+'"status_callback_method": "POST",'
			+'"date_created": "Mon, 10 Nov 2008 20:52:56 +0000",'
			+'"date_updated": "Mon, 11 Nov 2008 20:52:56 +0000",'
			+'"api_version": "2010-04-01",'
			+'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Sandbox.json"}';
       
       
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Sandbox.json',
			new Twilio_TestHTTPMock.Response(json,201)
			);
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Sandbox.json',
			new Twilio_TestHTTPMock.Response(json,200)
			);	
		
		Map<String,String> params = new Map<String,String>{
				'voice_method' => 'POST'
			};
		
		// Get an API client and request the Twilio Call
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
		client.getAccount().getSandbox().updateResource(params);
        TwilioSandbox sandbox = client.getAccount().getSandbox();
        		
        // assert correct behavior
        System.assertEquals('63729915',sandbox.getPin());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',sandbox.getAccountSid());
        System.assertEquals('+14154132865',sandbox.getPhoneNumber());
        System.assertEquals('AP1d510128c851af26b0a14d50b5577e69',sandbox.getApplicationSid());
        System.assertEquals('2010-04-01',sandbox.getApiVersion());
        System.assertEquals('http://demo.twilio.com/welcome',sandbox.getVoiceUrl());
        System.assertEquals('POST',sandbox.getVoiceMethod());
        System.assertEquals('http://demo.twilio.com/welcome/sms',sandbox.getSmsUrl());
        System.assertEquals('POST',sandbox.getSmsMethod());
        System.assertEquals('',sandbox.getStatusCallback());
        System.assertEquals('POST',sandbox.getStatusCallbackMethod());
        System.assertEquals(Datetime.newInstanceGmt(2008,11,10,20,52,56),sandbox.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2008,11,11,20,52,56), sandbox.getDateUpdated());
        System.assertEquals('/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Sandbox.json',sandbox.getUri());
    }
}