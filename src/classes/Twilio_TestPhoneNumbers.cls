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
private class Twilio_TestPhoneNumbers {

    final static String authToken = '12345678901234567890123456789012';
		
	static testmethod void testTwilioAvailablePhoneNumbers_US_Local() {
        String accountJsonResponseBody =
        	'{'
			+'"uri": "/2010-04-01/Accounts/ACde6f1e11047ebd6fe7a55f120be3a900/AvailablePhoneNumbers/US/Local.json?AreaCode=510",'
			+'"available_phone_numbers": ['
				+'{'
					+'"friendly_name": "(510) 564-7903",'
					+'"phone_number": "+15105647903",'
					+'"lata": "722",'
					+'"rate_center": "OKLD TRNID",'
					+'"latitude": "37.780000",'
					+'"longitude": "-122.380000",'
					+'"region": "CA",'
					+'"postal_code": "94703",'
					+'"iso_country": "US"'
				+'},'
				+'{'
					+'"friendly_name": "(510) 488-4379",'
					+'"phone_number": "+15104884379",'
					+'"lata": "722",'
					+'"rate_center": "OKLD FRTVL",'
					+'"latitude": "37.780000",'
					+'"longitude": "-122.380000",'
					+'"region": "CA",'
					+'"postal_code": "94602",'
					+'"iso_country": "US"'
				+'}'
			+']}';
        
        
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers/US/Local.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
		TwilioAvailablePhoneNumberList twnumbers = client.getAccount().getAvailablePhoneNumbers();
		
		// assert correct values in the fields
		System.assertNotEquals(null, twnumbers);
		
		List<TwilioAvailablePhoneNumber> phnumbersList = twnumbers.getPageData();
		
		System.assertNotEquals(null, phnumbersList);
		System.assertEquals(2, phnumbersList.size());
		
		TwilioAvailablePhoneNumber phnumber0 = phnumbersList.get(0);
		System.assertEquals('(510) 564-7903', phnumber0.getFriendlyName());
		System.assertEquals('+15105647903', phnumber0.getPhoneNumber());
		System.assertEquals('722', phnumber0.getLata());
		System.assertEquals('OKLD TRNID', phnumber0.getRateCenter());
		System.assertEquals('37.780000', phnumber0.getLatitude());
		System.assertEquals('-122.380000', phnumber0.getLongitude());
		System.assertEquals('CA', phnumber0.getRegion());
		System.assertEquals('94703', phnumber0.getPostalCode());
		System.assertEquals('US', phnumber0.getIsoCountry());
		
		TwilioAvailablePhoneNumber phnumber1 = phnumbersList.get(1);
		System.assertEquals('(510) 488-4379', phnumber1.getFriendlyName());
		System.assertEquals('+15104884379', phnumber1.getPhoneNumber());
		System.assertEquals('722', phnumber1.getLata());
		System.assertEquals('OKLD FRTVL', phnumber1.getRateCenter());
		System.assertEquals('37.780000', phnumber1.getLatitude());
		System.assertEquals('-122.380000', phnumber1.getLongitude());
		System.assertEquals('CA', phnumber1.getRegion());
		System.assertEquals('94602', phnumber1.getPostalCode());
		System.assertEquals('US', phnumber1.getIsoCountry());
		
		Exception e = null;
		try {
			phnumber1.getResourceLocation();
		} catch (Exception e1) {
			e = e1;
		}
		System.assert(e instanceof TwilioRestException);
        
        Iterator<TwilioAvailablePhoneNumber> it = twnumbers.iterator();
        System.assertEquals(true, it.hasNext());
        phnumber0 = it.next();
		System.assertEquals('(510) 564-7903', phnumber0.getFriendlyName());
		System.assertEquals('+15105647903', phnumber0.getPhoneNumber());
		System.assertEquals('722', phnumber0.getLata());
		System.assertEquals('OKLD TRNID', phnumber0.getRateCenter());
		System.assertEquals('37.780000', phnumber0.getLatitude());
		System.assertEquals('-122.380000', phnumber0.getLongitude());
		System.assertEquals('CA', phnumber0.getRegion());
		System.assertEquals('94703', phnumber0.getPostalCode());
		System.assertEquals('US', phnumber0.getIsoCountry());
		
		System.assertEquals(true, it.hasNext());
		phnumber1 = it.next();
		System.assertEquals('(510) 488-4379', phnumber1.getFriendlyName());
		System.assertEquals('+15104884379', phnumber1.getPhoneNumber());
		System.assertEquals('722', phnumber1.getLata());
		System.assertEquals('OKLD FRTVL', phnumber1.getRateCenter());
		System.assertEquals('37.780000', phnumber1.getLatitude());
		System.assertEquals('-122.380000', phnumber1.getLongitude());
		System.assertEquals('CA', phnumber1.getRegion());
		System.assertEquals('94602', phnumber1.getPostalCode());
		System.assertEquals('US', phnumber1.getIsoCountry());
		
		System.assertEquals(false, it.hasNext());
    }
    
