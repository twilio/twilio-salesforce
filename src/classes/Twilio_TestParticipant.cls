@isTest
private class Twilio_TestParticipant 
{
	final static String authToken = '12345678901234567890123456789012';
		
	static testmethod void testTwilioparticipants() {
		String accountJsonResponseBody ='{"num_pages": 1,"page": 0,"page_size": 50,"start": 0,"total": 2,"end": 1,'
		+'"first_page_uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants.json?Page=0&PageSize=50",'
		+'"last_page_uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants.json?Page=0&PageSize=50",'
		+'"next_page_uri": null,'
		+'"previous_page_uri": null,'
		+'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants.json",'
		+'"participants": [{'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"call_sid": "CA386025c9bf5d6052a1d1ea42b4d16662",'
		+'"conference_sid": "CFbbe46ff1274e283f7e3ac1df0072ab39",'
		+'"date_created": "Wed, 18 Aug 2010 20:20:10 +0000",'
		+'"date_updated": "Wed, 18 Aug 2010 20:20:10 +0000",'
		+'"end_conference_on_exit": true,'
		+'"muted": false,'
		+'"start_conference_on_enter": true,'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants/CA386025c9bf5d6052a1d1ea42b4d16662.json"'
		+'}]}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Participants.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			); 
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		/*TwilioParticipantList twppslist = api.getClient().getAccount().getParticipants();
		System.assertNotEquals(null, twppslist);
		
		List<TwilioParticipant> twpps = twppslist.getPageData();
			System.assertEquals(1, twpps.size());
			TwilioParticipant twpcpts=twpps.get(0);
			
			System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', twpcpts.getaccountsid());
			System.assertEquals('CA386025c9bf5d6052a1d1ea42b4d16662', twpcpts.getcallsid());
			System.assertEquals('CFbbe46ff1274e283f7e3ac1df0072ab39', twpcpts.getconferencesid());
			System.assertEquals(Datetime.newInstanceGmt(2010,8,18,20,20,10),twpcpts.getDateCreated());
			System.assertEquals(Datetime.newInstanceGmt(2010,8,18,20,20,10),twpcpts.getDateUpdated());
			System.assertEquals(false,twpcpts.isMuted()); 
			System.assertEquals(true,twpcpts.isStartConferenceOnEnter());
			System.assertEquals(true,twpcpts.isEndConferenceOnExit());*/
	}
			
}