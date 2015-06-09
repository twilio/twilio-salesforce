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
private class Twilio_TestConference 
{
	final static String authToken = '12345678901234567890123456789012';
	
	static testmethod void testTwilioConferenceList_get() {
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
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioConferenceList twconflist = client.getAccount().getConferences();
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
		//system.debug(twconf[0].getParticipants()+'-----------------');
		//System.assertEquals(new list<TwilioParticipant>(),twconf[0].getParticipants().getPageData());
		
	}
	
	static testmethod void testTwilioConferenceList_get_filter() {
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
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		map<string,string> p=new map<string,string>();
		p.put('status','completed');
		TwilioConferenceList twconflist = client.getAccount().getConferences(p);
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
	
	static testmethod void testTwilioConference_get() {
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
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);		
		TwilioConference twconf = client.getAccount().getConference('CFbbe46ff1274e283f7e3ac1df0072ab39');
		
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
		
		TwilioConference twconf1=new TwilioConference(client);
		TwilioConferenceList twconflist=new TwilioConferenceList(client);
	}
	
	static testmethod void testTwilioParticipants_get() {
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
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			); 
		
			// Get an API client and request the Twilio Account
			TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);		
			TwilioParticipantList twppslist = new TwilioParticipantList(client,'CFbbe46ff1274e283f7e3ac1df0072ab39');		
			twppslist.setRequestAccountsid('AC03c2fcd60e144e7cbeee413fcbf812a3');
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
			System.assertEquals(true,twpcpts.isEndConferenceOnExit());
			System.assertEquals('/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants/CA386025c9bf5d6052a1d1ea42b4d16662.json', twpcpts.getUri());
			
			Iterator<TwilioParticipant> it = twppslist.iterator();
			system.assertEquals(true,it.hasnext());
			TwilioParticipant twp= it.next(); 
			system.assertEquals(false,it.hasnext());
			
			TwilioParticipantList twppslist1 = new TwilioParticipantList(client);
			TwilioParticipant twpps1 = new TwilioParticipant(client);
	}
	
	static testmethod void testTwilioParticipantList_mute() {
		String accountJsonResponseBody ='{'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"call_sid": "CA386025c9bf5d6052a1d1ea42b4d16662",'
		+'"conference_sid": "CFbbe46ff1274e283f7e3ac1df0072ab39",'
		+'"date_created": "Wed, 18 Aug 2010 20:20:10 +0000",'
		+'"date_updated": "Wed, 18 Aug 2010 20:20:10 +0000",'
		+'"end_conference_on_exit": true,'
		+'"muted": true,'
		+'"start_conference_on_enter": true,'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants/CA386025c9bf5d6052a1d1ea42b4d16662.json"'
		+'}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants/CA386025c9bf5d6052a1d1ea42b4d16662.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			); 
		
			
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);		
		TwilioParticipant twppslist = new TwilioParticipant(client,'CFbbe46ff1274e283f7e3ac1df0072ab39','CA386025c9bf5d6052a1d1ea42b4d16662');		
		twppslist.setRequestAccountsid('AC03c2fcd60e144e7cbeee413fcbf812a3');
		
		TwilioParticipant twpcpts=twppslist.mute(); 
		
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', twpcpts.getaccountsid());
		System.assertEquals('CA386025c9bf5d6052a1d1ea42b4d16662', twpcpts.getcallsid());
		System.assertEquals('CFbbe46ff1274e283f7e3ac1df0072ab39', twpcpts.getconferencesid());
		System.assertEquals(Datetime.newInstanceGmt(2010,8,18,20,20,10),twpcpts.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,8,18,20,20,10),twpcpts.getDateUpdated());
		System.assertEquals(true,twpcpts.isMuted()); 
		System.assertEquals(true,twpcpts.isStartConferenceOnEnter());
		System.assertEquals(true,twpcpts.isEndConferenceOnExit());
	}
	
	static testmethod void testTwilioParticipantList_unmute() {
		String accountJsonResponseBody ='{'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"call_sid": "CA386025c9bf5d6052a1d1ea42b4d16662",'
		+'"conference_sid": "CFbbe46ff1274e283f7e3ac1df0072ab39",'
		+'"date_created": "Wed, 18 Aug 2010 20:20:10 +0000",'
		+'"date_updated": "Wed, 18 Aug 2010 20:20:10 +0000",'
		+'"end_conference_on_exit": true,'
		+'"muted": false,'
		+'"start_conference_on_enter": true,'
		+'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants/CA386025c9bf5d6052a1d1ea42b4d16662.json"'
		+'}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants/CA386025c9bf5d6052a1d1ea42b4d16662.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			); 
		
			
			TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);		
			TwilioParticipant twppslist = new TwilioParticipant(client,'CFbbe46ff1274e283f7e3ac1df0072ab39','CA386025c9bf5d6052a1d1ea42b4d16662');		
			twppslist.setRequestAccountSid('AC03c2fcd60e144e7cbeee413fcbf812a3');
			
			TwilioParticipant twpcpts = twppslist.unmute(); 
			
			System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', twpcpts.getaccountsid());
			System.assertEquals('CA386025c9bf5d6052a1d1ea42b4d16662', twpcpts.getcallsid());
			System.assertEquals('CFbbe46ff1274e283f7e3ac1df0072ab39', twpcpts.getconferencesid());
			System.assertEquals(Datetime.newInstanceGmt(2010,8,18,20,20,10),twpcpts.getDateCreated());
			System.assertEquals(Datetime.newInstanceGmt(2010,8,18,20,20,10),twpcpts.getDateUpdated());
			System.assertEquals(false,twpcpts.isMuted()); 
			System.assertEquals(true,twpcpts.isStartConferenceOnEnter());
			System.assertEquals(true,twpcpts.isEndConferenceOnExit());
	}
	
	static testmethod void testTwilioParticipants_delete() {	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
				'DELETE',
				'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Conferences/CFbbe46ff1274e283f7e3ac1df0072ab39/Participants/CA386025c9bf5d6052a1d1ea42b4d16662.json',
				new Twilio_TestHTTPMock.Response('',204)
			); 
		
			
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);		
		TwilioParticipant twppslist = new TwilioParticipant(client,'CFbbe46ff1274e283f7e3ac1df0072ab39','CA386025c9bf5d6052a1d1ea42b4d16662');		
		twppslist.setRequestAccountsid('AC03c2fcd60e144e7cbeee413fcbf812a3');
		//try{
		boolean isdel=twppslist.kick();
		
		//}catch(Exception e){}
		system.assert(true,isdel); 

	}	
}
