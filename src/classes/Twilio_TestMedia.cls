@isTest
private class Twilio_TestMedia {

    final static String authToken = '12345678901234567890123456789012';
    
    static testMethod void testTwilioMedia() {
    
        string accountJsonResponseBody='{'
            +'"first_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Messages/MM800f449d0399ed014aae2bcc0cc2f2ec/Media.json?PageSize=50&Page=0",'
            +'"last_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Messages/MM800f449d0399ed014aae2bcc0cc2f2ec/Media.json?PageSize=50&Page=0",'
            +'"media_list":['
           +'{'
              +'"sid":"ME85ebf7e12cb821f84b319340424dcb02",'
              +'"account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3",'
              +'"parent_sid":"MM800f449d0399ed014aae2bcc0cc2f2ec",'
              +'"content_type":"image/png",'
              +'"date_created":"Wed, 25 Sep 2013 22:47:18 +0000",'
              +'"date_updated":"Wed, 25 Sep 2013 22:47:19 +0000",'
              +'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Messages/MM800f449d0399ed014aae2bcc0cc2f2ec/Media/ME85ebf7e12cb821f84b319340424dcb02.json"'
           +'},'
           +'{'
              +'"sid":"ME8d8f717e2d6e5383055b3cd150ac5f54",'
              +'"account_sid":"AC03c2fcd60e144e7cbeee413fcbf812a3",'
              +'"parent_sid":"MM800f449d0399ed014aae2bcc0cc2f2ec",'
              +'"content_type":"image/png",'
              +'"date_created":"Wed, 25 Sep 2013 22:47:18 +0000",'
              +'"date_updated":"Wed, 25 Sep 2013 22:47:19 +0000",'
              +'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Messages/MM800f449d0399ed014aae2bcc0cc2f2ec/Media/ME8d8f717e2d6e5383055b3cd150ac5f54.json"'
           +'}'
        +'],'
        +'"previous_page_uri":null,'
        +'"end":1,'
        +'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Messages/MM800f449d0399ed014aae2bcc0cc2f2ec/Media.json?PageSize=50&Page=0",'
        +'"page_size":50,'
        +'"start":0,'
        +'"next_page_uri":null,'
        +'"num_pages":1,'
        +'"total":2,'
        +'"page":0'
        +'}';
    
         Twilio_TestHTTPMock.getInstance().putResponse(
            'GET',
            'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/Messages/MM800f449d0399ed014aae2bcc0cc2f2ec/Media.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
            );
        
        
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);        
        //TwilioMessage mms= client.getAccount().getMessage('SM800f449d0399ed014aae2bcc0cc2f2ec');
        TwilioMediaList medias = client.getAccount().getMessage('MM800f449d0399ed014aae2bcc0cc2f2ec').getMedia();
        
        medias.getResourceLocation();
        medias.getListkey();
        medias.getRequestMessageSid();
        
        
        for (TwilioMedia media : medias.getPageData()) {
                media.getResourceLocation();
                media.getSid();
                media.getRequestMessageSid();
                media.getDateCreated();
                media.getDateUpdated();
                media.getAccountSid();
                media.getParentSid();
                media.getContentType();
                media.getAPIVersion();
                media.getUri();
          
        }
    }
}