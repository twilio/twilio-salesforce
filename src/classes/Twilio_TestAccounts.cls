@isTest
class Twilio_TestAccounts {

	final static String authToken = '12345678901234567890123456789012';
		
	static testmethod void testTwilioAccount() {
		// create the response body to be returned when the account URI is requested
		String accountJsonResponseBody =
			'{ "sid": "ACba8bc05eacf94afdae398e642c9cc32d",'
			+'"friendly_name": "Do you like my friendly name?",'
			+'"type": "Full",'
			+'"status": "active",'
			+'"date_created": "Wed, 04 Aug 2010 21:37:41 +0000",'
			+'"date_updated": "Fri, 06 Aug 2010 01:15:02 +0000",'
			+'"auth_token": "redacted",'
			+'"uri": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d.json",'
			+'"subresource_uris": {'
				+'"available_phone_numbers": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers.json",'
		        +'"calls": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Calls.json",'
		        +'"conferences": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Conferences.json",'
		        +'"incoming_phone_numbers": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/IncomingPhoneNumbers.json",'
		        +'"notifications": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Notifications.json",'
		        +'"outgoing_caller_ids": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/OutgoingCallerIds.json",'
		        +'"recordings": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Recordings.json",'
		        +'"sandbox": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Sandbox.json",'
		        +'"sms_messages": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/SMS/Messages.json",'
		        +'"transcriptions": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Transcriptions.json"'
		    +'} }';

		// register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
		TwilioAccount twaccount = api.getClient().getAccount();
		
		// assert correct values in the fields
		System.assertNotEquals(null, twaccount);
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', twaccount.getSid());
		System.assertEquals(authToken, twaccount.getAuthToken());
		System.assertEquals('Do you like my friendly name?', twaccount.getFriendlyName());
		System.assertEquals('Full', twaccount.getType());
		System.assertEquals('active', twaccount.getStatus());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,04, 21,37,41), twaccount.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,06, 01,15,02), twaccount.getDateUpdated());
	}
	
	static testmethod void testTwilioAccountList() {
		// create the response body to be returned when the account URI is requested
		String accountJsonResponseBody =
			'{"accounts":[{"sid": "ACba8bc05eacf94afdae398e642c9cc32d",'
			+'"friendly_name": "Do you like my friendly name?",'
			+'"type": "Full",'
			+'"status": "active",'
			+'"date_created": "Wed, 04 Aug 2010 21:37:41 +0000",'
			+'"date_updated": "Fri, 06 Aug 2010 01:15:02 +0000",'
			+'"auth_token": "redacted",'
			+'"uri": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d.json",'
			+'"subresource_uris": {'
				+'"available_phone_numbers": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers.json",'
		        +'"calls": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Calls.json",'
		        +'"conferences": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Conferences.json",'
		        +'"incoming_phone_numbers": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/IncomingPhoneNumbers.json",'
		        +'"notifications": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Notifications.json",'
		        +'"outgoing_caller_ids": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/OutgoingCallerIds.json",'
		        +'"recordings": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Recordings.json",'
		        +'"sandbox": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Sandbox.json",'
		        +'"sms_messages": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/SMS/Messages.json",'
		        +'"transcriptions": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Transcriptions.json"'
		    +'}}],"page":0,"total":1}';

		// register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('ACba8bc05eacf94afdae398e642c9cc32d',authToken);
        TwilioAccountList twaccounts = api.getClient().getAccounts();
        List<TwilioAccount> accounts = twaccounts.getPageData();
        
        // assert correct values in the fields
		System.assertEquals(1,accounts.size());
        TwilioAccount twaccount = accounts.get(0);
        System.assertNotEquals(null, twaccount);
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', twaccount.getSid());
		System.assertEquals('redacted', twaccount.getAuthToken());
		System.assertEquals('Do you like my friendly name?', twaccount.getFriendlyName());
		System.assertEquals('Full', twaccount.getType());
		System.assertEquals('active', twaccount.getStatus());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,04, 21,37,41), twaccount.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,06, 01,15,02), twaccount.getDateUpdated());
	}
}