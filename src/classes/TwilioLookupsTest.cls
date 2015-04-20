@isTest
private class TwilioLookupsTest {
    final static String authToken = '12345678901234567890123456789012';
    private static TwilioLookupsRestClient client = new TwilioLookupsRestClient('AC00000000000000000000000000000000', authToken);
    private static String rootURL = 'https://lookups.twilio.com/v1/PhoneNumbers';
  	private static String resourceLocation_PhoneNumber_Carrier =  rootURL + '/+17185551212?Type=carrier&CountryCode=US'; 

  	static {
		// --- Lookup Test Response
 		String jsonResponse_PhoneNumber_Carrier = '{"country_code": "US", "phone_number": "+17185551212", "national_format": "(718) 555-1212", "carrier": {"mobile_country_code": "310", "mobile_network_code": "012", "name": "Verizon Wireless", "type": "mobile", "error_code": null}, "url": "https://lookups.twilio.com/v1/PhoneNumbers/+17185551212?Type=carrier"}';
      	loadMockResponse(resourceLocation_PhoneNumber_Carrier, jsonResponse_PhoneNumber_Carrier);
 	}

    static void loadMockResponse(String resourceLocation, String jsonResponse) {
    	Twilio_TestHTTPMock.getInstance().putResponse('GET',resourceLocation,new Twilio_TestHTTPMock.Response(jsonResponse,200));
    }

   static testMethod void testTwilioLookupsPhoneNumber() {
   		TwilioLookupsRestClient cli = TwilioAPI.getDefaultLookupsClient();
   		
		TwilioLookupsPhoneNumber phoneNumber =  client.getPhoneNumber('+17185551212', 'US', true);
        
     	system.assertEquals('US', phoneNumber.getCountryCode());
     	system.assertEquals('+17185551212', phoneNumber.getPhoneNumber());
     	system.assertEquals('(718) 555-1212', phoneNumber.getFormattedNumber());
     	system.assertEquals('310', phoneNumber.getMobileCountryCode());
     	system.assertEquals('012', phoneNumber.getMobileNetworkCode());
     	system.assertEquals('Verizon Wireless', phoneNumber.getCarrierName());
     	system.assertEquals(TwilioLookupsPhoneNumber.PhoneType.MOBILE, phoneNumber.getPhoneType());
     	system.assertEquals('https://lookups.twilio.com/v1/PhoneNumbers/+17185551212?Type=carrier', phoneNumber.getUrl());
 	}
}