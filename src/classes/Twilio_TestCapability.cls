@isTest
class Twilio_TestCapability {

	/* TEST METHODS */
    
    final static String ACCOUNT_SID = 'CA5ea9c5d78e1f35fc01c204682d056e22';
	final static String AUTH_TOKEN = '12345678901234567890123456789012';
	final static String APP_SID = 'AP9b2e38d8c592488c397fc871a82a74ec';

	static testMethod void testTwilioCapability_outgoing() {
		TwilioCapability capability = new TwilioCapability(ACCOUNT_SID, AUTH_TOKEN);
		capability.allowClientOutgoing(APP_SID);
		System.assertEquals(true, capability.test_buildOutgoingScope);
		System.assertEquals(APP_SID, capability.test_appSid);
		
		String token = capability.generateToken();
		
		Map<String,String> filters = new Map<String,String> {'foo' => 'bar'};
		capability = new TwilioCapability(ACCOUNT_SID, AUTH_TOKEN);
		capability.allowClientOutgoing(APP_SID, filters);
		System.assertEquals(true, capability.test_buildOutgoingScope);
		System.assertEquals(APP_SID, capability.test_appSid);
		System.assertEquals(filters, capability.test_outgoingParams);
		String token2 = capability.generateToken(100);
	}
	
	static testMethod void testTwilioCapability_incoming() {
		TwilioCapability capability = new TwilioCapability(ACCOUNT_SID, AUTH_TOKEN);
		capability.allowClientIncoming('Jenny');
		System.assertEquals('Jenny',capability.test_incomingClientName);
		String token = capability.generateToken();
	}
	
	static testMethod void testTwilioCapability_bidirectional() {		
		TwilioCapability capability = new TwilioCapability(ACCOUNT_SID, AUTH_TOKEN);
		capability.allowClientIncoming('Jenny');
		capability.allowClientOutgoing(APP_SID);
		System.assertEquals('Jenny',capability.test_incomingClientName);
		System.assertEquals(APP_SID,capability.test_appSid);
		String token = capability.generateToken();
	}

	static testMethod void testTwilioCapability_eventstream() {
		Map<String,String> filters = new Map<String,String> {'foo' => 'bar'};
		TwilioCapability capability = new TwilioCapability(ACCOUNT_SID, AUTH_TOKEN);
		capability.allowEventStream(filters);
		System.assertEquals(1, capability.test_scopes.size());
		System.assertEquals('scope:stream:subscribe?path=%2F2010-04-01%2FEvents&params=foo%3Dbar', capability.test_scopes.get(0));
		String token = capability.generateToken();
	}
}