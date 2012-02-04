global class TwilioAPI {

	private static final String defaultAccountSid = 'AC03c2fcd60e144e7cbeed179fcbf812a3';
    private static final String defaultAuthToken = '9339f87c4573196830a8f497bceb8fa9'; 
  
  
    private TwilioRestClient client;
    
    public TwilioAPI() {
    	this(defaultAccountSid, defaultAuthToken);
    }
	
    public TwilioAPI(String accountSid, String authToken) {
        client = new TwilioRestClient(accountSid, authToken); // using defaults
    }
    
    public TwilioRestClient getClient() {
	   	return this.client;
    }
    
    @isTest
    static void test_TwilioAPI() {
		TwilioAPI api = new TwilioAPI('ACba8bc05eacf94afdae398e642c9cc32d','12345678901234567890123456789012');
		System.assertNotEquals(null, api.getClient());
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', api.getClient().getAccountSid());
		System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', api.getClient().getAccount().getSid());
		
		TwilioAPI apiDefault = new TwilioAPI();
		System.assertNotEquals(null, apiDefault.getClient());
		System.assertEquals(TwilioAPI.defaultAccountSid, apiDefault.getClient().getAccountSid());
		System.assertEquals(TwilioAPI.defaultAccountSid, apiDefault.getClient().getAccount().getSid());	
	}
}