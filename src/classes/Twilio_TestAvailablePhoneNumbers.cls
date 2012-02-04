@isTest
private class Twilio_TestAvailablePhoneNumbers {

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
		TwilioAPI api = new TwilioAPI('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
		TwilioAvailablePhoneNumberList twnumbers = api.getClient().getAccount().getAvailablePhoneNumbers();
		
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
			TwilioAPI api = new TwilioAPI('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
			TwilioAvailablePhoneNumberList twnumbers = api.getClient().getAccount().getAvailablePhoneNumbers(new map<string,string>(), 'US','TollFree');
			
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
			TwilioAPI api = new TwilioAPI('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
			TwilioAvailablePhoneNumberList twnumbers = api.getClient().getAccount().getAvailablePhoneNumbers(new map<string,string>(), 'UK','TollFree');
			
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
			TwilioAPI api = new TwilioAPI('ACba8bc05eacf94afdae398e642c9cc32d', authToken);
			TwilioAvailablePhoneNumberList twnumbers = api.getClient().getAccount().getAvailablePhoneNumbers(params, 'US','Local');
			
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
		
		TwilioAvailablePhoneNumberList twnumbers1 =new TwilioAvailablePhoneNumberList(api.getClient());
		TwilioAvailablePhoneNumberList twnumbers2 =new TwilioAvailablePhoneNumberList(api.getClient(),'US','Local');
		TwilioAvailablePhoneNumber avtwnumbers1 =new TwilioAvailablePhoneNumber(api.getClient());
    }
}