@isTest
private class Twilio_TestConference 
{
	final static String authToken = '12345678901234567890123456789012';
	
	static testmethod void testTwilioAplicationparams() {
		String accountJsonResponseBody ='{"end": 49,'
		+'"first_page_uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences.json?Page=0&PageSize=50",'
		+'"last_page_uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences.json?Page=9&PageSize=50",'
		+'"next_page_uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences.json?Page=1&PageSize=50",'
		+'"num_pages": 10,'
		+'"page": 0,'
		+'"page_size": 50,'
		+'"previous_page_uri": null,'
		+'"start": 0,'
		+'"total": 462,'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences.json",'
		+'"conferences": ['
		+'{'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"api_version": "2010-04-01",'
		+'"date_created": "Wed, 18 Aug 2010 20:20:06 +0000",'
		+'"date_updated": "Wed, 18 Aug 2010 20:24:32 +0000",'
		+'"friendly_name": "Party Line",'
		+'"sid": "CFbbe46ff1274e283f7e3ac1df0072ab39",'
		+'"status": "completed",'
		+'"subresource_uris": {'
		+'"participants": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants.json"'
		+'},'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39.json"'
		+'}]}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Conferences.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioConferenceList twconflist = api.getClient().getAccount().getConferences();
		System.assertNotEquals(null, twconflist);
		List<TwilioConference> twconf= twconflist.getPageData();
		System.assertEquals(1, twconf.size());
		
		System.assertEquals('CFbbe46ff1274e283f7e3ac1df0072ab39', twconf[0].getsid());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', twconf[0].getAccountsid());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,18,20,20,06),twconf[0].getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,18,20,24,32),twconf[0].getDateUpdated());		
		System.assertEquals('2010-04-01',twconf[0].getApiVersion());
		System.assertEquals('Party Line',twconf[0].getfriendlyname());
		System.assertEquals('completed',twconf[0].getstatus());
		
	}
	
	static testmethod void testfilterTwilioAplicationparams() {
		String accountJsonResponseBody ='{"end": 49,'
		+'"first_page_uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences.json?Page=0&PageSize=50",'
		+'"last_page_uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences.json?Page=9&PageSize=50",'
		+'"next_page_uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences.json?Page=1&PageSize=50",'
		+'"num_pages": 10,'
		+'"page": 0,'
		+'"page_size": 50,'
		+'"previous_page_uri": null,'
		+'"start": 0,'
		+'"total": 462,'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences.json",'
		+'"conferences": ['
		+'{'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"api_version": "2010-04-01",'
		+'"date_created": "Wed, 18 Aug 2010 20:20:06 +0000",'
		+'"date_updated": "Wed, 18 Aug 2010 20:24:32 +0000",'
		+'"friendly_name": "Party Line",'
		+'"sid": "CFbbe46ff1274e283f7e3ac1df0072ab39",'
		+'"status": "completed",'
		+'"subresource_uris": {'
		+'"participants": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants.json"'
		+'},'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39.json"'
		+'}]}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Conferences.json?status=completed',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		map<string,string> p=new map<string,string>();
		p.put('status','completed');
		TwilioConferenceList twconflist = api.getClient().getAccount().getConferences(p);
		System.assertNotEquals(null, twconflist);
		
		Iterator<TwilioConference> it = twconflist.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioConference twconf=it.next();
			
		System.assertEquals('CFbbe46ff1274e283f7e3ac1df0072ab39', twconf.getsid());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', twconf.getAccountsid());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,18,20,20,06),twconf.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,18,20,24,32),twconf.getDateUpdated());		
		System.assertEquals('2010-04-01',twconf.getApiVersion());
		System.assertEquals('Party Line',twconf.getfriendlyname());
		System.assertEquals('completed',twconf.getstatus());
		System.assertnotEquals(null,twconf.getParticipants());
	}
	
	static testmethod void testptclrTwilioAplicationparams() {
		String accountJsonResponseBody ='{'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"api_version": "2010-04-01",'
		+'"date_created": "Wed, 18 Aug 2010 20:20:06 +0000",'
		+'"date_updated": "Wed, 18 Aug 2010 20:24:32 +0000",'
		+'"friendly_name": "Party Line",'
		+'"sid": "CFbbe46ff1274e283f7e3ac1df0072ab39",'
		+'"status": "completed",'
		+'"subresource_uris": {'
		+'"participants": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants.json"'
		+'},'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39.json"'
		+'}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);		
		TwilioConference twconf = api.getClient().getAccount().getConference('CFbbe46ff1274e283f7e3ac1df0072ab39');
		
		System.assertEquals('CFbbe46ff1274e283f7e3ac1df0072ab39', twconf.getsid());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', twconf.getAccountsid());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,18,20,20,06),twconf.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,18,20,24,32),twconf.getDateUpdated());		
		System.assertEquals('2010-04-01',twconf.getApiVersion());
		System.assertEquals('Party Line',twconf.getfriendlyname());
		System.assertEquals('completed',twconf.getstatus());
		/*TwilioParticipantList twpl=twconf.getParticipants();
		List<TwilioParticipant> twpps = twpl.getPageData();
			System.debug( twpps);
			TwilioParticipant twpcpts=twpps.get(0);
		*/
		
		TwilioConference twconf1=new TwilioConference(api.getclient());
		TwilioConferenceList twconflist=new TwilioConferenceList(api.getclient());
	}
}