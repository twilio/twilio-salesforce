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
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d.json', twaccount.getUri());
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Transcriptions.json', twaccount.getSubresourceUris().get('transcriptions'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/SMS/Messages.json', twaccount.getSubresourceUris().get('sms_messages'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Sandbox.json', twaccount.getSubresourceUris().get('sandbox'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Recordings.json', twaccount.getSubresourceUris().get('recordings'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/OutgoingCallerIds.json', twaccount.getSubresourceUris().get('outgoing_caller_ids'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Notifications.json', twaccount.getSubresourceUris().get('notifications'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/IncomingPhoneNumbers.json', twaccount.getSubresourceUris().get('incoming_phone_numbers'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Conferences.json', twaccount.getSubresourceUris().get('conferences'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/Calls.json', twaccount.getSubresourceUris().get('calls'));
		System.assertEquals('/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers.json', twaccount.getSubresourceUris().get('available_phone_numbers'));
			
	}
	
	static testmethod void testTwilioAccountList() {
		// create the response body to be returned when the account URI is requested
		String accountJsonResponseBody =
			'{"accounts":[{"sid": "ACba8bc05eacf94afdae398e642c9cc32d",'
        	+'"owner_account_sid": "ACba8bc05eacf94afdae398e642c9cc32d",'
			+'"friendly_name": "Do you like my friendly name?",'
			+'"type": "Full",'
			+'"status": "active",'
			+'"date_created": "Wed, 04 Aug 2010 21:37:41 +0000",'
			+'"date_updated": "Fri, 06 Aug 2010 01:15:02 +0000",'
			+'"auth_token": "redacted",'
			+'"uri": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d.json",'
			+'"subresource_uris": {'
				+'"authorized_connect_apps": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AuthorizedConnectApps.json",'
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
		    +'}},{"sid": "ACba8bc05eacf94afdae398e642c9cc32e",'
			+'"connect_app_sid": "CN8ff53fc8e48dfed305a8742c913b68a1",'
        	+'"owner_account_sid": "ACba8bc05eacf94afdae398e642c9cc32d",'
        	+'"friendly_name": "Subaccount for ConnectApp: Test",'
			+'"type": "Full",'
			+'"status": "active",'
			+'"date_created": "Wed, 04 Aug 2010 21:37:41 +0000",'
			+'"date_updated": "Fri, 06 Aug 2010 01:15:02 +0000",'
			+'"auth_token": "redacted",'
			+'"uri": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e.json",'
			+'"subresource_uris": {'
				+'"authorized_connect_apps": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/AuthorizedConnectApps.json",'
				+'"available_phone_numbers": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/AvailablePhoneNumbers.json",'
		        +'"calls": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/Calls.json",'
		        +'"conferences": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/Conferences.json",'
		        +'"incoming_phone_numbers": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/IncomingPhoneNumbers.json",'
		        +'"notifications": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/Notifications.json",'
		        +'"outgoing_caller_ids": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/OutgoingCallerIds.json",'
		        +'"recordings": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/Recordings.json",'
		        +'"sandbox": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/Sandbox.json",'
		        +'"sms_messages": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/SMS/Messages.json",'
		        +'"transcriptions": "/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32e/Transcriptions.json"'
		    +'}}],"page":0,"total":2}';

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
		System.assertEquals(2,accounts.size());
        TwilioAccount twaccount = accounts.get(0);
        System.assertNotEquals(null, twaccount);
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', twaccount.getSid());
		System.assertEquals('redacted', twaccount.getAuthToken());
		System.assertEquals('Do you like my friendly name?', twaccount.getFriendlyName());
		System.assertEquals('Full', twaccount.getType());
		System.assertEquals('active', twaccount.getStatus());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,04, 21,37,41), twaccount.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,06, 01,15,02), twaccount.getDateUpdated());
		
		Iterator<TwilioAccount> it = twaccounts.iterator();		
		System.assertEquals(true, it.hasnext());
		TwilioAccount acc=it.next();
		System.assertEquals('Full', acc.getType());
		
		TwilioAccount connectAcc=it.next();
		System.assertEquals('CN8ff53fc8e48dfed305a8742c913b68a1',connectAcc.getConnectAppSid());
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d',connectAcc.getOwnerAccountSid());
		
		System.assertEquals(false, it.hasnext());
		
		TwilioAccountList atwaccounts = new TwilioAccountList(api.getClient());
	}
	
	static testmethod void testTwilioAccountList_createsubaccount() {
		// create the response body to be returned when the account URI is requested
		String accountJsonResponseBody =
			'{"sid":"ACba8bc05eacf94afdae398e642c9cc32d",'
			+'"owner_account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3",'
			+'"friendly_name":"SubAccount Created at 2012-02-10 03:38 am",'
			+'"status":"active",'
			+'"date_created":"Fri, 10 Feb 2012 11:38:25 +0000",'
			+'"date_updated":"Fri, 10 Feb 2012 11:38:26 +0000",'
			+'"auth_token":"hidden",'
			+'"type":"Full","uri":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24.json",'
			+'"subresource_uris":'
			+'{"authorized_connect_apps":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/AuthorizedConnectApps.json",'
			+'"available_phone_numbers":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/AvailablePhoneNumbers.json",'
			+'"calls":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/Calls.json",'
			+'"conferences":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/Conferences.json",'
			+'"connect_apps":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/ConnectApps.json",'
			+'"incoming_phone_numbers":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/IncomingPhoneNumbers.json",'
			+'"notifications":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/Notifications.json",'
			+'"outgoing_caller_ids":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/OutgoingCallerIds.json",'
			+'"recordings":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/Recordings.json",'
			+'"sandbox":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/Sandbox.json",'
			+'"sms_messages":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/SMS/Messages.json",'
			+'"transcriptions":"/2010-04-01/Accounts/ACdabeb441bbb54d71bd0feb5edc796c24/Transcriptions.json"}}';

		// register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('ACba8bc05eacf94afdae398e642c9cc32d',authToken);
        map<String,string> params=new map<String,string>();
		params.put('sid','AC03c2fcd60e144e7cbeed179fcbf812a3');
		params.put('friendly_name','harsha.simha@mansasys.com');

        TwilioAccount twaccount = api.getClient().getAccounts().createAccount(params);

		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', twaccount.getSid());
		System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3', twaccount.getowneraccountSid());
		System.assertEquals('hidden', twaccount.getAuthToken());
		System.assertEquals('SubAccount Created at 2012-02-10 03:38 am', twaccount.getFriendlyName());
		System.assertEquals('Full', twaccount.getType());
		System.assertEquals('active', twaccount.getStatus());
		System.assertEquals(Datetime.newInstanceGmt(2012,02,10, 11,38,25), twaccount.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2012,02,10, 11,38,26), twaccount.getDateUpdated());
		
	}
}