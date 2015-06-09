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
class Twilio_TestCapability {

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
    
    /* UNIT TESTS FOR PRIVATE METHODS */
    static testMethod void testGenerateParamString() {
        System.assertEquals('', TwilioCapability.generateParamString(new Map<String,String>()));
        System.assertEquals('a=b', TwilioCapability.generateParamString(new Map<String,String> {'a'=>'b'} ));
        System.assertEquals('foo=bar&cat=dog', TwilioCapability.generateParamString(new Map<String,String> {'foo'=>'bar', 'cat' => 'dog'} ));
        System.assertEquals('a=b&c=d&e=f', TwilioCapability.generateParamString(new Map<String,String> {'a'=>'b', 'c'=>'d', 'e'=>'f' } ));
        System.assertEquals('split+key1=split+val1&split+key2=split+val2', TwilioCapability.generateParamString(new Map<String,String> {'split key1'=>'split val1', 'split key2'=>'split val2'} ));
    }
    
    static testMethod void testEncodeBase64() {
        System.assertEquals('', TwilioCapability.urlSafeEncodeBase64(''));
        System.assertEquals('QQ', TwilioCapability.urlSafeEncodeBase64('A'));     
        System.assertEquals('QUI', TwilioCapability.urlSafeEncodeBase64('AB'));
        System.assertEquals('QUJDRA', TwilioCapability.urlSafeEncodeBase64('ABCD'));
    }
    
    static testMethod void testJoin() {
        System.assertEquals('', String.join(new List<String>(),','));
        System.assertEquals('a', String.join(new List<String>{'a'},','));
        System.assertEquals('a,b,c,d,e', String.join(new List<String>{'a','b','c','d','e'},','));
    }
}