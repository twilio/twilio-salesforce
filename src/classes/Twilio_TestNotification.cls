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
private class Twilio_TestNotification {
	final static String authToken = '12345678901234567890123456789012';
		 
	static testmethod void testTwilioNotications_get_filters() {
		String accountJsonResponseBody ='{"numpages": 0, "end": 49, "pagesize": 50, "nextpageuri": "",'
		+'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Notifications.json", "page": 0,'
		+'"notifications": [{"sid": "NO11cc7e50dc46a37eb4ebfaa67a66dc76", "account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"call_sid": "CA0a51c27d11664fedb1de993c5bd1a57b", "log": "0", "error_code": "11100", '
		+'"more_info": "http://www.twilio.com/docs/errors/11100", "message_text": '
		+'"EmailNotification=false&LogLevel=ERROR&invalidUrl=http%3A%2F%2Fhttp%3A%2F%2Fshsimha-developer-edition.ap1.force.com%2F&Msg=Invalid+URL&'
		+'ErrorCode=11100", "message_date": "Thu, 1 Feb 2012 10:49:17 +0000", "request_method": "None", "request_url": "", '
		+'"date_created": "Thu, 1 Feb 2012 10:49:17 +0000", "api_version": "2010-04-01", "date_updated": "Thu, 1 Feb 2012 10:49:17 +0000", '
		+'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Notifications/NO11cc7e50dc46a37eb4ebfaa67a66dc76.json"}], "firstpageuri": '
		+'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Notifications.json?Page=0&PageSize=50", "previouspageuri": "", "lastpageuri": '
		+'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Notifications.json?Page=0&PageSize=50", "total": 3, "start": 0}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Notifications.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioNotificationList twnots = client.getAccount().getNotifications();
		System.assertNotEquals(null, twnots);
		
		List<TwilioNotification> twnotslist = twnots.getPageData();
		System.assertNotEquals(null, twnotslist);
		System.assertEquals(1, twnotslist.size());
		
		TwilioNotification twnotif=twnotslist.get(0);
		System.assertEquals('NO11cc7e50dc46a37eb4ebfaa67a66dc76', twnotif.getSid());
		System.assertEquals('CA0a51c27d11664fedb1de993c5bd1a57b',twnotif.getcallsid());		
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twnotif.getAccountSid());
		System.assertEquals('2010-04-01',twnotif.getApiVersion());
		System.assertEquals('0',twnotif.getlog());
		System.assertEquals('11100',twnotif.geterrorcode());
		System.assertEquals('http://www.twilio.com/docs/errors/11100',twnotif.getmoreInfo());
		System.assertEquals('EmailNotification=false&LogLevel=ERROR&invalidUrl=http%3A%2F%2Fhttp%3A%2F%2Fshsimha-developer-edition.ap1.force.com%2F&Msg=Invalid+URL&ErrorCode=11100',twnotif.getMessageText());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getMessageDate());		
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getDateUpdated());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getDateCreated());
		System.assertEquals('',twnotif.getrequestUrl());//reqmeth
		System.assertEquals(null,twnotif.getrequestVariables());
		System.assertEquals(null,twnotif.getresponseHeaders());
		System.assertEquals(null,twnotif.getresponseBody());
		System.assertEquals('None',twnotif.getRequestMethod());
		
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Notifications.json?log=0',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		map<String,string> params=new map<string,string>();
		params.put('log','0');
		twnots = client.getAccount().getNotifications(params);
		System.assertNotEquals(null, twnots);
		
		Iterator<TwilioNotification> twnotslist1 = twnots.iterator();
		System.assertEquals(true, twnotslist1.hasnext());
		
		twnotif=twnotslist1.next();
		System.assertEquals('NO11cc7e50dc46a37eb4ebfaa67a66dc76', twnotif.getSid());
		System.assertEquals('CA0a51c27d11664fedb1de993c5bd1a57b',twnotif.getcallsid());		
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twnotif.getAccountSid());
		System.assertEquals('2010-04-01',twnotif.getApiVersion());
		System.assertEquals('0',twnotif.getlog());
		System.assertEquals('11100',twnotif.geterrorcode());
		System.assertEquals('http://www.twilio.com/docs/errors/11100',twnotif.getmoreInfo());
		System.assertEquals('EmailNotification=false&LogLevel=ERROR&invalidUrl=http%3A%2F%2Fhttp%3A%2F%2Fshsimha-developer-edition.ap1.force.com%2F&Msg=Invalid+URL&ErrorCode=11100',twnotif.getMessageText());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getMessageDate());		
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getDateUpdated());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getDateCreated());
		System.assertEquals('',twnotif.getrequestUrl());
		System.assertEquals(null,twnotif.getrequestVariables());
		System.assertEquals(null,twnotif.getresponseHeaders());
		System.assertEquals(null,twnotif.getresponseBody());
		
	}
	
	static testmethod void testTwilioNotication_get() {
		String accountJsonResponseBody ='{"sid": "NO11cc7e50dc46a37eb4ebfaa67a66dc76", "account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"call_sid": "CA0a51c27d11664fedb1de993c5bd1a57b", "log": "0", "error_code": "11100", '
		+'"more_info": "http://www.twilio.com/docs/errors/11100", "message_text": '
		+'"EmailNotification=false&LogLevel=ERROR&invalidUrl=http%3A%2F%2Fhttp%3A%2F%2Fshsimha-developer-edition.ap1.force.com%2F&Msg=Invalid+URL&'
		+'ErrorCode=11100", "message_date": "Thu, 1 Feb 2012 10:49:17 +0000", "request_method": "None", "request_url": "", '
		+'"date_created": "Thu, 1 Feb 2012 10:49:17 +0000", "api_version": "2010-04-01", "date_updated": "Thu, 1 Feb 2012 10:49:17 +0000", '
		+'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Notifications/NO11cc7e50dc46a37eb4ebfaa67a66dc76.json"}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Notifications/NO11cc7e50dc46a37eb4ebfaa67a66dc76.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		
		TwilioNotification twnotif=client.getAccount().getNotification('NO11cc7e50dc46a37eb4ebfaa67a66dc76');
		System.assertEquals('NO11cc7e50dc46a37eb4ebfaa67a66dc76', twnotif.getSid());
		System.assertEquals('CA0a51c27d11664fedb1de993c5bd1a57b',twnotif.getCallSid());		
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twnotif.getAccountSid());
		System.assertEquals('2010-04-01',twnotif.getApiVersion());
		System.assertEquals('0',twnotif.getLog());
		System.assertEquals('11100',twnotif.getErrorCode());
		System.assertEquals('http://www.twilio.com/docs/errors/11100',twnotif.getmoreInfo());
		System.assertEquals('EmailNotification=false&LogLevel=ERROR&invalidUrl=http%3A%2F%2Fhttp%3A%2F%2Fshsimha-developer-edition.ap1.force.com%2F&Msg=Invalid+URL&ErrorCode=11100',twnotif.getMessageText());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getMessageDate());		
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getDateUpdated());
		System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twnotif.getDateCreated());
		System.assertEquals('',twnotif.getRequestUrl());
		System.assertEquals(null,twnotif.getRequestVariables());
		System.assertEquals(null,twnotif.getResponseHeaders());
		System.assertEquals(null,twnotif.getResponseBody());
		System.assertEquals('/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Notifications/NO11cc7e50dc46a37eb4ebfaa67a66dc76.json',twnotif.getUri());
		
	}
	
	static testmethod void testTwilioNotificiations_delete() {	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
				'DELETE',
				'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Notifications/NO11cc7e50dc46a37eb4ebfaa67a66dc76.json',
				new Twilio_TestHTTPMock.Response('',204)
			); 
		
			
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		boolean isdel = client.getAccount().getNotification('NO11cc7e50dc46a37eb4ebfaa67a66dc76').deleteNotification();
		system.assert(true,isdel); 
		
		TwilioNotification twnot = new TwilioNotification(client);
		TwilioNotificationList lsttwnot = new TwilioNotificationList(client);
	}
}