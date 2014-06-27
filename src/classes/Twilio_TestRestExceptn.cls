@isTest
private class Twilio_TestRestExceptn {
    
    @isTest
    static void test() {
        TwilioRestException tre1 = new TwilioRestException('message',1);
        System.assertEquals('message', tre1.message);
        System.assertEquals(1, tre1.errorCode);
        System.assertEquals(null, tre1.moreInfo);
        System.assertEquals(null, tre1.status);
        
        TwilioRestException tre2 = new TwilioRestException('message',1,'moreInfo');
        System.assertEquals('message', tre2.message);
        System.assertEquals(1, tre2.errorCode);
        System.assertEquals('moreInfo', tre2.moreInfo);
        System.assertEquals(null, tre2.status);
        
        TwilioRestResponse response = new TwilioRestResponse('{"status": 404, "message": "The requested resource was not found"}',404);
        response.setContentType('application/json');
        TwilioRestException tre3 = new TwilioRestException(response);
        System.assertEquals('The requested resource was not found', tre3.message);
        System.assertEquals(null, tre3.errorCode);
        System.assertEquals(null, tre3.moreInfo);
        System.assertEquals(404, tre3.status);
        
        response = new TwilioRestResponse('{"status": 400, "message": "No to number is specified", "code": 21201, "more_info": "http://www.twilio.com/docs/errors/21201"}',400);
        response.setContentType('application/json');
        TwilioRestException tre4 = new TwilioRestException(response);
        System.assertEquals('No to number is specified', tre4.message);
        System.assertEquals(21201, tre4.errorCode);
        System.assertEquals('http://www.twilio.com/docs/errors/21201', tre4.moreInfo);
        System.assertEquals(400, tre4.status);
    }
    
}