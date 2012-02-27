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
public class Twilio_TestTwiML {

	static testmethod void testResponse()
	{
		TwilioTwiML.Response twiml = new TwilioTwiML.Response();
		System.assertEquals('<Response/>', twiml.toXML());
		System.assertEquals('%3CResponse%2F%3E', twiml.asURL());
	}
	
	static testmethod void testResponseNested()
	{
		// TODO - Gather, Record, Dial, Say, Play, Redirect, Hangup, Sms
	}
	
	/* test additional utility methods in Verb */
	static testmethod void testVerb()
	{
		TwilioTwiML.Conference conference = new TwilioTwiML.Conference('My Conference');
		System.assertEquals('My Conference', conference.getBody());
		
		conference.setBeep(true);
		conference.setEndConferenceOnExit(false);
		conference.setWaitMethod('GET');
		conference.setWaitUrl('http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical');
				
		System.assertEquals(4, conference.getAttributes().size());
		System.assertEquals(true, conference.getAttributes().containsKey('beep'));
		System.assertEquals(true, conference.getAttributes().containsKey('endConferenceOnExit'));
		System.assertEquals(true, conference.getAttributes().containsKey('waitMethod'));
		System.assertEquals(true, conference.getAttributes().containsKey('waitUrl'));
		System.assertEquals(false, conference.getAttributes().containsKey('muted'));
		System.assertEquals('GET', conference.getAttributes().get('waitMethod'));
		System.assertEquals('true', conference.getAttributes().get('beep'));
				
		TwilioTwiML.Dial dial = new TwilioTwiML.Dial();
		dial.append(conference);
		
		System.assertEquals(1, dial.getChildren().size());
		System.assertEquals(conference, dial.getChildren().get(0));
		
	}
	
	static testmethod void testConference()
	{
		TwilioTwiML.Conference twiml = new TwilioTwiML.Conference('My Conference');
		
		System.assertEquals('<Conference>My Conference</Conference>', twiml.toXML());
		System.assertEquals('My Conference', twiml.getBody());
		
		twiml.setBeep(true);
		twiml.setEndConferenceOnExit(true);
		twiml.setMuted(false);
		twiml.setStartConferenceOnEnter(false);
		twiml.setWaitMethod('GET');
		twiml.setWaitUrl('http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical');
		
		System.assertEquals('<Conference beep="true" endConferenceOnExit="true" muted="false" startConferenceOnEnter="false" waitMethod="GET" waitUrl="http://twimlets.com/holdmusic?Bucket=com.twilio.music.classical">My Conference</Conference>',
				twiml.toXML());
	}
	
	static testmethod void testDial()
	{
		TwilioTwiML.Dial twiml = new TwilioTwiML.Dial();
		System.assertEquals('<Dial/>', twiml.toXML());
		
		twiml = new TwilioTwiML.Dial('415-555-1212');
		System.assertEquals('<Dial>415-555-1212</Dial>', twiml.toXML());
		
		twiml.setAction('https://www.twilio.com/');
		twiml.setCallerId('415-555-7890');
		twiml.setHangupOnStar(true);
		twiml.setMethod('POST');
		twiml.setTimeLimit(3600);
		twiml.setTimeout(30);
		
		System.assertEquals('<Dial action="https://www.twilio.com/" callerId="415-555-7890" hangupOnStar="true" method="POST" timeLimit="3600" timeout="30">415-555-1212</Dial>',
				twiml.toXML());
	}
	
	static testmethod void testDialNested()
	{
		TwilioTwiML.Dial dial;
		Exception e = null;
		
		dial = new TwilioTwiML.Dial();
		dial.append(new TwilioTwiML.PhoneNumber('415-555-1212'));
		System.assertEquals('<Dial><Number>415-555-1212</Number></Dial>', dial.toXML());
		
		dial = new TwilioTwiML.Dial();
		dial.append(new TwilioTwiML.Conference('My Conference'));
		System.assertEquals('<Dial><Conference>My Conference</Conference></Dial>', dial.toXML());
		
		dial = new TwilioTwiML.Dial();
		dial.append(new TwilioTwiML.Client('jenny'));
		System.assertEquals('<Dial><Client>jenny</Client></Dial>', dial.toXML());
		
		dial = new TwilioTwiML.Dial();
		try {
			dial.append(new TwilioTwiML.Say('hello'));
		} catch (Exception ex) {
			e = ex;
		}
		System.assert(e instanceof TwilioTwiML.TwiMLException);
	}
	
