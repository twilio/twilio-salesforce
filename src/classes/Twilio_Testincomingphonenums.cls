@isTest
private class Twilio_Testincomingphonenums 
{
	final static String authToken = '12345678901234567890123456789012';
	static testmethod void testincomingphnenumList()
	{
		String accountJsonResponseBody ='{"page": 0,"num_pages": 1,"page_size": 50,"total": 6,"start": 0,"end": 5,'+
		'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json",'+
		'"first_page_uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json?Page=0&PageSize=50",'+
		'"previous_page_uri": null,"next_page_uri": null,"last_page_uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json?Page=0&PageSize=50",'+
		'"incoming_phone_numbers": [{"sid": "PN3f94c94562ac88dccf16f8859a1a8b25","account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3","friendly_name": "Long Play",'+
		'"phone_number": "+14152374451","voice_url": "http://demo.twilio.com/long","voice_method": "GET","voice_fallback_url": null,"voice_fallback_method": null,'+
		'"voice_caller_id_lookup": null,"voice_application_sid": null,"date_created": "Thu, 13 Nov 2008 07:56:24 +0000","date_updated": "Thu, 13 Nov 2008 08:45:58 +0000",'+
		'"sms_url": null,"sms_method": null,"sms_fallback_url": null,"sms_fallback_method": null,"sms_application_sid": "AP9b2e38d8c592488c397fc871a82a74ec",'+
		'"capabilities": {"voice": true,"sms": false},"status_callback": null,"status_callback_method": null,"api_version": "2010-04-01",'+
		'"uri": "/2010-04-01/Accounts/ACdc5f1e11047ebd6fe7a55f120be3a900/IncomingPhoneNumbers/PN3f94c94562ac88dccf16f8859a1a8b25.json"}]}';
		
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioIncomingPhoneNumberList twinnums=api.getClient().getAccount().getIncomingPhoneNumbers();
		
		System.assertNotEquals(null, twinnums);
		
		List<TwilioIncomingPhoneNumber> twinnumsList = twinnums.getPageData();
		
		System.assertNotEquals(null, twinnumsList);
		System.assertEquals(1, twinnumsList.size());
		System.assertEquals('PN3f94c94562ac88dccf16f8859a1a8b25', twinnumsList[0].getSid());
		System.assertEquals(Datetime.newInstanceGmt(2008,11,13,07,56,24),twinnumsList[0].getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2008,11,13,08,45,58),twinnumsList[0].getDateUpdated());
		System.assertEquals('Long Play',twinnumsList[0].getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twinnumsList[0].getAccountSid());				
		System.assertEquals('+14152374451',twinnumsList[0].getPhoneNumber());
		System.assertEquals(null,twinnumsList[0].getVoiceApplicaitonSid());
		System.assertEquals('AP9b2e38d8c592488c397fc871a82a74ec',twinnumsList[0].getSmsApplicaitonSid());
		System.assertEquals('2010-04-01',twinnumsList[0].getApiVersion());
		System.assertEquals('http://demo.twilio.com/long',twinnumsList[0].getVoiceUrl());
		System.assertEquals('GET',twinnumsList[0].getVoiceMethod());
		System.assertEquals(null,twinnumsList[0].getVoiceFallbackurl());
		System.assertEquals(null,twinnumsList[0].getVoiceFallbackMethod());
		System.assertEquals(null,twinnumsList[0].getStatusCallback());
		System.assertEquals(null,twinnumsList[0].getStatusCallbackMethod()); 
		System.assertEquals(null,twinnumsList[0].getVoiceCallerIdLookup());
		System.assertEquals(null,twinnumsList[0].getSmsUrl());
		System.assertEquals(null,twinnumsList[0].getSmsMethod());
		System.assertEquals(null,twinnumsList[0].getSmsFallbackUrl());
		System.assertEquals(null,twinnumsList[0].getSmsFallbackMethod());		
		System.assertEquals(null,twinnumsList[0].getSmsStatusCallback());
		
