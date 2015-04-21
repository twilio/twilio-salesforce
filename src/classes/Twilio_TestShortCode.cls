@istest
private class Twilio_TestShortCode {
	final static String authToken = '12345678901234567890123456789012';
   static testmethod void testTwilioShortCodeList_get()
	{
		String shortcodeJsonResponseBody ='{"page": 0,"num_pages": 1,"page_size": 50,"total": 6,"start": 0,"end": 5,'+
		'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/SMS/ShortCodes.json",'+
		'"first_page_uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/SMS/ShortCodes.json?Page=0&PageSize=50",'+
		'"previous_page_uri": null,"next_page_uri": null,"last_page_uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/SMS/ShortCodes.json?Page=0&PageSize=50",'+
		'"short_codes": [{"sid": "SC6b20cb705c1e8f00210049b20b70fce2","account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3","friendly_name": "67898",'+
		'"short_code": "67898","date_created": "Thu, 13 Nov 2008 07:56:24 +0000","date_updated": "Thu, 13 Nov 2008 08:45:58 +0000",'+
		'"sms_url": "http://demo.twilio.com/docs/sms.xml","sms_method": "POST","sms_fallback_url": "http://smsapp.com/fallback","sms_fallback_method": "POST",'+
		'"api_version": "2010-04-01","uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/SMS/ShortCodes/SC6b20cb705c1e8f00210049b20b70fce2.json"}]}';
		
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.

		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/SMS/ShortCodes.json',
			new Twilio_TestHTTPMock.Response(shortcodeJsonResponseBody,200)
			);
		 
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioShortCodeList twshortcodes=client.getAccount().getShortCodes();
		
		System.assertNotEquals(null, twshortcodes);
		
		List<TwilioShortCode> twshortcodesList = twshortcodes.getPageData();
		
		System.assertNotEquals(null, twshortcodesList);
		System.assertEquals(1, twshortcodesList.size());
		System.assertEquals('SC6b20cb705c1e8f00210049b20b70fce2', twshortcodesList[0].getSid());
		System.assertEquals(Datetime.newInstanceGmt(2008,11,13,07,56,24),twshortcodesList[0].getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2008,11,13,08,45,58),twshortcodesList[0].getDateUpdated());
		System.assertEquals('67898',twshortcodesList[0].getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twshortcodesList[0].getAccountSid());				
		System.assertEquals('67898',twshortcodesList[0].getShortCode());
		System.assertEquals('2010-04-01',twshortcodesList[0].getApiVersion());
		System.assertEquals('http://demo.twilio.com/docs/sms.xml',twshortcodesList[0].getSmsUrl());
		System.assertEquals('POST',twshortcodesList[0].getSmsMethod());
		System.assertEquals('http://smsapp.com/fallback',twshortcodesList[0].getSmsFallbackUrl());
		System.assertEquals('POST',twshortcodesList[0].getSmsFallbackMethod());		
		
		Iterator<TwilioShortCode> it = twshortcodes.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioShortCode s=it.next();
		System.assertEquals(false, it.hasNext());
		
	}
}