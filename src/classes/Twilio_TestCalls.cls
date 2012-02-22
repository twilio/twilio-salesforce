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
class Twilio_TestCalls {

	final static String authToken = '12345678901234567890123456789012';
	
    static testmethod void testTwilioCall_get() {
        // create the response body to be returned when the Call URI is requested
		String json='{"sid":"CA5ea9c5d78e1f35fc01c204682d056e22","date_created":"Mon, 02 Jan 2012 06:41:14 +0000","date_updated":"Mon, 02 Jan 2012 06:41:42 '
        	+'+0000","parent_call_sid":"CA39f78143e0374332b21c9b256e6d4e9a","account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3","to":"+918722266660",'
        	+'"to_formatted":"+918722266660","from":"+919902400323","from_formatted":"+919902400323","phone_number_sid":'
	        +'"PN17c8630939e44e7e92a45c51bcdb7122","status":"completed","start_time":"Mon, 02 Jan 2012 06:41:33 +0000",'
	        +'"end_time":"Mon, 02 Jan 2012 06:41:42 +0000","duration":"9","price":"-0.09000",'
	        +'"direction":"outbound-dial","answered_by":null,"api_version":"2010-04-01","annotation":null,'
	        +'"forwarded_from":"","group_sid":null,"caller_name":null,"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22.json",'
	        +'"subresource_uris":{"notifications":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22/Notifications.json",'
	        +'"recordings":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22/Recordings.json"}}';
       
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22.json',
			new Twilio_TestHTTPMock.Response(json,200)
			);
			
		// Get an API client and request the Twilio Call
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
        TwilioCall call = client.getAccount().getCall('CA5ea9c5d78e1f35fc01c204682d056e22');
        
