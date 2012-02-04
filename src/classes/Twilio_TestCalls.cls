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
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
        TwilioCall call = api.getClient().getAccount().getCall('CA5ea9c5d78e1f35fc01c204682d056e22');
        
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
        
        //System.assertNotEquals('conferences',call.subresource_uris[0].resource);       
        //System.assertEquals('recordings',call.subresource_uris[0].resource);
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
		TwilioAPI api = new TwilioAPI('AC5ef872f6da5a21de157d80997a64bd33',authToken);		
		Twiliocall call = api.getClient().getAccount().getCall('CAe1644a7eed5088b159577c5802d8be38').redirect('http://www.myapp.com/myhandler.php','POST');
		
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

		TwilioAPI api = new TwilioAPI('AC5ef872f6da5a21de157d80997a64bd33',authToken);		
		Twiliocall call = api.getClient().getAccount().getCall('CAe1644a7eed5088b159577c5802d8be38').hangup();
		
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

		TwilioAPI api = new TwilioAPI('AC5ef872f6da5a21de157d80997a64bd33',authToken);		
		Twiliocall call = api.getClient().getAccount().getCall('CAe1644a7eed5088b159577c5802d8be38').cancel();
		
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
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
        TwilioCallList twcalls = api.getClient().getAccount().getCalls();
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
		
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);		
		Twiliocall call = api.getClient().getAccount().getCalls().createCall(params);
		
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
		// for the HTTP GET method and at the Twilio Call List instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Calls.json',
			new Twilio_TestHTTPMock.Response(json,200)
			);
        
        // Get an API client and request the Twilio Call List
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeed179fcbf812a3',authToken);
        TwilioCallList twcalls = api.getClient().getAccount().getCalls();
        List<TwilioCall> calls = twcalls.getPageData();
        
        // assert correct behavior
        System.assertEquals(3,calls.size());
        
        Iterator<TwilioCall> callIt = twcalls.iterator();
        System.assert(callIt.hasNext());
        
        TwilioCall call = callIt.next();
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',call.getAccountSid());
        System.assertEquals('CA62efc923742a4c40beeca377581f4a55',call.getSid());
        System.assertEquals(Datetime.newInstanceGmt(2011,12,27,09,54,38),call.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2011,12,27,09,54,38),call.getDateUpdated());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',call.getAccountSid());
        System.assertEquals('+15108706378',call.getTo());
        System.assertEquals('+14157234000',call.getFrom());
        System.assertEquals(null,call.getPhoneNumberSid());
        System.assertEquals('no-answer',call.getStatus());
        System.assertEquals(Datetime.newInstanceGmt(2011,12,27,09,54,38),call.getStartTime());
        System.assertEquals(null,call.getEndTime());
        System.assertEquals(null,call.getDuration());
        System.assertEquals(null,call.getPrice());
        System.assertEquals('outbound-api',call.getDirection());
        System.assertEquals(null,call.getAnsweredBy());
        System.assertEquals(null,call.getForwardedFrom());
        System.assertEquals(null,call.getCallerName());
        System.assertEquals(null,call.getParentCallSid());
    }
}