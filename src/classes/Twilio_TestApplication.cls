@isTest
private class Twilio_TestApplication {

    final static String authToken = '12345678901234567890123456789012';
		
	static testmethod void testTwilioAplications() {
		String accountJsonResponseBody ='{"applications":[{"sid":"AP023e78c7f13a4fe683ef2e5ddc510399","date_created":'
		+'"Wed, 01 Feb 2012 10:49:17 +0000","date_updated":"Wed, 01 Feb 2012 10:49:17 +0000","account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3",'
		+'"friendly_name":"Testapp1","api_version":"2010-04-01","voice_url":null,"voice_method":"POST","voice_fallback_url":null,'
		+'"voice_fallback_method":"POST","status_callback":null,"status_callback_method":"POST","voice_caller_id_lookup":false,'
		+'"sms_url":null,"sms_method":"POST","sms_fallback_url":null,"sms_fallback_method":"POST","sms_status_callback":null,'
		+'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications/AP023e78c7f13a4fe683ef2e5ddc510399.json"},'
		+'{"sid":"AP381adc6d74f6403eb704383fcfc21d2b","date_created":"Wed, 01 Feb 2012 10:49:05 +0000","date_updated":'
		+'"Wed, 01 Feb 2012 10:49:05 +0000","account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3","friendly_name":"Testapp",'
		+'"api_version":"2010-04-01","voice_url":null,"voice_method":"POST","voice_fallback_url":null,"voice_fallback_method":"POST",'
		+'"status_callback":null,"status_callback_method":"POST","voice_caller_id_lookup":false,"sms_url":null,"sms_method":"POST",'
		+'"sms_fallback_url":null,"sms_fallback_method":"POST","sms_status_callback":null,'
		+'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications/AP381adc6d74f6403eb704383fcfc21d2b.json"}],'
		+'"page":0,"num_pages":1,"page_size":50,"total":2,"start":0,"end":1,"uri":'
		+'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json",'
		+'"first_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?Page=0&PageSize=50",'+
		+'"previous_page_uri":null,"next_page_uri":null,"last_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?Page=0&PageSize=50"}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Applications.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioApplicationList twapps = api.getClient().getAccount().getApplications();
		System.assertNotEquals(null, twapps);
		
		List<TwilioApplication> twappslist = twapps.getPageData();
		System.assertNotEquals(null, twappslist);
		System.assertEquals(2, twappslist.size());
		System.assertEquals('AP023e78c7f13a4fe683ef2e5ddc510399', twappslist[0].getSid());
		System.assertEquals('Testapp1',twappslist[0].getFriendlyName());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twappslist[0].getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twappslist[0].getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',twappslist[0].getAccountSid());
		System.assertEquals('2010-04-01',twappslist[0].getApiVersion());
		System.assertEquals(null,twappslist[0].getVoiceUrl());
		System.assertEquals('POST',twappslist[0].getVoiceMethod());
		System.assertEquals(null,twappslist[0].getVoiceFallbackUrl());
		System.assertEquals('POST',twappslist[0].getVoiceFallbackMethod());
		System.assertEquals('POST',twappslist[0].getStatusCallbackMethod());
		System.assertEquals('false',twappslist[0].getVoiceCallerIdLookup());
		System.assertEquals(null,twappslist[0].getSmsUrl());
		System.assertEquals(null,twappslist[0].getSmsMethod());
		System.assertEquals(null,twappslist[0].getSmsFallbackUrl());
		System.assertEquals('POST',twappslist[0].getSmsFallbackMethod());
		System.assertEquals(null,twappslist[0].getSmsStatusCallback());
		
		Iterator<TwilioApplication> it = twapps.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioApplication twapps1=it.next();
		System.assertEquals(true, it.hasNext());
		twapps1=it.next();
		
		System.assertEquals('AP381adc6d74f6403eb704383fcfc21d2b', twapps1.getSid());
		System.assertEquals('Testapp',twapps1.getFriendlyName());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,05),twapps1.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,05),twapps1.getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',twapps1.getAccountSid());
		System.assertEquals('2010-04-01',twapps1.getApiVersion());
		System.assertEquals(null,twapps1.getVoiceUrl());
		System.assertEquals('POST',twapps1.getVoiceMethod());
		System.assertEquals(null,twapps1.getVoiceFallbackUrl());
		System.assertEquals('POST',twapps1.getVoiceFallbackMethod());
		System.assertEquals('POST',twapps1.getStatusCallbackMethod());
		System.assertEquals('false',twapps1.getVoiceCallerIdLookup());
		System.assertEquals(null,twapps1.getSmsUrl());
		System.assertEquals(null,twapps1.getSmsMethod());
		System.assertEquals(null,twapps1.getSmsFallbackUrl());
		System.assertEquals('POST',twapps1.getSmsFallbackMethod());
		System.assertEquals(null,twapps1.getSmsStatusCallback());
		System.assertEquals(false, it.hasNext());
	}
	
	static testmethod void testTwilioAplicationparams() {
		String accountJsonResponseBody ='{"applications":[{"sid":"AP023e78c7f13a4fe683ef2e5ddc510399",'
		+'"date_created":"Wed, 01 Feb 2012 10:49:17 +0000","date_updated":"Wed, 01 Feb 2012 10:49:17 +0000",'
		+'"account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3","friendly_name":"Testapp1","api_version":"2010-04-01",'
		+'"voice_url":null,"voice_method":"POST","voice_fallback_url":null,"voice_fallback_method":"POST","status_callback":null,'
		+'"status_callback_method":"POST","voice_caller_id_lookup":false,"sms_url":null,"sms_method":"POST","sms_fallback_url":null,'
		+'"sms_fallback_method":"POST","sms_status_callback":null,"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications/AP023e78c7f13a4fe683ef2e5ddc510399.json"}],'
		+'"page":0,"num_pages":1,"page_size":50,"total":1,"start":0,"end":0,"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?'
		+'VoiceMethod=POST&FriendlyName=Testapp1","first_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?'
		+'VoiceMethod=POST&FriendlyName=Testapp1&Page=0&PageSize=50","previous_page_uri":null,"next_page_uri":null,"last_page_uri":"/2010-04-01/Accounts'
		+'/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?VoiceMethod=POST&FriendlyName=Testapp1&Page=0&PageSize=50"}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Applications.json?VoiceMethod=POST&FriendlyName=Testapp1',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		map<string,string> params=new map<string,string>();
		params.put('FriendlyName','Testapp1');
		params.put('VoiceMethod','POST');
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioApplicationList twapps = api.getClient().getAccount().getApplications(params);
		System.assertNotEquals(null, twapps);
		
		System.assertNotEquals(null, twapps);
		
		List<TwilioApplication> twappslist = twapps.getPageData();
		System.assertNotEquals(null, twappslist);
		System.assertEquals(1, twappslist.size());
		System.assertEquals('AP023e78c7f13a4fe683ef2e5ddc510399', twappslist[0].getSid());
		System.assertEquals('Testapp1',twappslist[0].getFriendlyName());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twappslist[0].getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twappslist[0].getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twappslist[0].getAccountSid());
		System.assertEquals('2010-04-01',twappslist[0].getApiVersion());
		System.assertEquals(null,twappslist[0].getVoiceUrl());
		System.assertEquals('POST',twappslist[0].getVoiceMethod());
		System.assertEquals(null,twappslist[0].getVoiceFallbackUrl());
		System.assertEquals('POST',twappslist[0].getVoiceFallbackMethod());
		System.assertEquals('POST',twappslist[0].getStatusCallbackMethod());
		System.assertEquals('false',twappslist[0].getVoiceCallerIdLookup());
		System.assertEquals(null,twappslist[0].getSmsUrl());
		System.assertEquals(null,twappslist[0].getSmsMethod());
		System.assertEquals(null,twappslist[0].getSmsFallbackUrl());
		System.assertEquals('POST',twappslist[0].getSmsFallbackMethod());
		System.assertEquals(null,twappslist[0].getSmsStatusCallback());
	}
	static testmethod void testcreateTwilioAplication() {
		String accountJsonResponseBody ='{"sid":"AP023e78c7f13a4fe683ef2e5ddc510399","date_created":"Wed, 01 Feb 2012 10:49:17 +0000",'
		+'"date_updated":"Wed, 01 Feb 2012 10:49:17 +0000","account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3","friendly_name":"Testapp1",'
		+'"api_version":"2010-04-01","voice_url":null,"voice_method":"POST","voice_fallback_url":null,"voice_fallback_method":"POST",'
		+'"status_callback":null,"status_callback_method":"POST","voice_caller_id_lookup":false,"sms_url":null,"sms_method":"POST","sms_fallback_url":null,'
		+'"sms_fallback_method":"POST","sms_status_callback":null,"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications/AP023e78c7f13a4fe683ef2e5ddc510399.json"}';
	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Applications.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
			
			
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3','9339f87c4573196830a8f497bceb8fa9');
		map<string,string> params=new map<string,string>();
		params.put('FriendlyName','Testapp1');
		params.put('VoiceMethod','POST');
		TwilioApplication twaps = api.getClient().getAccount().getApplications().createApplication(params);
		
		System.assertEquals('AP023e78c7f13a4fe683ef2e5ddc510399', twaps.getSid());
		System.assertEquals('Testapp1',twaps.getFriendlyName());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twaps.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twaps.getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twaps.getAccountSid());
		System.assertEquals('2010-04-01',twaps.getApiVersion());
		System.assertEquals(null,twaps.getVoiceUrl());
		System.assertEquals('POST',twaps.getVoiceMethod());
		System.assertEquals(null,twaps.getVoiceFallbackUrl());
		System.assertEquals('POST',twaps.getVoiceFallbackMethod());
		System.assertEquals('POST',twaps.getStatusCallbackMethod());
		System.assertEquals('false',twaps.getVoiceCallerIdLookup());
		System.assertEquals(null,twaps.getSmsUrl());
		System.assertEquals(null,twaps.getSmsMethod());
		System.assertEquals(null,twaps.getSmsFallbackUrl());
		System.assertEquals('POST',twaps.getSmsFallbackMethod());
		System.assertEquals(null,twaps.getSmsStatusCallback());
	}
	
}