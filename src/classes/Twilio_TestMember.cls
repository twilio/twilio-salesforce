@isTest
private class Twilio_TestMember {

    final static String authToken = '12345678901234567890123456789012';
    
    static testMethod void testTwilioMember_memberList()
    {
        string accountJsonResponseBody='{'
        +'"num_pages": 1,'
        +'"page": 0,'
        +'"page_size": 50,'
        +'"start": 0,'
        +'"total": 2,'
        +'"end": 1,'
        +'"first_page_uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857/Members.json?Page=0&PageSize=50",'
        +'"last_page_uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857/Members.json?Page=0&PageSize=50",'
        +'"next_page_uri": null,'
        +'"previous_page_uri": null,'
        +'"uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857/Members.json",'
        +'"queue_members": ['
            +'{'
                +'"call_sid": "CA5ef8732a3c49700934481addd5ce1659",'
                +'"date_enqueued": "Mon, 4 Feb 2012 15:44:15 +0000",'
                +'"wait_time": 30,'
                +'"position": 1,'
                +'"uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857/Members/CA5ef8732a3c49700934481addd5ce1659.json"'
           +' }'
        +']'
        +'}';
        
        Twilio_TestHTTPMock.getInstance().putResponse('GET',
            'https://api.twilio.com/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857/Members.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200));
            
         // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('ACadfb5891c0e4f8c6c34be620a8ec1ef3', authToken);
        
        TwilioMemberList members = client.getAccount().getQueue('QUd6ef9309ce0d4780b243057e37dda857').getMembers();
     
        // Loop over members and print out a property for each one.
        for (TwilioMember member : members.getPageData()) {
            member.getQueueSid();
            member.getCallSid();
            member.getDateEnqueued();
            member.getWaitTime();
            member.getPosition();
            member.getResourceLocation();
            member.getDateCreated();
        }
    }
    
    static testMethod void testTwilioMember_dequeue()
    {
    
        string accountJsonResponseBody='{'
        +'"call_sid": "CA386025c9bf5d6052a1d1ea42b4d16662",'
        +'"date_enqueued": "Mon, 4 Feb 2012 15:44:15 +0000",'
        +'"wait_time": 30,'
        +'"position": 0,'
        +'"uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857/Members/CA386025c9bf5d6052a1d1ea42b4d16662.json"'
        +'}';
        
        Twilio_TestHTTPMock.getInstance().putResponse('POST',
            'https://api.twilio.com/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857/Members/CA386025c9bf5d6052a1d1ea42b4d16662.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200));
            
         // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('ACadfb5891c0e4f8c6c34be620a8ec1ef3', authToken);
        
        TwilioMember member = client.getAccount().getQueue('QUd6ef9309ce0d4780b243057e37dda857').getMember('CA386025c9bf5d6052a1d1ea42b4d16662');
        // Build a filter for the MemberList
        List<TwilioNameValuePair> params = new List<TwilioNameValuePair>();
        params.add(new TwilioNameValuePair('Url', 'http://demo.twilio.com/docs/voice.xml'));
        params.add(new TwilioNameValuePair('Method','POST'));
        member.updateResource(params);
        
    }
}