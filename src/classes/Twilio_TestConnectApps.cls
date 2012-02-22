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
private class Twilio_TestConnectApps {

    final static String authToken = '12345678901234567890123456789012';
		
	static testmethod void testTwilioConnectAppList_get() {
		string respbdy='{"connect_apps": [{"sid": "CNb989fdd207b04d16aee578018ef5fd93",'
		+'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"friendly_name": "My awesome ConnectApp",'
		+'"description": "An amazing TwilioConnect application that does amazing things!",'
		+'"company_name": "My Company",'
		+'"homepage_url": "http://www.mycompany.com",'
		+'"authorize_redirect_url": "https://www.mycompany.com/connect_authorize",'
		+'"deauthorize_callback_url": "https://www.mycompany.com/connect_deauthorize",'
		+'"deauthorize_callback_method": "POST",'
		+'"permissions": ["get-all","post-all"]'
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
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/ConnectApps.json',
			new Twilio_TestHTTPMock.Response(respbdy,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioConnectAppList conectapplist = client.getAccount().getConnectApps(new Map<String, String>()) ;
		System.assertNotEquals(null, conectapplist);
		
		List<TwilioConnectApp> connectApp= conectapplist.getPageData();
		System.assertNotEquals(null, connectApp);
		System.assertEquals(1, connectApp.size());
		System.assertEquals('CNb989fdd207b04d16aee578018ef5fd93', connectApp[0].getSid());
		System.assertEquals('My awesome ConnectApp',connectApp[0].getFriendlyName());
		System.assertEquals(null,connectApp[0].getDateCreated());
		System.assertEquals(null,connectApp[0].getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',connectApp[0].getAccountSid());
		System.assertEquals('An amazing TwilioConnect application that does amazing things!',connectApp[0].getdescription());
		System.assertEquals('My Company',connectApp[0].getCompanyName());
		System.assertEquals('http://www.mycompany.com',connectApp[0].getHomepageUrl());
		System.assertEquals('https://www.mycompany.com/connect_deauthorize',connectApp[0].getDeauthorizeCallbackUrl());
		System.assertEquals('https://www.mycompany.com/connect_authorize',connectApp[0].getAuthorizeRedirectUrl());
		System.assertEquals('POST',connectApp[0].getDeauthorizeCallbackMethod());
		System.assertEquals(2,connectApp[0].getPermissions().size());
		System.assertEquals('get-all',connectApp[0].getPermissions()[0]);
		System.assertEquals('post-all',connectApp[0].getPermissions()[1]);
		System.assertEquals(new list<string>{'get-all','post-all'},connectApp[0].getPermissions());
		
		Iterator<TwilioConnectApp> it = conectapplist.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioConnectApp twapps1=it.next();
		System.assertEquals(false, it.hasNext());
	}
	
	static testmethod void testTwilioConnectApp_get() {
		string respbdy='{"sid": "CN47260e643654388faabe8aaa18ea6756","account_sid": "AC5ef872f6da5a21de157d80997a64bd33",'
		+'"permissions": ["get-all", "post-all"],"friendly_name": "My Connect App",'
		+'"description": null,"company_name": "My Company","homepage_url": "http://www.mycompany.com"}';
		
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/ConnectApps/CN47260e643654388faabe8aaa18ea6756.json',
			new Twilio_TestHTTPMock.Response(respbdy,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC5ef872f6da5a21de157d80997a64bd33', authToken);
		TwilioConnectApp connectapp = client.getAccount().getConnectApp('CN47260e643654388faabe8aaa18ea6756') ;
		
		System.assertEquals('CN47260e643654388faabe8aaa18ea6756', connectapp.getSid());
		System.assertEquals('My Connect App',connectapp.getFriendlyName());
		System.assertEquals(null,connectapp.getDateCreated());
		System.assertEquals(null,connectapp.getDateUpdated());
		System.assertEquals('AC5ef872f6da5a21de157d80997a64bd33',connectapp.getAccountSid());
		System.assertEquals(null,connectapp.getdescription());
		System.assertEquals('My Company',connectapp.getCompanyName());
		System.assertEquals('http://www.mycompany.com',connectapp.getHomepageUrl());
		System.assertEquals(null,connectapp.getDeauthorizeCallbackUrl());
		System.assertEquals(null,connectapp.getAuthorizeRedirectUrl());
		System.assertEquals(null,connectapp.getDeauthorizeCallbackMethod());
		System.assertEquals(2,connectapp.getPermissions().size());
		System.assertEquals('get-all',connectapp.getPermissions()[0]);
		System.assertEquals('post-all',connectapp.getPermissions()[1]);
		System.assertEquals(new list<string>{'get-all','post-all'},connectapp.getPermissions());
	}

	static testmethod void testAuthorizedConnectAppList_get() {
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
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioAuthorizedConnectAppList authconectapplist= client.getAccount().getAuthorizedConnectApps(new map<string,string>());
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
	
	static testmethod void testAuthorizedConnectApp_get() {
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
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioAuthorizedConnectApp authconectapp = client.getAccount().getAuthorizedConnectApp('CNb989fdd207b04d16aee578018ef5fd93');
		
		System.assertEquals('CNb989fdd207b04d16aee578018ef5fd93', authconectapp.getSid());
		System.assertEquals('Jenny Tracker',authconectapp.getFriendlyName());
		System.assertEquals(null,authconectapp.getDateCreated());
		System.assertEquals(null,authconectapp.getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',authconectapp.getAccountSid());
		System.assertEquals(null,authconectapp.getdescription());
		System.assertEquals('Tommy PI',authconectapp.getCompanyName());
		System.assertEquals('http://www.tommypi.com',authconectapp.getHomepageUrl());		
		System.assertEquals(new list<string>{'get-all','post-all'},authconectapp.getPermissions());
	}

}