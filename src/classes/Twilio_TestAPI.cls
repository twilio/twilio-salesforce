@isTest
private class Twilio_TestAPI {
    
    @isTest
    static void test_TwilioAPI() {
        System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', TwilioAPI.getTwilioConfig().AccountSid__c);
        System.assertEquals('12345678901234567890123456789012', TwilioAPI.getTwilioConfig().AuthToken__c);
        System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', TwilioAPI.getDefaultClient().getAccountSid());
        System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', TwilioAPI.getDefaultClient().getAccount().getSid());
        System.assertEquals('ACba8bc05eacf94afdae398e642c9cc32d', TwilioAPI.getDefaultAccount().getSid());
    }
    
}