	static testmethod void testGather()
	{
		TwilioTwiML.Gather twiml = new TwilioTwiML.Gather();
		System.assertEquals('<Gather/>', twiml.toXML());
		
		twiml.setAction('https://www.twilio.com/');
		twiml.setFinishOnKey('#');
		twiml.setMethod('GET');
		twiml.setNumDigits(10);
		twiml.setTimeout(30);
		System.assertEquals('<Gather action="https://www.twilio.com/" finishOnKey="#" method="GET" numDigits="10" timeout="30"/>', twiml.toXML());
	}
	
	static testmethod void testGatherNested()
	{
		// TODO - Say, Play, Pause
	}
	
	static testmethod void testHangup()
	{
		TwilioTwiML.Hangup twiml = new TwilioTwiML.Hangup();
		System.assertEquals('<Hangup/>', twiml.toXML());
	}
	
	static testmethod void testNumber()
	{
		TwilioTwiML.PhoneNumber twiml = new TwilioTwiML.PhoneNumber('415-555-1234');
		System.assertEquals('<Number>415-555-1234</Number>', twiml.toXML());
		
		twiml.setSendDigits('wwww1928');
		twiml.setUrl('https://www.twilio.com');
		System.assertEquals('<Number sendDigits="wwww1928" url="https://www.twilio.com">415-555-1234</Number>', twiml.toXML());
	}
	
	static testmethod void testPause()
	{
		TwilioTwiML.Pause twiml = new TwilioTwiML.Pause();
		System.assertEquals('<Pause/>', twiml.toXML());
		
		twiml.setLength(30);
		System.assertEquals('<Pause length="30"/>', twiml.toXML());
	}
	
	static testmethod void testPlay()
	{
		TwilioTwiML.Play twiml = new TwilioTwiML.Play('https://api.twilio.com/cowbell.mp3');
		System.assertEquals('<Play>https://api.twilio.com/cowbell.mp3</Play>', twiml.toXML());
		
		twiml.setLoop(5);
		System.assertEquals('<Play loop="5">https://api.twilio.com/cowbell.mp3</Play>', twiml.toXML());
	}
	
	static testmethod void testRecord()
	{
		TwilioTwiML.Record twiml = new TwilioTwiML.Record();
		System.assertEquals('<Record/>', twiml.toXML());
		
		twiml.setAction('https://www.twilio.com');
		twiml.setFinishOnKey('#');
		twiml.setMaxLength(3600);
		twiml.setMethod('GET');
		twiml.setTimeout(60);
		twiml.setTranscribe(true);
		twiml.setTranscribeCallback('https://www.twilio.com');
		System.assertEquals('<Record action="https://www.twilio.com" finishOnKey="#" maxLength="3600" method="GET" timeout="60" transcribe="true" transcribeCallback="https://www.twilio.com"/>',
				twiml.toXML());
	}
	
	static testmethod void testRedirect()
	{
		TwilioTwiML.Redirect twiml = new TwilioTwiML.Redirect('https://www.twilio.com');
		System.assertEquals('<Redirect>https://www.twilio.com</Redirect>', twiml.toXML());
		
		twiml.setMethod('POST');
		System.assertEquals('<Redirect method="POST">https://www.twilio.com</Redirect>', twiml.toXML());
	}
	
	static testmethod void testReject()
	{
		TwilioTwiML.Reject twiml = new TwilioTwiML.Reject();
		System.assertEquals('<Reject/>', twiml.toXML());
		
		twiml.setReason('BUSY');
		System.assertEquals('<Reject reason="BUSY"/>', twiml.toXML());
	}
	
	static testmethod void testSay()
	{
		TwilioTwiML.Say twiml = new TwilioTwiML.Say('Hello world');
		System.assertEquals('<Say>Hello world</Say>', twiml.toXML());
		
		twiml.setLanguage('en-gb');
		twiml.setLoop(3);
		twiml.setVoice('woman');
		System.assertEquals('<Say language="en-gb" loop="3" voice="woman">Hello world</Say>', twiml.toXML());
	}
	
	static testmethod void testSms()
	{
		TwilioTwiML.Sms twiml = new TwilioTwiML.Sms('Hello world');
		System.assertEquals('<Sms>Hello world</Sms>', twiml.toXML());
		
		twiml.setAction('https://www.twilio.com');
		twiml.setFrom('415-555-9999');
		twiml.setMethod('POST');
		twiml.setStatusCallback('https://www.twilio.com');
		twiml.setTo('415-555-1212');
		System.assertEquals('<Sms action="https://www.twilio.com" from="415-555-9999" method="POST" statusCallback="https://www.twilio.com" to="415-555-1212">Hello world</Sms>', twiml.toXML());		
	}
}