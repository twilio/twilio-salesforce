@isTest
private class Twilio_TestConnectApp  {

    final static String authToken = '12345678901234567890123456789012';
		
	static testmethod void testTwilioconectapps() {
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
		TwilioAPI api = new TwilioAPI('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioConnectAppList conectapplist = api.getClient().getAccount().getConnectApps(new Map<String, String>()) ;
		System.assertNotEquals(null, conectapplist);
		
		List<TwilioConnectApp> conectapp= conectapplist.getPageData();
		System.assertNotEquals(null, conectapp);
		System.assertEquals(1, conectapp.size());
		System.assertEquals('CNb989fdd207b04d16aee578018ef5fd93', conectapp[0].getSid());
		System.assertEquals('My awesome ConnectApp',conectapp[0].getFriendlyName());
		System.assertEquals(null,conectapp[0].getDateCreated());
		System.assertEquals(null,conectapp[0].getDateUpdated());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',conectapp[0].getAccountSid());
		System.assertEquals('An amazing TwilioConnect application that does amazing things!',conectapp[0].getdescription());
		System.assertEquals('My Company',conectapp[0].getCompanyName());
		System.assertEquals('http://www.mycompany.com',conectapp[0].getHomepageUrl());
		System.assertEquals('https://www.mycompany.com/connect_deauthorize',conectapp[0].getDeauthorizeCallbackUrl());
		System.assertEquals('https://www.mycompany.com/connect_authorize',conectapp[0].getAuthorizeRedirectUrl());
		System.assertEquals('POST',conectapp[0].getDeauthorizeCallbackMethod());
		System.assertEquals(2,conectapp[0].getPermissions().size());
		System.assertEquals('get-all',conectapp[0].getPermissions()[0]);
		System.assertEquals('post-all',conectapp[0].getPermissions()[1]);
		System.assertEquals(new list<string>{'get-all','post-all'},conectapp[0].getPermissions());
		
		Iterator<TwilioConnectApp> it = conectapplist.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioConnectApp twapps1=it.next();
		System.assertEquals(false, it.hasNext());
	}
	
	static testmethod void testTwilioconectapp() {
		string respbdy='{"sid": "CN47260e643654388faabe8aaa18ea6756","account_sid": "AC5ef872f6da5a21de157d80997a64bd33",'
		+'"permissions": ["get-all", "post-all"],"friendly_name": "My Connect App",'
		+'"description": null,"company_name": "My Company","homepage_url": "http://www.mycompany.com"}';
		
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/ConnectApps/CN47260e643654388faabe8aaa18ea6756.json',
			new Twilio_TestHTTPMock.Response(respbdy,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC5ef872f6da5a21de157d80997a64bd33', authToken);
		TwilioConnectApp connectapp = api.getClient().getAccount().getConnectApp('CN47260e643654388faabe8aaa18ea6756') ;
		
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
	
	static testmethod void createtestTwilioconectapp() {
		string respbdy='{"sid": "CN47260e643654388faabe8aaa18ea6756","account_sid": "AC5ef872f6da5a21de157d80997a64bd33",'
		+'"permissions": ["get-all", "post-all"],"friendly_name": "My Connect App",'
		+'"description": null,"company_name": "My Company","homepage_url": "http://www.mycompany.com"}';
		
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/ConnectApps.json',
			new Twilio_TestHTTPMock.Response(respbdy,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioAPI api = new TwilioAPI('AC5ef872f6da5a21de157d80997a64bd33', authToken);
		TwilioConnectAppList tcapl= new TwilioConnectAppList(api.getclient()); 
		map<string,string> params=new map<string,string>();
		params.put('FriendlyName','testconnapp1');
		params.put('AuthorizeRedirectUrl','http://www.testauth.com');
		params.put('DeAuthorizeRedirectUrl','http://www.testdeauth.com');
		params.put('CompanyName','testcomp');
		params.put('HomepageUrl','http://www.testhome.com');
		tcapl.setRequestAccountsid('AC5ef872f6da5a21de157d80997a64bd33');
		TwilioConnectApp connectapp=tcapl.createConnectApp(params);
		
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
		
		TwilioConnectApp connectapp1=new TwilioConnectApp(api.getclient());
	}
}