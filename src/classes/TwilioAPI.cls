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
global class TwilioAPI {

	private class MissingTwilioConfigCustomSettingsException extends Exception {}

	private static TwilioRestClient client;
	
    private TwilioAPI() {}
    
    public static TwilioRestClient getDefaultClient() {
    	if (client==null) {
    		TwilioConfig__c twilioCfg = getTwilioConfig();
	    	TwilioAPI.client = new TwilioRestClient(twilioCfg.AccountSid__c, twilioCfg.AuthToken__c);
    	}
	   	return TwilioAPI.client;
    }
    
    public static TwilioAccount getDefaultAccount() {
    	return getDefaultClient().getAccount();
    }
    
    public static TwilioCapability createCapability() {
		TwilioConfig__c twilioCfg = getTwilioConfig();
		return new TwilioCapability(twilioCfg.AccountSid__c, twilioCfg.AuthToken__c);    	
    }
    
    public static TwilioRestClient createClient(String accountSid, String authToken) {
    	return new TwilioRestClient(accountSid, authToken);
    }
    
    public static TwilioConfig__c getTwilioConfig() {
    	TwilioConfig__c twilioCfg;
    	if (Test.isRunningTest()) {
    		twilioCfg = new TwilioConfig__c();
    		twilioCfg.AccountSid__c = 'ACba8bc05eacf94afdae398e642c9cc32d';
    		twilioCfg.AuthToken__c = '12345678901234567890123456789012';
    	} else {
    		twilioCfg = TwilioConfig__c.getOrgDefaults();
	    	if (twilioCfg==null)
	    		throw new MissingTwilioConfigCustomSettingsException('Please enter your Twilio account credentials under Twilio Config custom settings (go to Setup | Develop | Custom Settings | Manage Twilio Config)');
    	}
   		return twilioCfg;
    }

    
    @isTest
    static void test_TwilioAPI() {
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', TwilioAPI.getTwilioConfig().AccountSid__c);
		System.assertEquals('12345678901234567890123456789012', TwilioAPI.getTwilioConfig().AuthToken__c);
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', TwilioAPI.getDefaultClient().getAccountSid());
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', TwilioAPI.getDefaultClient().getAccount().getSid());
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', TwilioAPI.getDefaultAccount().getSid());
	}
	
}