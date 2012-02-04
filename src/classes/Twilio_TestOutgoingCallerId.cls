@isTest
private class Twilio_TestOutgoingCallerId {

    final static String authToken = '12345678901234567890123456789012';
		
	static testmethod void testOutgoingCallerIDList()
	{
		String accountJsonResponseBody ='{"outgoing_caller_ids":[{"sid":"PN17c8630939e44e7e92a45c51bcdb7122",'
		+'"account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3","friendly_name":"919902400323","phone_number":"+919902400323",'+
		'"date_created":"Thu, 29 Dec 2011 12:22:55 +0000","date_updated":"Thu, 29 Dec 2011 12:22:55 +0000",'+
		'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds/PN17c8630939e44e7e92a45c51bcdb7122.json"}],'+
		'"page":0,"num_pages":1,"page_size":50,"total":1,"start":0,"end":0,"uri":'+
		'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json","first_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds'+
		'.json?Page=0&PageSize=50","previous_page_uri":null,"next_page_uri":null,"last_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json?Page=0&PageSize=50"}';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioOutgoingCallerIdList twoutcallid=api.getClient().getAccount().getOutgoingCallerIds();
		System.assertNotEquals(null, twoutcallid);
		
		List<TwilioOutgoingCallerId> twocallidList = twoutcallid.getPageData();
		
		System.assertNotEquals(null, twocallidList);
		System.assertEquals(1, twocallidList.size());
		System.assertEquals('PN17c8630939e44e7e92a45c51bcdb7122', twocallidList[0].getSid());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twocallidList[0].getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twocallidList[0].getDateUpdated());
		System.assertEquals('919902400323',twocallidList[0].getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twocallidList[0].getAccountSid());
		System.assertEquals('+919902400323',twocallidList[0].getPhoneNumber());
		
		Iterator<TwilioOutgoingCallerId> it = twoutcallid.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioOutgoingCallerId twocallid=it.next();
		System.assertEquals(false, it.hasNext());
	}
	
	static testmethod void testCreateOutgoingCallerID()
	{
		String accountJsonResponseBody ='{"account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3","phone_number":"+918722266012",'+
		'"friendly_name":"harsha","validation_code":844863}';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		
		map<string,string> p=new map<string,string>();
		p.put('PhoneNumber','+9187222660');
		p.put('FriendlyName','harsha');
				
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioCallerIdValidation twoutcallid = api.getClient().getAccount().getOutgoingCallerIds().createOutgoingCallerId(p);
		
		System.assertEquals('harsha',twoutcallid.getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twoutcallid.getAccountSid());
		System.assertEquals('+918722266012',twoutcallid.getPhoneNumber());
		System.assertEquals('844863',twoutcallid.getValidationCode());
		
	}
	static testmethod void testOutgoingCallerID()
	{
		String accountJsonResponseBody ='{"sid":"PN17c8630939e44e7e92a45c51bcdb7122","account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"friendly_name":"919902400323","phone_number":"+919902400323","date_created":"Thu, 29 Dec 2011 12:22:55 +0000","date_updated":'+
		'"Thu, 29 Dec 2011 12:22:55 +0000","uri":'+
		'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds/PN17c8630939e44e7e92a45c51bcdb7122.json"}';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds/PN17c8630939e44e7e92a45c51bcdb7122.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioOutgoingCallerId twoutcallid=api.getClient().getAccount().getOutgoingCallerId('PN17c8630939e44e7e92a45c51bcdb7122');
		
		System.assertEquals('PN17c8630939e44e7e92a45c51bcdb7122', twoutcallid.getSid());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twoutcallid.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twoutcallid.getDateUpdated());
		System.assertEquals('919902400323',twoutcallid.getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twoutcallid.getAccountSid());
		System.assertEquals('+919902400323',twoutcallid.getPhoneNumber());
		
		TwilioOutgoingCallerId  tci=new TwilioOutgoingCallerId(api.getclient()); 
	}
}