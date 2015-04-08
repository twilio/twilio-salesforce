@isTest
private class Twilio_TestQueue 
{
    final static String authToken = '12345678901234567890123456789012';
    
    static testMethod void testTwilioQueue_create()
    {
         string accountJsonResponseBody='{'
         +'"sid": "QUd6ef9309ce0d4780b243057e37dda857",'
         +'"friendly_name": "TestQueue",'
         +'"current_size": 0,'
         +'"average_wait_time": 0,'
         +'"max_size": 100,'
         +'"date_created": "Fri, 01 Nov 2013 06:06:49 +0000",'
         +'"date_updated": "Fri, 01 Nov 2013 06:06:49 +0000",'
         +'"uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857.json"'
         +'}';
    
        Twilio_TestHTTPMock.getInstance().putResponse('POST',
            'https://api.twilio.com/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200));
            
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('ACadfb5891c0e4f8c6c34be620a8ec1ef3', authToken);
        
        
        List<TwilioNameValuePair> params = new List<TwilioNameValuePair>();
        params.add(new TwilioNameValuePair('FriendlyName','TestQueue'));

        TwilioQueue queue = client.getAccount().getQueues().create(params);
        
        System.assertEquals('QUd6ef9309ce0d4780b243057e37dda857', queue.getsid());
        System.assertEquals('TestQueue', queue.getFriendlyName());
        System.assertEquals('0',String.valueof(queue.getCurrentSize()));
        System.assertEquals('100',String.valueof(queue.getMaxSize()));
        System.assertEquals('0',String.valueof(queue.getAverageWaitTime()));

    }
    
    static testMethod void testTwilioQueue_availableQueues()
    {
         string accountJsonResponseBody='{'
         +'"start": 0,'
         +'"total": 2,'
         +'"uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues.json",'
         +'"end": 49,'
         +'"first_page_uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues.json?Page=0&PageSize=50",'
         +'"last_page_uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues.json?Page=0&PageSize=50",'
         +'"next_page_uri": "",'
         +'"num_pages": 0,'
         +'"page": 0,'
         +'"page_size": 50,'
         +'"previous_page_uri": "",'
         +'"queues": ['
         +'{' 
            +'"average_wait_time": 0,'
            +'"current_size": 0,'
            +'"date_created": "Thu, 26 Apr 2012 20:12:45 +0000",'
            +'"date_updated": "Thu, 26 Apr 2012 20:12:45 +0000",'
            +'"friendly_name": "TestQueue",'
            +'"max_size": 100,'
            +'"sid": "QUd6ef9309ce0d4780b243057e37dda857",'
            +'"uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857.json"'
        +'}'
        +']'
         +'}';
    
        Twilio_TestHTTPMock.getInstance().putResponse('GET',
            'https://api.twilio.com/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200));
            
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('ACadfb5891c0e4f8c6c34be620a8ec1ef3', authToken);
        
        
        TwilioQueueList queues = client.getAccount().getQueues();

        for(TwilioQueue queue :queues.getPageData())
        {
            System.assertEquals('QUd6ef9309ce0d4780b243057e37dda857', queue.getsid());
            System.assertEquals('TestQueue', queue.getFriendlyName());
            System.assertEquals('0',String.valueof(queue.getCurrentSize()));
            System.assertEquals('100',String.valueof(queue.getMaxSize()));
            System.assertEquals('0',String.valueof(queue.getAverageWaitTime()));    
        
        }
        

    }
    
    static testMethod void testTwilioQueue_update()
    {
         string accountJsonResponseBody='{'
         +'"average_wait_time": 0,'
         +'"friendly_name": "TestQueue",'
         +'"current_size": 0,'
         +'"max_size": 123,'
         +'"average_wait_time": 0,'
         +'"date_updated": "Fri, 22 Jun 2012 00:02:15 +0000",'
         +'"date_created": "Thu, 21 Jun 2012 23:55:36 +0000",'
         +'"sid": "QUd6ef9309ce0d4780b243057e37dda857",'
         +'"uri": "/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857.json"'
         +'}';
    
        Twilio_TestHTTPMock.getInstance().putResponse('POST',
            'https://api.twilio.com/2010-04-01/Accounts/ACadfb5891c0e4f8c6c34be620a8ec1ef3/Queues/QUd6ef9309ce0d4780b243057e37dda857',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200));
            
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('ACadfb5891c0e4f8c6c34be620a8ec1ef3', authToken);
        
        TwilioQueue queue = client.getAccount().getQueue('QUd6ef9309ce0d4780b243057e37dda857');
        List<TwilioNameValuePair> params = new List<TwilioNameValuePair>();
        params.add(new TwilioNameValuePair('MaxSize','123'));

        queue.updateResource(params);
        
        /*TwilioQueue queue = client.getAccount().getQueues().create(params);
        
        System.assertEquals('QUd6ef9309ce0d4780b243057e37dda857', queue.getsid());
        System.assertEquals('TestQueue', queue.getFriendlyName());
        System.assertEquals('0',String.valueof(queue.getCurrentSize()));
        System.assertEquals('100',String.valueof(queue.getMaxSize()));
        System.assertEquals('0',String.valueof(queue.getAverageWaitTime()));*/

    }
}