		Iterator<TwilioIncomingPhoneNumber> it = twinnums.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioIncomingPhoneNumber twinnum=it.next();
		System.assertEquals(false, it.hasNext());
		
	}
	
	static testmethod void testCreateincomingphonenum()
	{
		String accountJsonResponseBody ='{"sid": "PN2a0747eba6abf96b7e3c3ff0b4530f6e","account_sid": "ACdc5f1e11047ebd6fe7a55f120be3a900","friendly_name": "My Company Line",'+
'"phone_number": "+15105647903","voice_url": "http://mycompany.com/handleNewCall.php","voice_method": "POST","voice_fallback_url": null,"voice_fallback_method": "POST",'+
'"voice_caller_id_lookup": null,"voice_application_sid": null,"date_created": "Mon, 16 Aug 2010 23:31:47 +0000","date_updated": "Mon, 16 Aug 2010 23:31:47 +0000",'+
'"sms_url": null,"sms_method": "POST","sms_fallback_url": null,"sms_fallback_method": "GET","sms_application_sid": null,"capabilities": {"voice": null,"sms": null},'+
'"status_callback": null,"status_callback_method": null,"api_version": "2010-04-01","uri": "/2010-04-01/Accounts/ACdc5f1e11047ebd6fe7a55f120be3a900/IncomingPhoneNumbers/PN2a0747eba6abf96b7e3c3ff0b4530f6e.json"}';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		
		map<string,string> p=new map<string,string>();
		p.put('PhoneNumber','+15105647903');
		p.put('FriendlyName','My Company Line');
		p.put('VoiceUrl','http://mycompany.com/handleNewCall.php');
		p.put('VoiceMethod','GET');
		
				
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		
		TwilioIncomingPhoneNumber twinnums= api.getClient().getAccount().getIncomingPhoneNumbers().createIncomingPhoneNumber(p);
		
		System.assertEquals('PN2a0747eba6abf96b7e3c3ff0b4530f6e', twinnums.getSid());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,16,23,31,47),twinnums.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,16,23,31,47),twinnums.getDateUpdated());
		System.assertEquals('My Company Line',twinnums.getFriendlyName());
		System.assertEquals('ACdc5f1e11047ebd6fe7a55f120be3a900',twinnums.getAccountSid());				
		System.assertEquals('+15105647903',twinnums.getPhoneNumber());
		System.assertEquals(null,twinnums.getVoiceApplicaitonSid());
		System.assertEquals(null,twinnums.getSmsApplicaitonSid());
		System.assertEquals('2010-04-01',twinnums.getApiVersion());
		System.assertEquals('http://mycompany.com/handleNewCall.php',twinnums.getVoiceUrl());
		System.assertEquals('POST',twinnums.getVoiceMethod());
		System.assertEquals(null,twinnums.getVoiceFallbackurl());
		System.assertEquals('POST',twinnums.getVoiceFallbackMethod());
		System.assertEquals(null,twinnums.getStatusCallback());
		System.assertEquals(null,twinnums.getStatusCallbackMethod()); 
		System.assertEquals(null,twinnums.getVoiceCallerIdLookup());
		System.assertEquals(null,twinnums.getSmsUrl());
		System.assertEquals('POST',twinnums.getSmsMethod());
		System.assertEquals(null,twinnums.getSmsFallbackUrl());
		System.assertEquals('GET',twinnums.getSmsFallbackMethod());		
		System.assertEquals(null,twinnums.getSmsStatusCallback());
		
	}
	static testmethod void testincomingphnenum()
	{
		String accountJsonResponseBody ='{"sid": "PN2a0747eba6abf96b7e3c3ff0b4530f6e","account_sid": "ACdc5f1e11047ebd6fe7a55f120be3a900","friendly_name": "My Company Line",'+
		'"phone_number": "+15105647903","voice_url": "http://mycompany.com/handleNewCall.php","voice_method": "POST","voice_fallback_url": null,"voice_fallback_method": "POST",'+
		'"voice_caller_id_lookup": null,"voice_application_sid": null,"date_created": "Mon, 16 Aug 2010 23:31:47 +0000","date_updated": "Mon, 16 Aug 2010 23:31:47 +0000",'+
		'"sms_url": null,"sms_method": "POST","sms_fallback_url": null,"sms_fallback_method": "GET","sms_application_sid": null,"capabilities": {"voice": null,"sms": null},'+
		'"status_callback": null,"status_callback_method": null,"api_version": "2010-04-01","uri": "/2010-04-01/Accounts/ACdc5f1e11047ebd6fe7a55f120be3a900/IncomingPhoneNumbers/PN2a0747eba6abf96b7e3c3ff0b4530f6e.json"}';
        	
        Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/IncomingPhoneNumbers/PN3f94c94562ac88dccf16f8859a1a8b25.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
		);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeed179fcbf812a3', authToken);
		
		TwilioIncomingPhoneNumber twinnums=api.getClient().getAccount().getIncomingPhoneNumber('PN3f94c94562ac88dccf16f8859a1a8b25');
		
		System.assertEquals('PN3f94c94562ac88dccf16f8859a1a8b25', twinnums.getSid());
		System.assertEquals('My Company Line',twinnums.getFriendlyName());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,16,23,31,47),twinnums.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,16,23,31,47),twinnums.getDateUpdated());
		
		System.assertEquals('ACdc5f1e11047ebd6fe7a55f120be3a900',twinnums.getAccountSid());				
		System.assertEquals('+15105647903',twinnums.getPhoneNumber());
		System.assertEquals(null,twinnums.getVoiceApplicaitonSid());
		System.assertEquals(null,twinnums.getSmsApplicaitonSid());
		System.assertEquals('2010-04-01',twinnums.getApiVersion());
		System.assertEquals('http://mycompany.com/handleNewCall.php',twinnums.getVoiceUrl());
		System.assertEquals('POST',twinnums.getVoiceMethod());
		System.assertEquals(null,twinnums.getVoiceFallbackurl());
		System.assertEquals('POST',twinnums.getVoiceFallbackMethod());
		System.assertEquals(null,twinnums.getStatusCallback());
		System.assertEquals(null,twinnums.getStatusCallbackMethod()); 
		System.assertEquals(null,twinnums.getVoiceCallerIdLookup());
		System.assertEquals(null,twinnums.getSmsUrl());
		System.assertEquals('POST',twinnums.getSmsMethod());
		System.assertEquals(null,twinnums.getSmsFallbackUrl());
		System.assertEquals('GET',twinnums.getSmsFallbackMethod());		
		System.assertEquals(null,twinnums.getSmsStatusCallback());
	}
}