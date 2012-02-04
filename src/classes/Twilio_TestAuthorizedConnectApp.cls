@isTest
Private class Twilio_TestAuthorizedConnectApp {
	
    final static String authToken = '12345678901234567890123456789012';
		
	static testmethod void testauthconnectapps() {
		string respbdy='{"authorized_connect_apps": [{'
		+'"connect_app_sid": "CNb989fdd207b04d16aee578018ef5fd93",'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"permissions": ["get-all", "post-all"],'
		+'"connect_app_friendly_name": "Jenny Tracker",'
		+'"connect_app_description": null,'
		+'"connect_app_company_name": "Tommy PI",'
		+'"connect_app_homepage_url": "http://www.tommypi.com"'
		+'}],'
		+'"page": 0,'
		+'"num_pages": 1,'
		+'"page_size": 50,'
		+'"total": 3,'
		+'"start": 0,'
		+'"end": 2,'
		+'"uri": "/2010-04-01/Accounts/AC81e0ca4b0af06b833b6726957613c5d4/AuthorizedConnectApps/.json",'
		+'"first_page_uri": "/2010-04-01/Accounts/AC81e0ca4b0af06b833b6726957613c5d4/AuthorizedConnectApps/.json?Page=0&PageSize=50",'
		+'"previous_page_uri": null,'
		+'"next_page_uri": null,'
		+'"last_page_uri": "/2010-04-01/Accounts/AC81e0ca4b0af06b833b6726957613c5d4/AuthorizedConnectApps/.json?Page=0&PageSize=50"'
		+'}';
		
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/AuthorizedConnectApps.json',
			new Twilio_TestHTTPMock.Response(respbdy,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioAuthorizedConnectAppList authconectapplist= api.getClient().getAccount().getAuthorizedConnectApps(new map<string,string>());
		System.assertNotEquals(null, authconectapplist);
		
		List<TwilioAuthorizedConnectApp> authconectapp= authconectapplist.getPageData();
		System.assertNotEquals(null, authconectapp);
		System.assertEquals(1, authconectapp.size());
		System.assertEquals('CNb989fdd207b04d16aee578018ef5fd93', authconectapp[0].getSid());
		System.assertEquals('Jenny Tracker',authconectapp[0].getFriendlyName());
		System.assertEquals(null,authconectapp[0].getDateCreated());
		System.assertEquals(null,authconectapp[0].getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',authconectapp[0].getAccountSid());
		System.assertEquals(null,authconectapp[0].getdescription());
		System.assertEquals('Tommy PI',authconectapp[0].getCompanyName());
		System.assertEquals('http://www.tommypi.com',authconectapp[0].getHomepageUrl());		
		System.assertEquals(new list<string>{'get-all','post-all'},authconectapp[0].getPermissions());
		
		Iterator<TwilioAuthorizedConnectApp> it = authconectapplist.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioAuthorizedConnectApp twapps1=it.next();
		System.assertEquals(false, it.hasNext());
	}
	
	static testmethod void testsingleauthconnectapp() {
		string respbdy='{'
		+'"connect_app_sid": "CNb989fdd207b04d16aee578018ef5fd93",'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"permissions": ["get-all", "post-all"],'
		+'"connect_app_friendly_name": "Jenny Tracker",'
		+'"connect_app_description": null,'
		+'"connect_app_company_name": "Tommy PI",'
		+'"connect_app_homepage_url": "http://www.tommypi.com"'
		+'}';
		
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/AuthorizedConnectApps/CNb989fdd207b04d16aee578018ef5fd93.json',
			new Twilio_TestHTTPMock.Response(respbdy,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioAuthorizedConnectApp authconectapp= api.getClient().getAccount().getAuthorizedConnectApp('CNb989fdd207b04d16aee578018ef5fd93');
		
		System.assertEquals('CNb989fdd207b04d16aee578018ef5fd93', authconectapp.getSid());
		System.assertEquals('Jenny Tracker',authconectapp.getFriendlyName());
		System.assertEquals(null,authconectapp.getDateCreated());
		System.assertEquals(null,authconectapp.getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',authconectapp.getAccountSid());
		System.assertEquals(null,authconectapp.getdescription());
		System.assertEquals('Tommy PI',authconectapp.getCompanyName());
		System.assertEquals('http://www.tommypi.com',authconectapp.getHomepageUrl());		
		System.assertEquals(new list<string>{'get-all','post-all'},authconectapp.getPermissions());
		
		TwilioAuthorizedConnectAppList tcapl= new TwilioAuthorizedConnectAppList(api.getclient());
		TwilioAuthorizedConnectApp tcap= new TwilioAuthorizedConnectApp(api.getclient());
	}
	
}