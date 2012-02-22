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
private class Twilio_TestRecording 
{
    final static String authToken = '12345678901234567890123456789012';
        
    static testmethod void testTwilioRecordings_get_filter() {
        String accountJsonResponseBody ='{"recordings":[{"sid":"RE4e03662f6b8c01856fbd8f3769c2351a",'
        +'"account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3",'
        +'"call_sid":"CAfd61c7aff9ee4da8a053d49a35a5ff7f",'
        +'"duration":"7",'
        +'"date_created":"Fri, 1 Feb 2012 10:49:17 +0000",'
        +'"api_version":"2010-04-01",'
        +'"date_updated":"Fri, 1 Feb 2012 10:49:17 +0000",'
        +'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Recordings/RE4e03662f6b8c01856fbd8f3769c2351a.json"}],'
        +'"page":0,"num_pages":1,"page_size":50,"total":2,"start":0,"end":1,"uri":'
        +'"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json",'
        +'"first_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?Page=0&PageSize=50",'+
        +'"previous_page_uri":null,"next_page_uri":null,"last_page_uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Applications.json?Page=0&PageSize=50"}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
        // for the HTTP GET method and at the Twilio Account instance URI.
        Twilio_TestHTTPMock.getInstance().putResponse(
            'GET',
            'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Recordings.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
            );
        
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3', authToken);
        TwilioRecordinglist twrecs = client.getAccount().getrecordings();
        System.assertNotEquals(null, twrecs);
        
        List<TwilioRecording> twreclist = twrecs.getPageData();
        System.assertNotEquals(null, twreclist );
        System.assertEquals(1, twreclist.size());
        
        Twiliorecording twrec=twreclist.get(0);
        System.assertEquals('RE4e03662f6b8c01856fbd8f3769c2351a', twrec.getSid());
        System.assertEquals('CAfd61c7aff9ee4da8a053d49a35a5ff7f',twrec.getcallsid());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twrec.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twrec.getDateUpdated());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',twrec.getAccountSid());
        System.assertEquals('2010-04-01',twrec.getApiVersion());
        System.assertEquals(7,twrec.getduration());
        
        map<string,string> params=new map<String,string>();
        params.put('DateCreated','2012-02-01');
        
        Twilio_TestHTTPMock.getInstance().putResponse(
            'GET',
            'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Recordings.json?DateCreated=2012-02-01',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
            );
        
        
        twrecs = client.getAccount().getrecordings(params);
        System.assertNotEquals(null, twrecs);
                
        Iterator<TwilioRecording> it = twrecs.iterator();
        
        System.assertEquals(true, it.hasNext());		
		twrec=it.next();		
        
        System.assertEquals('RE4e03662f6b8c01856fbd8f3769c2351a', twrec.getSid());
        System.assertEquals('CAfd61c7aff9ee4da8a053d49a35a5ff7f',twrec.getcallsid());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twrec.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twrec.getDateUpdated());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',twrec.getAccountSid());
        System.assertEquals('2010-04-01',twrec.getApiVersion());
        System.assertEquals(7,twrec.getduration());
        System.assertEquals(false, it.hasNext());
    }
    
    static testmethod void testTwilioRecording_get() {
        String accountJsonResponseBody ='{"sid":"RE4e03662f6b8c01856fbd8f3769c2351a",'
        +'"account_sid":"AC03c2fcd60e144e7cbeed179fcbf812a3",'
        +'"call_sid":"CAfd61c7aff9ee4da8a053d49a35a5ff7f",'
        +'"duration":"7",'
        +'"date_created":"Fri, 1 Feb 2012 10:49:17 +0000",'
        +'"api_version":"2010-04-01",'
        +'"date_updated":"Fri, 1 Feb 2012 10:49:17 +0000",'
        +'"uri":"/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Recordings/RE4e03662f6b8c01856fbd8f3769c2351a.json"}';
        // register a mock Response with the Twilio_TestHTTPMock singleton service
        // for the HTTP GET method and at the Twilio Account instance URI.
        Twilio_TestHTTPMock.getInstance().putResponse(
            'GET',
            'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeed179fcbf812a3/Recordings/RE4e03662f6b8c01856fbd8f3769c2351a.json',
            new Twilio_TestHTTPMock.Response(accountJsonResponseBody,200)
            );
        
        // Get an API client and request the Twilio Account
        TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeed179fcbf812a3', authToken);
        TwilioRecording twrec = client.getAccount().getRecording('RE4e03662f6b8c01856fbd8f3769c2351a');
        
        System.assertEquals('RE4e03662f6b8c01856fbd8f3769c2351a', twrec.getSid());
        System.assertEquals('CAfd61c7aff9ee4da8a053d49a35a5ff7f',twrec.getCallsid());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twrec.getDateCreated());
        System.assertEquals(Datetime.newInstanceGmt(2012,2,1,10,49,17),twrec.getDateUpdated());
        System.assertEquals('AC03c2fcd60e144e7cbeed179fcbf812a3',twrec.getAccountSid());
        System.assertEquals('2010-04-01',twrec.getApiVersion());
        System.assertEquals(7,twrec.getDuration());
    }
    
	static testmethod void testTwilioRecording_delete() {	
        // register a mock Response with the Twilio_TestHTTPMock singleton service
		// for the HTTP GET method and at the Twilio Account instance URI.
		Twilio_TestHTTPMock.getInstance().putResponse(
				'DELETE',
				'https://api.twilio.com/2010-04-01/Accounts/AC03c2fcd60e144e7cbeee413fcbf812a3/REcordings/RE4e03662f6b8c01856fbd8f3769c2351a.json',
				new Twilio_TestHTTPMock.Response('',204)
			); 
		
			
		TwilioRestClient client = new TwilioRestClient('AC03c2fcd60e144e7cbeee413fcbf812a3', authToken);
		boolean isdel=client.getAccount().getRecording('RE4e03662f6b8c01856fbd8f3769c2351a').deleteResource();
		System.assert(true,isdel);
	}	   
}