    static testmethod void testTwilioAvailablePhoneNumbers_US_Tollfree() {
    	String accountJsonResponseBody =
        	'{"available_phone_numbers":[{"friendly_name":"(866) 231-5481","phone_number":"+18662315481","iso_country":"US"},'+
        	'{"friendly_name":"(866) 205-6833","phone_number":"+18662056833","iso_country":"US"},{"friendly_name":"(877) 349-2687",'+
        	'"phone_number":"+18773492687","iso_country":"US"},{"friendly_name":"(888) 293-0129","phone_number":"+18882930129","iso_country":"US"}],'
        	+'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/AvailablePhoneNumbers/US/TollFree.json"}';
			Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers/US/TollFree.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
			// Get an API client and request the Twilio Account
			TwilioRestClient client = new TwilioRestClient('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
			TwilioAvailablePhoneNumberList twnumbers = client.getAccount().getAvailablePhoneNumbers(new map<string,string>(), 'US','TollFree');
			
			// assert correct values in the fields
			System.assertNotEquals(null, twnumbers);
			
			List<TwilioAvailablePhoneNumber> phnumbersList = twnumbers.getPageData();
			
			System.assertNotEquals(null, phnumbersList);
			System.assertEquals(4, phnumbersList.size());			
			
			System.assertEquals('(866) 231-5481', phnumbersList[0].getFriendlyName());
			System.assertEquals('+18662315481', phnumbersList[0].getPhoneNumber());
			System.assertEquals('US', phnumbersList[0].getIsoCountry());
			
			System.assertEquals('(866) 205-6833', phnumbersList[1].getFriendlyName());
			System.assertEquals('+18662056833', phnumbersList[1].getPhoneNumber());
			System.assertEquals('US', phnumbersList[1].getIsoCountry());
			
			System.assertEquals('(877) 349-2687', phnumbersList[2].getFriendlyName());
			System.assertEquals('+18773492687', phnumbersList[2].getPhoneNumber());
			System.assertEquals('US', phnumbersList[2].getIsoCountry());
			
			System.assertEquals('(888) 293-0129', phnumbersList[3].getFriendlyName());
			System.assertEquals('+18882930129', phnumbersList[3].getPhoneNumber());
			System.assertEquals('US', phnumbersList[3].getIsoCountry());
			
			
			Iterator<TwilioAvailablePhoneNumber> it = twnumbers.iterator();
	        System.assertEquals(true, it.hasNext());
	        TwilioAvailablePhoneNumber phnumber0 = it.next();
	        
	        System.assertEquals('(866) 231-5481', phnumber0 .getFriendlyName());
			System.assertEquals('+18662315481', phnumber0 .getPhoneNumber());
			System.assertEquals('US', phnumber0 .getIsoCountry());
			System.assertEquals(true, it.hasNext());
			phnumber0 = it.next();
			
			System.assertEquals('(866) 205-6833', phnumber0.getFriendlyName());
			System.assertEquals('+18662056833', phnumber0.getPhoneNumber());
			System.assertEquals('US', phnumber0.getIsoCountry());
			System.assertEquals(true, it.hasNext());
			phnumber0 = it.next();
			
			System.assertEquals('(877) 349-2687', phnumber0.getFriendlyName());
			System.assertEquals('+18773492687', phnumber0.getPhoneNumber());
			System.assertEquals('US', phnumber0.getIsoCountry());
			System.assertEquals(true, it.hasNext());
			phnumber0 = it.next();
			
			System.assertEquals('(888) 293-0129', phnumber0.getFriendlyName());
			System.assertEquals('+18882930129', phnumber0.getPhoneNumber());
			System.assertEquals('US', phnumber0.getIsoCountry());
	        System.assertEquals(false, it.hasNext());
			
			
    }
    
    static testmethod void testTwilioAvailablePhoneNumbers_UK() {
    	String accountJsonResponseBody =
        	'{"available_phone_numbers":[{"friendly_name":"(866) 231-5481","phone_number":"+448662315481","iso_country":"UK"},'+
        	'{"friendly_name":"(866) 205-6833","phone_number":"+448662056833","iso_country":"UK"},{"friendly_name":"(877) 349-2687",'+
        	'"phone_number":"+448773492687","iso_country":"UK"},{"friendly_name":"(888) 293-0129","phone_number":"+448882930129","iso_country":"UK"}],'
        	+'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/AvailablePhoneNumbers/US/TollFree.json"}';
			Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers/UK/TollFree.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
			// Get an API client and request the Twilio Account
			TwilioRestClient client = new TwilioRestClient('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
			TwilioAvailablePhoneNumberList twnumbers = client.getAccount().getAvailablePhoneNumbers(new map<string,string>(), 'UK','TollFree');
			
			// assert correct values in the fields
			System.assertNotEquals(null, twnumbers);
			
			List<TwilioAvailablePhoneNumber> phnumbersList = twnumbers.getPageData();
			
			System.assertNotEquals(null, phnumbersList);
			System.assertEquals(4, phnumbersList.size());			
			
			System.assertEquals('(866) 231-5481', phnumbersList[0].getFriendlyName());
			System.assertEquals('+448662315481', phnumbersList[0].getPhoneNumber());
			System.assertEquals('UK', phnumbersList[0].getIsoCountry());
			
			System.assertEquals('(866) 205-6833', phnumbersList[1].getFriendlyName());
			System.assertEquals('+448662056833', phnumbersList[1].getPhoneNumber());
			System.assertEquals('UK', phnumbersList[1].getIsoCountry());
			
			System.assertEquals('(877) 349-2687', phnumbersList[2].getFriendlyName());
			System.assertEquals('+448773492687', phnumbersList[2].getPhoneNumber());
			System.assertEquals('UK', phnumbersList[2].getIsoCountry());
			
			System.assertEquals('(888) 293-0129', phnumbersList[3].getFriendlyName());
			System.assertEquals('+448882930129', phnumbersList[3].getPhoneNumber());
			System.assertEquals('UK', phnumbersList[3].getIsoCountry());
    }
    
    static testmethod void testTwilioAvailablePhoneNumbers_AreaCodeFilter() {
    	String accountJsonResponseBody =
        	'{"available_phone_numbers":[{"friendly_name":"(510) 342-3750","phone_number":"+15103423750","latitude":"37.660000",'
        	+'"longitude":"-122.070000","region":"CA","postal_code":"94578","iso_country":"US","lata":"722","rate_center":"HAYWARD"},'
        	+'{"friendly_name":"(510) 343-6640","phone_number":"+15103436640","latitude":"37.810000",'
        	+'"longitude":"-122.260000","region":"CA","postal_code":"94617","iso_country":"US","lata":"722","rate_center":"OKLD TRNID"}],'
        	+'"uri":"/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers/US/Local.json?AreaCode=510&Contains=51034*****"}';
			Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/ACba8bc05eacf94afdae398e642c9cc32d/AvailablePhoneNumbers/US/Local.json?AreaCode=510&Contains=51034*****',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
			map<string,string> params=new map<string,string>();
			params.put('Contains','51034*****');
			params.put('AreaCode','510');

			// Get an API client and request the Twilio Account
			TwilioRestClient client = new TwilioRestClient('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
			TwilioAvailablePhoneNumberList twnumbers = client.getAccount().getAvailablePhoneNumbers(params, 'US','Local');
			
			// assert correct values in the fields
			System.assertNotEquals(null, twnumbers);
			
			List<TwilioAvailablePhoneNumber> phnumbersList = twnumbers.getPageData();
		
		System.assertNotEquals(null, phnumbersList);
		System.assertEquals(2, phnumbersList.size());		
		TwilioAvailablePhoneNumber phnumber0 = phnumbersList.get(0);
		System.assertEquals('(510) 342-3750', phnumber0.getFriendlyName());
		System.assertEquals('+15103423750', phnumber0.getPhoneNumber());
		System.assertEquals('722', phnumber0.getLata());
		System.assertEquals('HAYWARD', phnumber0.getRateCenter());
		System.assertEquals('37.660000', phnumber0.getLatitude());
		System.assertEquals('-122.070000', phnumber0.getLongitude());
		System.assertEquals('CA', phnumber0.getRegion());
		System.assertEquals('94578', phnumber0.getPostalCode());
		System.assertEquals('US', phnumber0.getIsoCountry());
		
		TwilioAvailablePhoneNumber phnumber1 = phnumbersList.get(1);
		System.assertEquals('(510) 343-6640', phnumber1.getFriendlyName());
		System.assertEquals('+15103436640', phnumber1.getPhoneNumber());
		System.assertEquals('722', phnumber1.getLata());
		System.assertEquals('OKLD TRNID', phnumber1.getRateCenter());
		System.assertEquals('37.810000', phnumber1.getLatitude());
		System.assertEquals('-122.260000', phnumber1.getLongitude());
		System.assertEquals('CA', phnumber1.getRegion());
		System.assertEquals('94617', phnumber1.getPostalCode());
		System.assertEquals('US', phnumber1.getIsoCountry());
		
		TwilioAvailablePhoneNumberList twnumbers1 =new TwilioAvailablePhoneNumberList(client);
		TwilioAvailablePhoneNumberList twnumbers2 =new TwilioAvailablePhoneNumberList(client,'US','Local');
		TwilioAvailablePhoneNumber avtwnumbers1 =new TwilioAvailablePhoneNumber(client);
    }
    
    static testmethod void testTwilioIncomingPhoneNumbersList_get()
	{
		String accountJsonResponseBody ='{"page": 0,"num_pages": 1,"page_size": 50,"total": 6,"start": 0,"end": 5,'+
		'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json",'+
		'"first_page_uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json?Page=0&PageSize=50",'+
		'"previous_page_uri": null,"next_page_uri": null,"last_page_uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json?Page=0&PageSize=50",'+
		'"incoming_phone_numbers": [{"sid": "PN3f94c94562ac88dccf16f8859a1a8b25","account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3","friendly_name": "Long Play",'+
		'"phone_number": "+14152374451","voice_url": "http://demo.twilio.com/long","voice_method": "GET","voice_fallback_url": null,"voice_fallback_method": null,'+
		'"voice_caller_id_lookup": null,"voice_application_sid": null,"date_created": "Thu, 13 Nov 2008 07:56:24 +0000","date_updated": "Thu, 13 Nov 2008 08:45:58 +0000",'+
		'"sms_url": null,"sms_method": null,"sms_fallback_url": null,"sms_fallback_method": null,"sms_application_sid": "AP9b2e38d8c592488c397fc871a82a74ec",'+
		'"capabilities": {"voice": true,"sms": false},"status_callback": null,"status_callback_method": null,"api_version": "2010-04-01",'+
		'"uri": "/2010-04-01/Accounts/ACdc5f1e11047ebd6fe7a55f120be3a900/IncomingPhoneNumbers/PN3f94c94562ac88dccf16f8859a1a8b25.json"}]}';
		
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		 
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioIncomingPhoneNumberList twinnums=client.getAccount().getIncomingPhoneNumbers();
		
		System.assertNotEquals(null, twinnums);
		
		List<TwilioIncomingPhoneNumber> twinnumsList = twinnums.getPageData();
		
		System.assertNotEquals(null, twinnumsList);
		System.assertEquals(1, twinnumsList.size());
		System.assertEquals('PN3f94c94562ac88dccf16f8859a1a8b25', twinnumsList[0].getSid());
		System.assertEquals(Datetime.newInstanceGmt(2008,11,13,07,56,24),twinnumsList[0].getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2008,11,13,08,45,58),twinnumsList[0].getDateUpdated());
		System.assertEquals('Long Play',twinnumsList[0].getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twinnumsList[0].getAccountSid());				
		System.assertEquals('+14152374451',twinnumsList[0].getPhoneNumber());
		System.assertEquals(null,twinnumsList[0].getVoiceApplicationSid());
		System.assertEquals('AP9b2e38d8c592488c397fc871a82a74ec',twinnumsList[0].getSmsApplicationSid());
		System.assertEquals('2010-04-01',twinnumsList[0].getApiVersion());
		System.assertEquals('http://demo.twilio.com/long',twinnumsList[0].getVoiceUrl());
		System.assertEquals('GET',twinnumsList[0].getVoiceMethod());
		System.assertEquals(null,twinnumsList[0].getVoiceFallbackurl());
		System.assertEquals(null,twinnumsList[0].getVoiceFallbackMethod());
		System.assertEquals(null,twinnumsList[0].getStatusCallback());
		System.assertEquals(null,twinnumsList[0].getStatusCallbackMethod()); 
		System.assertEquals(null,twinnumsList[0].getVoiceCallerIdLookup());
		System.assertEquals(null,twinnumsList[0].getSmsUrl());
		System.assertEquals(null,twinnumsList[0].getSmsMethod());
		System.assertEquals(null,twinnumsList[0].getSmsFallbackUrl());
		System.assertEquals(null,twinnumsList[0].getSmsFallbackMethod());		
		System.assertEquals(null,twinnumsList[0].getSmsStatusCallback());
		
		System.assertEquals(true,Boolean.valueof(twinnumsList[0].getcapabilities().get('voice')));
		System.assertEquals(false,Boolean.valueof(twinnumsList[0].getcapabilities().get('sms')));
		
		Iterator<TwilioIncomingPhoneNumber> it = twinnums.iterator();
        System.assertEquals(true, it.hasNext());
		
		TwilioIncomingPhoneNumber twinnum=it.next();
		System.assertEquals(false, it.hasNext());
		
	}
	
	static testmethod void testTwilioIncomingPhoneNumbers_create()
	{
		String accountJsonResponseBody ='{"sid": "PN2a0747eba6abf96b7e3c3ff0b4530f6e","account_sid": "ACdc5f1e11047ebd6fe7a55f120be3a900","friendly_name": "My Company Line",'+
'"phone_number": "+15105647903","voice_url": "http://mycompany.com/handleNewCall.php","voice_method": "POST","voice_fallback_url": null,"voice_fallback_method": "POST",'+
'"voice_caller_id_lookup": null,"voice_application_sid": null,"date_created": "Mon, 16 Aug 2010 23:31:47 +0000","date_updated": "Mon, 16 Aug 2010 23:31:47 +0000",'+
'"sms_url": null,"sms_method": "POST","sms_fallback_url": null,"sms_fallback_method": "GET","sms_application_sid": null,"capabilities": {"voice": null,"sms": null},'+
'"status_callback": null,"status_callback_method": null,"api_version": "2010-04-01","uri": "/2010-04-01/Accounts/ACdc5f1e11047ebd6fe7a55f120be3a900/IncomingPhoneNumbers/PN2a0747eba6abf96b7e3c3ff0b4530f6e.json"}';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/IncomingPhoneNumbers.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		
		map<string,string> p=new map<string,string>();
		p.put('PhoneNumber','+15105647903');
		p.put('FriendlyName','My Company Line');
		p.put('VoiceUrl','http://mycompany.com/handleNewCall.php');
		p.put('VoiceMethod','GET');
		
				
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		
		TwilioIncomingPhoneNumber twinnums= client.getAccount().getIncomingPhoneNumbers().create(p);
		
		System.assertEquals('PN2a0747eba6abf96b7e3c3ff0b4530f6e', twinnums.getSid());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,16,23,31,47),twinnums.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,16,23,31,47),twinnums.getDateUpdated());
		System.assertEquals('My Company Line',twinnums.getFriendlyName());
		System.assertEquals('ACdc5f1e11047ebd6fe7a55f120be3a900',twinnums.getAccountSid());				
		System.assertEquals('+15105647903',twinnums.getPhoneNumber());
		System.assertEquals(null,twinnums.getVoiceApplicationSid());
		System.assertEquals(null,twinnums.getSmsApplicationSid());
		System.assertEquals('2010-04-01',twinnums.getApiVersion());
		System.assertEquals('http://mycompany.com/handleNewCall.php',twinnums.getVoiceUrl());
		System.assertEquals('POST',twinnums.getVoiceMethod());
		System.assertEquals(null,twinnums.getVoiceFallbackurl());
		System.assertEquals('POST',twinnums.getVoiceFallbackMethod());
		System.assertEquals(null,twinnums.getStatusCallback());
		System.assertEquals(null,twinnums.getStatusCallbackMethod()); 
		System.assertEquals(null,twinnums.getVoiceCallerIdLookup());
		System.assertEquals(null,twinnums.getSmsUrl());
		System.assertEquals('POST',twinnums.getSmsMethod());
		System.assertEquals(null,twinnums.getSmsFallbackUrl());
		System.assertEquals('GET',twinnums.getSmsFallbackMethod());		
		System.assertEquals(null,twinnums.getSmsStatusCallback());
		
	}
	static testmethod void testTwilioIncomingPhoneNumber_get()
	{
		String accountJsonResponseBody ='{"sid": "PN2a0747eba6abf96b7e3c3ff0b4530f6e","account_sid": "ACdc5f1e11047ebd6fe7a55f120be3a900","friendly_name": "My Company Line",'+
		'"phone_number": "+15105647903","voice_url": "http://mycompany.com/handleNewCall.php","voice_method": "POST","voice_fallback_url": null,"voice_fallback_method": "POST",'+
		'"voice_caller_id_lookup": null,"voice_application_sid": null,"date_created": "Mon, 16 Aug 2010 23:31:47 +0000","date_updated": "Mon, 16 Aug 2010 23:31:47 +0000",'+
		'"sms_url": null,"sms_method": "POST","sms_fallback_url": null,"sms_fallback_method": "GET","sms_application_sid": null,"capabilities": {"voice": null,"sms": null},'+
		'"status_callback": null,"status_callback_method": null,"api_version": "2010-04-01","uri": "/2010-04-01/Accounts/ACdc5f1e11047ebd6fe7a55f120be3a900/IncomingPhoneNumbers/PN2a0747eba6abf96b7e3c3ff0b4530f6e.json"}';
        	
        Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/IncomingPhoneNumbers/PN3f94c94562ac88dccf16f8859a1a8b25.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
		);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3', authToken);
		
		TwilioIncomingPhoneNumber twinnums=client.getAccount().getIncomingPhoneNumber('PN3f94c94562ac88dccf16f8859a1a8b25');
		
		System.assertEquals('PN3f94c94562ac88dccf16f8859a1a8b25', twinnums.getSid());
		System.assertEquals('My Company Line',twinnums.getFriendlyName());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,16,23,31,47),twinnums.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2010,08,16,23,31,47),twinnums.getDateUpdated());
		
		System.assertEquals('ACdc5f1e11047ebd6fe7a55f120be3a900',twinnums.getAccountSid());				
		System.assertEquals('+15105647903',twinnums.getPhoneNumber());
		System.assertEquals(null,twinnums.getVoiceApplicationSid());
		System.assertEquals(null,twinnums.getSmsApplicationSid());
		System.assertEquals('2010-04-01',twinnums.getApiVersion());
		System.assertEquals('http://mycompany.com/handleNewCall.php',twinnums.getVoiceUrl());
		System.assertEquals('POST',twinnums.getVoiceMethod());
		System.assertEquals(null,twinnums.getVoiceFallbackurl());
		System.assertEquals('POST',twinnums.getVoiceFallbackMethod());
		System.assertEquals(null,twinnums.getStatusCallback());
		System.assertEquals(null,twinnums.getStatusCallbackMethod()); 
		System.assertEquals(null,twinnums.getVoiceCallerIdLookup());
		System.assertEquals(null,twinnums.getSmsUrl());
		System.assertEquals('POST',twinnums.getSmsMethod());
		System.assertEquals(null,twinnums.getSmsFallbackUrl());
		System.assertEquals('GET',twinnums.getSmsFallbackMethod());		
		System.assertEquals(null,twinnums.getSmsStatusCallback());
	}
	
	static testmethod void testTwilioIncomingPhoneNumber_delete()
	{
		String accountJsonResponseBody ='';
		Twilio_TestHTTPMock.getInstance().putResponse(
			'DELETE',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/IncomingPhoneNumbers/PN3f94c94562ac88dccf16f8859a1a8b25.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
		);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3', authToken);
		
		boolean isdel=client.getAccount().getIncomingPhoneNumber('PN3f94c94562ac88dccf16f8859a1a8b25').deleteIncomingPhoneNumber();
		system.assert(true,isdel); 
		TwilioIncomingPhoneNumber twip=new TwilioIncomingPhoneNumber(client);
		TwilioIncomingPhoneNumberlist twipl=new TwilioIncomingPhoneNumberList(client);
	}
	
	static testmethod void testOutgoingCallerIDList_get()
	{
		String accountJsonResponseBody ='{"outgoing_caller_ids":[{"sid":"PN17c8630939e44e7e92a45c51bcdb7122",'
		+'"account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3","friendly_name":"919902400323","phone_number":"+919902400323",'+
		'"date_created":"Thu, 29 Dec 2011 12:22:55 +0000","date_updated":"Thu, 29 Dec 2011 12:22:55 +0000",'+
		'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds/PN17c8630939e44e7e92a45c51bcdb7122.json"}],'+
		'"page":0,"num_pages":1,"page_size":50,"total":1,"start":0,"end":0,"uri":'+
		'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json","first_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds'+
		'.json?Page=0&PageSize=50","previous_page_uri":null,"next_page_uri":null,"last_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json?Page=0&PageSize=50"}';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioOutgoingCallerIdList twoutcallid=client.getAccount().getOutgoingCallerIds();
		System.assertNotEquals(null, twoutcallid);
		
		List<TwilioOutgoingCallerId> twocallidList = twoutcallid.getPageData();
		
		System.assertNotEquals(null, twocallidList);
		System.assertEquals(1, twocallidList.size());
		System.assertEquals('PN17c8630939e44e7e92a45c51bcdb7122', twocallidList[0].getSid());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twocallidList[0].getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twocallidList[0].getDateUpdated());
		System.assertEquals('919902400323',twocallidList[0].getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twocallidList[0].getAccountSid());
		System.assertEquals('+919902400323',twocallidList[0].getPhoneNumber());
		
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json?PhoneNumber=%2B919902400323',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		map<string,string> params=new map<String,string>();
		params.put('PhoneNumber','+919902400323');
		twoutcallid=client.getAccount().getOutgoingCallerIds(params);		
		Iterator<TwilioOutgoingCallerId> it = twoutcallid.iterator();
        System.assertEquals(true, it.hasNext());	
		TwilioOutgoingCallerId twocallid=it.next();
		
		System.assertEquals('PN17c8630939e44e7e92a45c51bcdb7122', twocallid.getSid());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twocallid.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twocallid.getDateUpdated());
		System.assertEquals('919902400323',twocallid.getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twocallid.getAccountSid());
		System.assertEquals('+919902400323',twocallid.getPhoneNumber());
		System.assertEquals(false, it.hasNext());
	}
	
	static testmethod void testOutgoingCallerID_create()
	{
		String accountJsonResponseBody ='{"account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3","phone_number":"+918722266012",'+
		'"friendly_name":"harsha","validation_code":844863}';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'POST',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		
		map<string,string> p=new map<string,string>();
		p.put('PhoneNumber','+9187222660');
		p.put('FriendlyName','harsha');
				
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioCallerIdValidation twoutcallid = client.getAccount().getOutgoingCallerIds().create(p);
		
		System.assertEquals('harsha',twoutcallid.getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twoutcallid.getAccountSid());
		System.assertEquals('+918722266012',twoutcallid.getPhoneNumber());
		System.assertEquals('844863',twoutcallid.getValidationCode());
		
	}
	static testmethod void testOutgoingCallerID_get()
	{
		String accountJsonResponseBody ='{"sid":"PN17c8630939e44e7e92a45c51bcdb7122","account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3",'
		+'"friendly_name":"919902400323","phone_number":"+919902400323","date_created":"Thu, 29 Dec 2011 12:22:55 +0000","date_updated":'+
		'"Thu, 29 Dec 2011 12:22:55 +0000","uri":'+
		'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds/PN17c8630939e44e7e92a45c51bcdb7122.json"}';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'GET',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds/PN17c8630939e44e7e92a45c51bcdb7122.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		TwilioOutgoingCallerId twoutcallid=client.getAccount().getOutgoingCallerId('PN17c8630939e44e7e92a45c51bcdb7122');
		
		System.assertEquals('PN17c8630939e44e7e92a45c51bcdb7122', twoutcallid.getSid());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twoutcallid.getDateCreated());
		System.assertEquals(Datetime.newInstanceGmt(2011,12,29,12,22,55),twoutcallid.getDateUpdated());
		System.assertEquals('919902400323',twoutcallid.getFriendlyName());
		System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3',twoutcallid.getAccountSid());
		System.assertEquals('+919902400323',twoutcallid.getPhoneNumber());
		
		TwilioOutgoingCallerId  tci=new TwilioOutgoingCallerId(client); 
	}
	
	static testmethod void testOutgoingCallerID_delete()
	{
		String accountJsonResponseBody ='';
        	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
			'DELETE',
			'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/OutgoingCallerIds/PN17c8630939e44e7e92a45c51bcdb7122.json',
			new Twilio_TestHTTPMock.Response(accountJsonResponseBody,204)
			);
		
		// Get an API client and request the Twilio Account
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		boolean isdel=client.getAccount().getOutgoingCallerId('PN17c8630939e44e7e92a45c51bcdb7122').deleteOutgoingCallerid();
		
		system.assertEquals(true,isdel); 
	}
}