        // assert correct behavior
        System.assertEquals('completed',call.getStatus());
        System.assertEquals('CA5ea9c5d78e1f35fc01c204682d056e22',call.getSid());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',call.getAccountSid());
        System.assertEquals(Datetime.newInstanceGmt(2012,01,02,06,41,14),call.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,01,02,06,41,42), call.getDateUpdated());
        System.assertEquals('CA39f78143e0374332b21c9b256e6d4e9a',call.getParentCallSid());
        System.assertEquals('+918722266660',call.getTo());
        System.assertEquals('+919902400323',call.getFrom());
        System.assertEquals('PN17c8630939e44e7e92a45c51bcdb7122',call.getPhoneNumberSid());
        System.assertEquals(Datetime.newInstanceGmt(2012,01,02,06,41,33),call.getStartTime());
        System.assertEquals(Datetime.newInstanceGmt(2012,01,02,06,41,42),call.getEndTime());
        System.assertEquals(9,call.getDuration());
        System.assertEquals(-0.09,call.getPrice());
        System.assertEquals('outbound-dial',call.getDirection());
        System.assertEquals('',call.getForwardedFrom());
        System.assertEquals(null,call.getCallerName());
        System.assertEquals(null,call.getAnsweredBy());
        
        System.assertEquals('/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22/Recordings.json', call.getSubresourceUris().get('recordings'));
        System.assertEquals('/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22/Recordings.json', call.getRecordings().getResourceLocation());
        System.assertEquals('/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22/Notifications.json', call.getSubresourceUris().get('notifications'));
        System.assertEquals('/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22/Notifications.json', call.getNotifications().getResourceLocation());
    }
    
    static testmethod void testTwilioCall_post() {
        String json=
    		'{"sid": "CA5ea9c5d78e1f35fc01c204682d056e22",'
    		+'"date_created": "Tue, 10 Aug 2010 08:02:17 +0000",'
		    +'"date_updated": "Tue, 10 Aug 2010 08:02:47 +0000",'
		    +'"parent_call_sid": null,'
		    +'"account_sid": "AC03c2fcd60e144e7cbeed179fcbf812a3",'
		    +'"to": "+14153855708",'
		    +'"from": "+14158141819",'
		    +'"phone_number_sid": null,'
		    +'"status": "completed",'
		    +'"start_time": "Tue, 10 Aug 2010 08:02:31 +0000",'
		    +'"end_time": "Tue, 10 Aug 2010 08:02:47 +0000",'
		    +'"duration": "16",'
		    +'"price": "-0.03000",'
		    +'"direction": "outbound-api",'
		    +'"answered_by": null,'
		    +'"api_version": "2010-04-01",'
		    +'"annotation": null,'
		    +'"forwarded_from": null,'
		    +'"caller_name": null,'
		    +'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22.json",'
		    +'"subresource_uris":{'
		        +'"notifications": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22/Notifications.json",'
		        +'"recordings": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22/Recordings.json"'
		    +'}}';
       
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22.json',
			new Twilio_TestHTTPMock.Response(json,201)
			);
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5ea9c5d78e1f35fc01c204682d056e22.json',
			new Twilio_TestHTTPMock.Response(json,200)
			);
			
		// define fields to update
		Map<String,String> params = new Map<String,String> {
				'Status' => 'completed'
			};
			
		// Get an API client and request the Twilio Call
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
        client.getAccount().getCall('CA5ea9c5d78e1f35fc01c204682d056e22').updateResource(params);
        TwilioCall call = client.getAccount().getCall('CA5ea9c5d78e1f35fc01c204682d056e22');
        
        // assert correct behavior
        System.assertEquals('completed',call.getStatus());
        System.assertEquals('CA5ea9c5d78e1f35fc01c204682d056e22',call.getSid());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',call.getAccountSid());
        System.assertEquals(Datetime.newInstanceGmt(2010,08,10,08,02,17),call.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2010,08,10,08,02,47), call.getDateUpdated());
        System.assertEquals(null,call.getParentCallSid());
        System.assertEquals('+14153855708',call.getTo());
        System.assertEquals('+14158141819',call.getFrom());
        System.assertEquals(null,call.getPhoneNumberSid());
        System.assertEquals(Datetime.newInstanceGmt(2010,08,10,08,02,31),call.getStartTime());
        System.assertEquals(Datetime.newInstanceGmt(2010,08,10,08,02,47),call.getEndTime());
        System.assertEquals(16,call.getDuration());
        System.assertEquals(-0.03,call.getPrice());
        System.assertEquals('outbound-api',call.getDirection());
        System.assertEquals(null,call.getForwardedFrom());
        System.assertEquals(null,call.getCallerName());
        System.assertEquals(null,call.getAnsweredBy());
    }
    
    static testmethod void testTwilioCall_redirect()
    {
    	String json=
    		'{"sid": "CAe1644a7eed5088b159577c5802d8be38",'
    		+'"date_created": "Tue, 10 Aug 2010 08:02:17 +0000",'
		    +'"date_updated": "Tue, 10 Aug 2010 08:02:47 +0000",'
		    +'"parent_call_sid": null,'
		    +'"account_sid": "AC5ef872f6da5a21de157d80997a64bd33",'
		    +'"to": "+14153855708",'
		    +'"from": "+14158141819",'
		    +'"phone_number_sid": null,'
		    +'"status": "in-progress",'
		    +'"start_time": "Tue, 10 Aug 2010 08:02:31 +0000",'
		    +'"end_time": "Tue, 10 Aug 2010 08:02:47 +0000",'
		    +'"duration": "16",'
		    +'"price": "-0.03000",'
		    +'"direction": "outbound-api",'
		    +'"answered_by": null,'
		    +'"api_version": "2010-04-01",'
		    +'"annotation": null,'
		    +'"forwarded_from": null,'
		    +'"caller_name": null,'
		    +'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38.json",'
		    +'"subresource_uris":{'
		        +'"notifications": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38/Notifications.json",'
		        +'"recordings": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38/Recordings.json"'
		    +'}}';
    	
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38.json',
			new Twilio_TestHTTPMock.Response(json,201)
			);
		TwilioRestClient client = new TwilioRestClient('AC5ef872f6da5a21de157d80997a64bd33',authToken);		
		Twiliocall call = client.getAccount().getCall('CAe1644a7eed5088b159577c5802d8be38').redirect('http://www.myapp.com/myhandler.php','POST');
		
		System.assertEquals('in-progress',call.getStatus());
        System.assertEquals('CAe1644a7eed5088b159577c5802d8be38',call.getSid());
        System.assertEquals('AC5ef872f6da5a21de157d80997a64bd33',call.getAccountSid());
    }
    
    
    static testmethod void testTwilioCall_hangup()
    {
    	String json=
    		'{"sid": "CAe1644a7eed5088b159577c5802d8be38",'
    		+'"date_created": "Tue, 10 Aug 2010 08:02:17 +0000",'
		    +'"date_updated": "Tue, 10 Aug 2010 08:02:47 +0000",'
		    +'"parent_call_sid": null,'
		    +'"account_sid": "AC5ef872f6da5a21de157d80997a64bd33",'
		    +'"to": "+14153855708",'
		    +'"from": "+14158141819",'
		    +'"phone_number_sid": null,'
		    +'"status": "completed",'
		    +'"start_time": "Tue, 10 Aug 2010 08:02:31 +0000",'
		    +'"end_time": "Tue, 10 Aug 2010 08:02:47 +0000",'
		    +'"duration": "16",'
		    +'"price": "-0.03000",'
		    +'"direction": "outbound-api",'
		    +'"answered_by": null,'
		    +'"api_version": "2010-04-01",'
		    +'"annotation": null,'
		    +'"forwarded_from": null,'
		    +'"caller_name": null,'
		    +'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38.json",'
		    +'"subresource_uris":{'
		        +'"notifications": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38/Notifications.json",'
		        +'"recordings": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38/Recordings.json"'
		    +'}}';
    	
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38.json',
			new Twilio_TestHTTPMock.Response(json,201)
			);

		TwilioRestClient client = new TwilioRestClient('AC5ef872f6da5a21de157d80997a64bd33',authToken);		
		Twiliocall call = client.getAccount().getCall('CAe1644a7eed5088b159577c5802d8be38').hangup();
		
		System.assertEquals('completed',call.getStatus());
        System.assertEquals('CAe1644a7eed5088b159577c5802d8be38',call.getSid());
        System.assertEquals('AC5ef872f6da5a21de157d80997a64bd33',call.getAccountSid());
    }
    
    static testmethod void testTwilioCall_cancel()
    {
    	String json=
    		'{"sid": "CAe1644a7eed5088b159577c5802d8be38",'
    		+'"date_created": "Tue, 10 Aug 2010 08:02:17 +0000",'
		    +'"date_updated": "Tue, 10 Aug 2010 08:02:47 +0000",'
		    +'"parent_call_sid": null,'
		    +'"account_sid": "AC5ef872f6da5a21de157d80997a64bd33",'
		    +'"to": "+14153855708",'
		    +'"from": "+14158141819",'
		    +'"phone_number_sid": null,'
		    +'"status": "completed",'
		    +'"start_time": "Tue, 10 Aug 2010 08:02:31 +0000",'
		    +'"end_time": "Tue, 10 Aug 2010 08:02:47 +0000",'
		    +'"duration": "16",'
		    +'"price": "-0.03000",'
		    +'"direction": "outbound-api",'
		    +'"answered_by": null,'
		    +'"api_version": "2010-04-01",'
		    +'"annotation": null,'
		    +'"forwarded_from": null,'
		    +'"caller_name": null,'
		    +'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38.json",'
		    +'"subresource_uris":{'
		        +'"notifications": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38/Notifications.json",'
		        +'"recordings": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38/Recordings.json"'
		    +'}}';
    	
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Calls/CAe1644a7eed5088b159577c5802d8be38.json',
			new Twilio_TestHTTPMock.Response(json,201)
			);

		TwilioRestClient client = new TwilioRestClient('AC5ef872f6da5a21de157d80997a64bd33',authToken);		
		Twiliocall call = client.getAccount().getCall('CAe1644a7eed5088b159577c5802d8be38').cancel();
		
		System.assertEquals('completed',call.getStatus());
        System.assertEquals('CAe1644a7eed5088b159577c5802d8be38',call.getSid());
        System.assertEquals('AC5ef872f6da5a21de157d80997a64bd33',call.getAccountSid());
    }
    
    
    
    static testmethod void testTwilioCallList_get() {      
        // create the response body to be returned when the Calls URI is requested
		String json='{"calls":[{"sid":"CA62efc923742a4c40beeca377581f4a55","date_created":"Tue, 27 Dec 2011 09:54:38 +0000","date_updated":"Tue, 27 Dec 2011 09:54:38 +0000",'
	        +'"parent_call_sid":null,"account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3","to":"+15108706378","to_formatted":"(510) 870-6378","from":"+14157234000",'
	        +'"from_formatted":"(415) 723-4000","phone_number_sid":null,"status":"no-answer","start_time":"Tue, 27 Dec 2011 09:54:38 +0000","end_time":null,'
	        +'"duration":null,"price":null,"direction":"outbound-api","answered_by":null,"annotation":null,"api_version":"2010-04-01","forwarded_from":null,'
	        +'"group_sid":null,"caller_name":null,"uri":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCA62efc923742a4c40beeca377581f4a55.json","subresource_uris":'
	        +'{"notifications":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCA62efc923742a4c40beeca377581f4a55Notifications.json",'
	        +'"recordings":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCA62efc923742a4c40beeca377581f4a55Recordings.json"}},'
	        +'{"sid":"CAdd42863f1f474cd690ecd98aba3a0c14","date_created":"Tue, 27 Dec 2011 09:25:58 +0000","date_updated":"Tue, 27 Dec 2011 09:25:58 +0000","parent_call_sid":null,"account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3","to":"+15108706378","to_formatted":"(510) 870-6378","from":"+14157234000","from_formatted":"(415) 723-4000","phone_number_sid":null,"status":"no-answer","start_time":"Tue, 27 Dec 2011 09:25:58 +0000","end_time":null,"duration":null,"price":null,"direction":"outbound-api","answered_by":null,"annotation":null,"api_version":"2010-04-01","forwarded_from":null,"group_sid":null,"caller_name":null,"uri":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCAdd42863f1f474cd690ecd98aba3a0c14.json","subresource_uris":{"notifications":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCAdd42863f1f474cd690ecd98aba3a0c14Notifications.json","recordings":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCAdd42863f1f474cd690ecd98aba3a0c14Recordings.json"}},'
	        +'{"sid":"CA001697081686d17bf58a1e9bcf848fcd","date_created":"Tue, 27 Dec 2011 07:14:46 +0000","date_updated":"Tue, 27 Dec 2011 07:14:58 +0000","parent_call_sid":null,"account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3","to":"","to_formatted":"","from":"client:sandbox","from_formatted":"sandbox","phone_number_sid":"","status":"completed","start_time":"Tue, 27 Dec 2011 07:14:46 +0000","end_time":"Tue, 27 Dec 2011 07:14:58 +0000","duration":"12","price":"-0.00250","direction":"inbound","answered_by":null,"annotation":null,"api_version":"2010-04-01","forwarded_from":"","group_sid":null,"caller_name":null,"uri":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCA001697081686d17bf58a1e9bcf848fcd.json","subresource_uris":{"notifications":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCA001697081686d17bf58a1e9bcf848fcdNotifications.json","recordings":"2010-04-01AccountsAC03c2fcd60e144e7cbeed179fcbf812a3CallsCA001697081686d17bf58a1e9bcf848fcdRecordings.json"}}],"page":0,"total":3}';
        
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call List URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json',
			new Twilio_TestHTTPMock.Response(json,200)
			);
        
        // Get an API client and request the Twilio Call List
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
        TwilioCallList twcalls = client.getAccount().getCalls();
        List<TwilioCall> calls = twcalls.getPageData();
        
        // assert correct behavior
        System.assertEquals(3,calls.size());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',calls[0].getAccountSid());
        System.assertEquals('CA62efc923742a4c40beeca377581f4a55',calls[0].getSid());
        System.assertEquals('CAdd42863f1f474cd690ecd98aba3a0c14',calls[1].getSid());        
         
        System.assertEquals(Datetime.newInstanceGmt(2011,12,27,09,54,38),calls[0].getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2011,12,27,09,54,38),calls[0].getDateUpdated());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',calls[0].getAccountSid());
        System.assertEquals('+15108706378',calls[0].getTo());
        System.assertEquals('+14157234000',calls[0].getFrom());
        System.assertEquals(null,calls[0].getPhoneNumberSid());
        System.assertEquals('no-answer',calls[0].getStatus());
        System.assertEquals(Datetime.newInstanceGmt(2011,12,27,09,54,38),calls[0].getStartTime());
        System.assertEquals(null,calls[0].getEndTime());
        System.assertEquals(null,calls[0].getDuration());
        System.assertEquals(null,calls[0].getPrice());
        System.assertEquals('outbound-api',calls[0].getDirection());
        System.assertEquals(null,calls[0].getAnsweredBy());
        System.assertEquals(null,calls[0].getForwardedFrom());
        System.assertEquals(null,calls[0].getCallerName());
        System.assertEquals(null,calls[0].getParentCallSid());
    }
    
    static testmethod void testTwilioCallList_createCall()
    {
    	String json='{"sid":"CA1768192f80674687ac779c0abe5dd5db","date_created":"Fri, 13 Jan 2012 11:27:54 +0000","date_updated":"Fri, '
        	+'13 Jan 2012 11:27:54 +0000","parent_call_sid":null,"account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3","to":"+919902400323",'
        	+'"to_formatted":"+919902400323","from":"+919902400323","from_formatted":"+919902400323","phone_number_sid":"PN17c8630939e44e7e92a45c51bcdb7122"'
        	+',"status":"queued","start_time":null,"end_time":null,"duration":null,"price":null,"direction":"outbound-api","answered_by":null,"api_version":'
        	+'"2010-04-01","annotation":null,"forwarded_from":null,"group_sid":null,"caller_name":null,"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3'
        	+'/Calls/CA1768192f80674687ac779c0abe5dd5db.json","subresource_uris":{"notifications":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/'
        	+'CA1768192f80674687ac779c0abe5dd5db/Notifications.json","recordings":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/'
        	+'CA1768192f80674687ac779c0abe5dd5db/Recordings.json"}}';
       
		// register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json',
			new Twilio_TestHTTPMock.Response(json,201)
			);
		Map<String,String>  params=new Map<String,String>();
		params.put('From','+919902400323' );
		params.put('To', '+919902400323');
		params.put('Url', 'http://shsimha-developer-edition.ap1.force.com/clicktocall?called=+918722266660');
		
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);		
		Twiliocall call = client.getAccount().getCalls().create(params);
		
		System.assertEquals('queued',call.getStatus());
        System.assertEquals('CA1768192f80674687ac779c0abe5dd5db',call.getSid());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',call.getAccountSid());
        System.assertEquals(Datetime.newInstanceGmt(2012,01,13,11,27,54),call.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,01,13,11,27,54), call.getDateUpdated());
        System.assertEquals(null,call.getParentCallSid());
        System.assertEquals('+919902400323',call.getTo());
        System.assertEquals('+919902400323',call.getFrom());
        System.assertEquals('PN17c8630939e44e7e92a45c51bcdb7122',call.getPhoneNumberSid());
        System.assertEquals(null,call.getStartTime());
        System.assertEquals(null,call.getEndTime());
        System.assertEquals(null,call.getDuration());
        System.assertEquals(null,call.getPrice());
        System.assertEquals('outbound-api',call.getDirection());
        System.assertEquals(null,call.getForwardedFrom());
        System.assertEquals(null,call.getCallerName());
        System.assertEquals(null,call.getAnsweredBy());
    }
    
    
    
    static testmethod void testTwilioCallList_iterator() {   
    	String jsonPage0 =
    		'{ "calls" : [ '
    		// calls[0]
    		+'{ "account_sid" : "AC03c2fcd60e144e7cbeed179fcbf812a3",'
			+'"annotation" : null,'
			+'"answered_by" : null,'
			+'"api_version" : "2010-04-01",'
			+'"caller_name" : null,'
			+'"date_created" : "Thu, 19 Jan 2012 21:51:38 +0000",'
			+'"date_updated" : "Thu, 19 Jan 2012 21:51:43 +0000",'
			+'"direction" : "inbound",'
			+'"duration" : "4",'
			+'"end_time" : "Thu, 19 Jan 2012 21:51:43 +0000",'
			+'"forwarded_from" : "+14157893609",'
			+'"from" : "+17073996131",'
			+'"from_formatted" : "(707) 399-6131",'
			+'"group_sid" : null,'
			+'"parent_call_sid" : null,'
			+'"phone_number_sid" : "PNa6dfec5c0a2561be6680e4ab5117283c",'
			+'"price" : "-0.01000",'
			+'"sid" : "CAbca8dd0af46b637c6a6fd6dd0e01fab5",'
			+'"start_time" : "Thu, 19 Jan 2012 21:51:39 +0000",'
			+'"status" : "completed",'
			+'"subresource_uris" : { "notifications" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAbca8dd0af46b637c6a6fd6dd0e01fab5/Notifications.json",'
			+'"recordings" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAbca8dd0af46b637c6a6fd6dd0e01fab5/Recordings.json"'
			+'},'
			+'"to" : "+14157893609",'
			+'"to_formatted" : "(415) 789-3609",'
			+'"uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAbca8dd0af46b637c6a6fd6dd0e01fab5.json"'
			+'},'
			// calls[1]
			+'{ "account_sid" : "AC03c2fcd60e144e7cbeed179fcbf812a3",'
			+'"annotation" : null,'
			+'"answered_by" : null,'
			+'"api_version" : "2010-04-01",'
			+'"caller_name" : null,'
			+'"date_created" : "Tue, 17 Jan 2012 21:21:45 +0000",'
			+'"date_updated" : "Tue, 17 Jan 2012 21:21:50 +0000",'
			+'"direction" : "inbound",'
			+'"duration" : "4",'
			+'"end_time" : "Tue, 17 Jan 2012 21:21:50 +0000",'
			+'"forwarded_from" : "+14158774850",'
			+'"from" : "+17378742833",'
			+'"from_formatted" : "(737) 874-2833",'
			+'"group_sid" : null,'
			+'"parent_call_sid" : null,'
			+'"phone_number_sid" : "PNebe1495ddc055eb2508cb3f9d4ed043d",'
			+'"price" : "-0.01000",'
			+'"sid" : "CA5c16c13e5d5615bd73d16664e562d895",'
			+'"start_time" : "Tue, 17 Jan 2012 21:21:46 +0000",'
			+'"status" : "completed",'
			+'"subresource_uris" : { "notifications" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5c16c13e5d5615bd73d16664e562d895/Notifications.json",'
			+'"recordings" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5c16c13e5d5615bd73d16664e562d895/Recordings.json"'
			+'},'
			+'"to" : "+14158774850",'
			+'"to_formatted" : "(415) 877-4850",'
			+'"uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CA5c16c13e5d5615bd73d16664e562d895.json"'
			+'}'
			+'],'
			+'"end" : 1,'
			+'"first_page_uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=0",'
			+'"last_page_uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=1",'
			+'"next_page_uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=1&AfterSid=CA5c16c13e5d5615bd73d16664e562d895",'
			+'"num_pages" : 2,'
			+'"page" : 0,'
			+'"page_size" : 2,'
			+'"previous_page_uri" : null,'
			+'"start" : 0,'
			+'"total" : 4,'
			+'"uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=0"'
			+'}';
    	
    	
    	String jsonPage1 = 
	    	'{ "calls" : ['
			// calls[0]
			+'{ "account_sid" : "AC03c2fcd60e144e7cbeed179fcbf812a3",'
			+'"annotation" : null,'
			+'"answered_by" : null,'
			+'"api_version" : "2010-04-01",'
			+'"caller_name" : null,'
			+'"date_created" : "Thu, 12 Jan 2012 17:31:58 +0000",'
			+'"date_updated" : "Thu, 12 Jan 2012 17:32:05 +0000",'
			+'"direction" : "outbound-dial",'
			+'"duration" : "0",'
			+'"end_time" : "Thu, 12 Jan 2012 17:32:05 +0000",'
			+'"forwarded_from" : "",'
			+'"from" : "+14155551111",'
			+'"from_formatted" : "(415) 555-1111",'
			+'"group_sid" : null,'
			+'"parent_call_sid" : "CAd6d7055b76d849489c3acabf4eb0140b",'
			+'"phone_number_sid" : "PN2e8b297009170f06944fcfb74f5cd0ee",'
			+'"price" : null,'
			+'"sid" : "CAb659fd2fa5fd820c05a5277fae70a98b",'
			+'"start_time" : "Thu, 12 Jan 2012 17:31:58 +0000",'
			+'"status" : "no-answer",'
			+'"subresource_uris" : { "notifications" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAb659fd2fa5fd820c05a5277fae70a98b/Notifications.json",'
			+'    "recordings" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAb659fd2fa5fd820c05a5277fae70a98b/Recordings.json"'
			+'  },'
			+'"to" : "+14155551234",'
			+'"to_formatted" : "(415) 555-1234",'
			+'"uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAb659fd2fa5fd820c05a5277fae70a98b.json"'
			+'},'
			// calls[1]
			+'{ "account_sid" : "AC03c2fcd60e144e7cbeed179fcbf812a3",'
			+'"annotation" : null,'
			+'"answered_by" : null,'
			+'"api_version" : "2010-04-01",'
			+'"caller_name" : null,'
			+'"date_created" : "Thu, 12 Jan 2012 17:31:48 +0000",'
			+'"date_updated" : "Thu, 12 Jan 2012 17:32:05 +0000",'
			+'"direction" : "outbound-api",'
			+'"duration" : "8",'
			+'"end_time" : "Thu, 12 Jan 2012 17:32:05 +0000",'
			+'"forwarded_from" : null,'
			+'"from" : "+14155551111",'
			+'"from_formatted" : "(415) 555-1111",'
			+'"group_sid" : null,'
			+'"parent_call_sid" : null,'
			+'"phone_number_sid" : "PN2e8b297009170f06944fcfb74f5cd0ee",'
			+'"price" : "-0.02000",'
			+'"sid" : "CAd6d7055b76d849489c3acabf4eb0140b",'
			+'"start_time" : "Thu, 12 Jan 2012 17:31:57 +0000",'
			+'"status" : "completed",'
			+'"subresource_uris" : { "notifications" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAd6d7055b76d849489c3acabf4eb0140b/Notifications.json",'
			+'    "recordings" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAd6d7055b76d849489c3acabf4eb0140b/Recordings.json"'
			+'  },'
			+'"to" : "+14152188121",'
			+'"to_formatted" : "(415) 555-1234",'
			+'"uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls/CAd6d7055b76d849489c3acabf4eb0140b.json"'
			+'}'
			+'],'
			+'"end" : 3,'
			+'"first_page_uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=0",'
			+'"last_page_uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=1",'
			+'"next_page_uri" : null,'
			+'"num_pages" : 2,'
			+'"page" : 1,'
			+'"page_size" : 2,'
			+'"previous_page_uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=0",'
			+'"start" : 2,'
			+'"total" : 4,'
			+'"uri" : "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=1"'
			+'}';
    	
    	   
        // register the mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Call List instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json',
			new Twilio_TestHTTPMock.Response(jsonPage0,200)
			);
			
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json?PageSize=2&Page=1&AfterSid=CA5c16c13e5d5615bd73d16664e562d895',
			new Twilio_TestHTTPMock.Response(jsonPage1,200)
			);
        
        // Get an API client and request the Twilio Call List
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
        TwilioCallList twcalls = client.getAccount().getCalls();
        
        TwilioCall call;
        Iterator<TwilioCall> callIt = twcalls.iterator();
        
        System.assert(callIt.hasNext());
        call = callIt.next();
        System.assertEquals('CAbca8dd0af46b637c6a6fd6dd0e01fab5',call.getSid());
        
        System.assert(callIt.hasNext());
        call = callIt.next();
        System.assertEquals('CA5c16c13e5d5615bd73d16664e562d895',call.getSid());
        
        System.assert(callIt.hasNext());
        call = callIt.next();
        System.assertEquals('CAb659fd2fa5fd820c05a5277fae70a98b',call.getSid());
        
        System.assert(callIt.hasNext());
        call = callIt.next();
        System.assertEquals('CAd6d7055b76d849489c3acabf4eb0140b',call.getSid());
        
        System.assert(!callIt.hasNext());        
    }
	
	static testmethod void testTwilioTranscription_get() { 
		String accountJsonResponseBody ='{'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"api_version": "2010-04-01",'
		+'"date_created": "Mon, 1 Feb 2012 10:49:17 +0000",'
		+'"date_updated": "Mon, 1 Feb 2012 10:49:17 +0000",'
		+'"duration": "6",'
		+'"price": "-0.05000",'
		+'"recording_sid": "REca11f06dc31b5515a2dfb1f5134361f2",'
		+'"sid": "TR8c61027b709ffb038236612dc5af8723",'
		+'"status": "completed",'
		+'"transcription_text": "Tommy? Tommy is that you? I told you never to call me again.",'
		+'"type": "fast",'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Transcriptions/TR8c61027b709ffb038236612dc5af8723.json"'
		+'}';
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Transcriptions/TR8c61027b709ffb038236612dc5af8723.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		Twiliotranscription twtransc = client.getAccount().getTranscription('TR8c61027b709ffb038236612dc5af8723');
		
        System.assertEquals('TR8c61027b709ffb038236612dc5af8723', twtransc.getSid());
        System.assertEquals('REca11f06dc31b5515a2dfb1f5134361f2', twtransc.getRecordingSid());
        //System.assertEquals('CAfd61c7aff9ee4da8a053d49a35a5ff7f',twtransc.getcallsid());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twtransc.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twtransc.getDateUpdated());
        System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twtransc.getAccountSid());
      	//System.assertEquals('2010-04-01',twtransc.getApiVersion());
        System.assertEquals('completed',twtransc.getStatus());
        System.assertEquals(6,twtransc.getduration());
		System.assertEquals('-0.05000',twtransc.getprice());
		System.assertEquals('Tommy? Tommy is that you? I told you never to call me again.',twtransc.getTranscriptionText());
		
		Twiliotranscription twtransc1 = new Twiliotranscription(client);
		Twiliotranscriptionlist twtransclist= new Twiliotranscriptionlist(client);
	}
    
    static testmethod void testTwilioTranscriptionList_get_filter() { 
		String accountJsonResponseBody ='{"transcriptions": [{'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"api_version": "2010-04-01",'
		+'"date_created": "Mon, 1 Feb 2012 10:49:17 +0000",'
		+'"date_updated": "Mon, 1 Feb 2012 10:49:17 +0000",'
		+'"duration": "6",'
		+'"price": "-0.05000",'
		+'"recording_sid": "REca11f06dc31b5515a2dfb1f5134361f2",'
		+'"sid": "TR8c61027b709ffb038236612dc5af8723",'
		+'"status": "completed",'
		+'"transcription_text": "Tommy? Tommy is that you? I told you never to call me again.",'
		+'"type": "fast",'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Transcriptions/TR8c61027b709ffb038236612dc5af8723.json"'
		+'}],'
		+'"page":0,"num_pages":1,"page_size":50,"total":2,"start":0,"end":1,"uri":'
		+'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json",'
		+'"first_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?Page=0&PageSize=50",'+
		+'"previous_page_uri":null,"next_page_uri":null,"last_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?Page=0&PageSize=50"}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Transcriptions.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwiliotranscriptionList twtrans = client.getAccount().gettranscriptions();
		System.assertNotEquals(null, twtrans);
		
		List<Twiliotranscription> twtranslist = twtrans.getPageData();
		System.assertNotEquals(null, twtranslist);
		System.assertEquals(1, twtranslist.size());
		Twiliotranscription twtransc=twtranslist.get(0);
        System.assertEquals('TR8c61027b709ffb038236612dc5af8723', twtransc.getSid());
        System.assertEquals('REca11f06dc31b5515a2dfb1f5134361f2', twtransc.getRecordingSid());
        //System.assertEquals('CAfd61c7aff9ee4da8a053d49a35a5ff7f',twtransc.getcallsid());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twtransc.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twtransc.getDateUpdated());
        System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twtransc.getAccountSid());
      	//System.assertEquals('2010-04-01',twtransc.getApiVersion());
        System.assertEquals('completed',twtransc.getStatus());
        System.assertEquals(6,twtransc.getduration());
		System.assertEquals('-0.05000',twtransc.getprice());
		System.assertEquals('Tommy? Tommy is that you? I told you never to call me again.',twtransc.getTranscriptionText());
	
		
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Transcriptions.json?sid=TR8c61027b709ffb038236612dc5af8723',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		map<String,string> params=new map<string,string>();
		params.put('sid','TR8c61027b709ffb038236612dc5af8723');
		twtrans = client.getAccount().gettranscriptions(params);
		System.assertNotEquals(null, twtrans);
		
		Iterator<Twiliotranscription> it = twtrans.iterator();
		
		System.assertEquals(true, it.hasnext());
		twtransc=it.next();
        System.assertEquals('TR8c61027b709ffb038236612dc5af8723', twtransc.getSid());
        System.assertEquals('REca11f06dc31b5515a2dfb1f5134361f2', twtransc.getRecordingSid());
        //System.assertEquals('CAfd61c7aff9ee4da8a053d49a35a5ff7f',twtransc.getcallsid());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twtransc.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twtransc.getDateUpdated());
        System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twtransc.getAccountSid());
      //  System.assertEquals('2010-04-01',twtransc.getApiVersion());
        System.assertEquals('completed',twtransc.getStatus());
        System.assertEquals(6,twtransc.getduration());
		System.assertEquals('-0.05000',twtransc.getprice());
		System.assertEquals('Tommy? Tommy is that you? I told you never to call me again.',twtransc.getTranscriptionText());
		system.assertEquals(false,it.hasnext());
	}
}