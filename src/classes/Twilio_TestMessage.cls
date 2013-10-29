@isTest
private class Twilio_TestMessage 
{

    final static String authToken = '12345678901234567890123456789012';

    static testmethod void testTwilioMessage_send() 
    {
        string accountJsonResponseBody='{'
        +'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
        +'"api_version": "2010-04-01",'
        +'"body": "Test sending MMS from twilio",'
        +'"num_segments": "1",'
        +'"num_media": "1",'
        +'"date_created": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"date_sent": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"date_updated": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"direction": "outbound-api",'
        +'"from": "+14158141829",'
        +'"price": "null",'
        +'"price_unit":"usd",'
        +'"sid": "MM90c6fc909d8504d45ecdb3a3d5b3556e",'
        +'"status": "queued",'
        +'"to": "+14159978453",'
        +'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/MM90c6fc909d8504d45ecdb3a3d5b3556e.json",'
        +'"subresource_uris": '
        +'{"media":"/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Messages/MMbd2135c6d10f417faf1e03fac4e8397b/Media.json"}'
        +'}';
        
        Twilio_TestHTTPMock.getInstance().putResponse('POST',
            'https://api.twilio.com/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Messages.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200));
        
        
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('ACadfb5891c0e4f8c6c34be620a8ec1ef3', authToken);
        Map<String,String> properties = new Map<String,String> {
            'To'   => '+14506007431',
            'From' => '+14509000405',
            'Body' => 'Test sending MMS from twilio'
            };
        TwilioMessage sms = client.getAccount().getMessages().create(properties);
        sms.getMedia();
        sms.getMedia('MM90c6fc909d8504d45ecdb3a3d5b3556e');
        sms.getResourceLocation();
        
        System.assertEquals('MM90c6fc909d8504d45ecdb3a3d5b3556e', sms.getsid());
        System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', sms.getaccountsid());
        System.assertEquals('+14159978453',sms.getto());
        System.assertEquals('+14158141829',sms.getfrom());
        System.assertEquals('Test sending MMS from twilio',sms.getbody());
        System.assertEquals('1',sms.getnumSegments());
        System.assertEquals('1',sms.getnumMedia());
        System.assertEquals('queued',sms.getStatus());
        System.assertEquals('null',sms.getPrice());
        System.assertEquals('usd',sms.getPriceUnit());
        System.assertEquals('outbound-api',sms.getDirection());
        System.assertEquals('2010-04-01',sms.getApiVersion());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),sms.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),sms.getDateUpdated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),sms.getDatesent());
    }
    
    static testmethod void testTwilioMessageKeyPair_send() 
    {
        string accountJsonResponseBody='{'
        +'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
        +'"api_version": "2010-04-01",'
        +'"body": "Test sending MMS from twilio",'
        +'"num_segments": "1",'
        +'"num_media": "1",'
        +'"date_created": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"date_sent": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"date_updated": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"direction": "outbound-api",'
        +'"from": "+14158141829",'
        +'"price": "null",'
        +'"sid": "MM90c6fc909d8504d45ecdb3a3d5b3556e",'
        +'"status": "queued",'
        +'"to": "+14159978453",'
        +'"uri": "/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/MM90c6fc909d8504d45ecdb3a3d5b3556e.json"'
        +'}';
        
        Twilio_TestHTTPMock.getInstance().putResponse('POST',
            'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Messages.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200));
        
        
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
        
        List<TwilioNameValuePair> properties = new List<TwilioNameValuePair>();
        properties.add(new TwilioNameValuePair('To','4506007431'));
        properties.add(new TwilioNameValuePair('From','4509000405'));
        properties.add(new TwilioNameValuePair('MediaUrl','https://www.google.com/images/srpr/logo11w.png'));
        properties.add(new TwilioNameValuePair('MediaUrl','https://www.twilio.com/packages/company/img/logos_downloadable_round.png'));  
        properties.add(new TwilioNameValuePair('Body','Raghu Testing Multiple MMS'));
        
        TwilioMessage mms = client.getAccount().getMessages().create(properties);

        
        System.assertEquals('MM90c6fc909d8504d45ecdb3a3d5b3556e', mms.getsid());
        System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', mms.getaccountsid());
        System.assertEquals('+14159978453',mms.getto());
        System.assertEquals('+14158141829',mms.getfrom());
        System.assertEquals('Test sending MMS from twilio',mms.getbody());
        System.assertEquals('1',mms.getnumSegments());
        System.assertEquals('1',mms.getnumMedia());
        System.assertEquals('queued',mms.getStatus());
        System.assertEquals('null',mms.getPrice());
        System.assertEquals('outbound-api',mms.getDirection());
        System.assertEquals('2010-04-01',mms.getApiVersion());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),mms.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),mms.getDateUpdated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),mms.getDatesent());
    }
    
    static testmethod void testTwilioMessage_get() {
        string accountJsonResponseBody='{'
        +'"account_sid": "AC03c2fcd60e144e7cbeee413fcbf812a3",'
        +'"api_version": "2008-08-01",'
        +'"body": "Test sending mms from twilio",'
        +'"date_created": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"date_sent": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"date_updated": "Mon, 1 Feb 2012 10:49:17 +0000",'
        +'"direction": "outbound-api",'
        +'"from": "+14158141829",'
        +'"price": "-0.02000",'
        +'"sid": "SM800f449d0399ed014aae2bcc0cc2f2ec",'
        +'"status": "queued",'
        +'"to": "+14159978453",'
        +'"uri": "/2010-04-01/Accounts/AC5ef872f6da5a21de157d80997a64bd33/Messages/SM800f449d0399ed014aae2bcc0cc2f2ec.json",'
        +'"subresource_uris": '
        +'{"media":"/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Messages/MMbd2135c6d10f417faf1e03fac4e8397b/Media.json"}'
        +'}';
        
        
        Twilio_TestHTTPMock.getInstance().putResponse(
            'GET',
            'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Messages/SM800f449d0399ed014aae2bcc0cc2f2ec.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
            );
        
        
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);        
        TwilioMessage sms= client.getAccount().getMessage('SM800f449d0399ed014aae2bcc0cc2f2ec');
        System.assertEquals('SM800f449d0399ed014aae2bcc0cc2f2ec', sms.getsid());
        System.assertEquals('AC03c2fcd60e144e7cbeee413fcbf812a3', sms.getaccountsid());
        System.assertEquals('+14159978453',sms.getto());
        System.assertEquals('+14158141829',sms.getfrom());
        System.assertEquals('Test sending mms from twilio',sms.getbody());
        System.assertEquals('queued',sms.getStatus());
        System.assertEquals('-0.02000',sms.getPrice());
        System.assertEquals('outbound-api',sms.getDirection());
        System.assertEquals('2008-08-01',sms.getApiVersion());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),sms.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),sms.getDateUpdated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),sms.getDatesent());

    }
}