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