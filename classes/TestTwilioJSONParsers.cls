/**
@ name        : TestTwilioJSONParsers
@ author      : Aslam Bari (http://www.aslambari.com/contactme.html)
@ email		  : aslam.bari@gmail.com
@ date        : 24 Aug, 2011
@ description : Test class for Parser for All Twilio API
*/
@isTest
private class TestTwilioJSONParsers{
    @isTest
    private static void testAccountListParser(){
        string response = '{"accounts":[{"sid":"ACe8c6966c7c6b427ffc5b9f74badd50c8","friendly_name":"test co","status":"active","auth_token":"f023cac81bca4413b4b69206dfbc2f55","date_created":"Wed, 24 Aug 2011 05:30:12 +0000","date_updated":"Wed, 24 Aug 2011 05:30:12 +0000","type":"Full","uri":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8.json",' + 
                          '"subresource_uris":{"available_phone_numbers":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/AvailablePhoneNumbers.json","calls":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Calls.json","conferences":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Conferences.json","incoming_phone_numbers":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/IncomingPhoneNumbers.json",' +
                          '"notifications":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Notifications.json","outgoing_caller_ids":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/OutgoingCallerIds.json","recordings":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Recordings.json","sandbox":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Sandbox.json",' + 
                          '"sms_messages":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/SMS/Messages.json","transcriptions":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Transcriptions.json"}},{"sid":"AC092d99de7c35e164631e0a7d8cb1cb51","friendly_name":"test test test co","status":"active","auth_token":"8c16f11eb7dad9af4216df697dac7372","date_created":"Wed, 17 Aug 2011 17:34:19 +0000",' + 
                          '"date_updated":"Wed, 17 Aug 2011 17:34:19 +0000","type":"Full","uri":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51.json","subresource_uris":{"available_phone_numbers":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/AvailablePhoneNumbers.json","calls":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/Calls.json",' + 
                          '"conferences":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/Conferences.json","incoming_phone_numbers":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/IncomingPhoneNumbers.json","notifications":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/Notifications.json",' + 
                          '"outgoing_caller_ids":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/OutgoingCallerIds.json","recordings":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/Recordings.json","sandbox":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/Sandbox.json","sms_messages":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/SMS/Messages.json",' + 
                          '"transcriptions":"/2010-04-01/Accounts/AC092d99de7c35e164631e0a7d8cb1cb51/Transcriptions.json"}}],"page":0,"num_pages":3,"page_size":50,"total":141,"start":0,"end":49,"uri":"/2010-04-01/Accounts/.json","first_page_uri":"/2010-04-01/Accounts/.json?Page=0&PageSize=50","previous_page_uri":null,"next_page_uri":"/2010-04-01/Accounts/.json?Page=1&PageSize=50",' + 
                          '"last_page_uri":"/2010-04-01/Accounts/.json?Page=2&PageSize=50"}';
        TwilioService t = new TwilioService();
        TwilioAccountListParser obj = new TwilioAccountListParser();
        obj.parse(response, t.client, null);
    }
    @isTest
    private static void testAccountParser(){
        string response = '{"sid":"ACe8c6966c7c6b427ffc5b9f74badd50c8","friendly_name":"test co","status":"active","auth_token":"f023cac81bca4413b4b69206dfbc2f55","date_created":"Wed, 24 Aug 2011 05:30:12 +0000","date_updated":"Wed, 24 Aug 2011 05:30:12 +0000","type":"Full","uri":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8.json",'+
                          '"subresource_uris":{"available_phone_numbers":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/AvailablePhoneNumbers.json","calls":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Calls.json","conferences":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Conferences.json",' + 
                          '"incoming_phone_numbers":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/IncomingPhoneNumbers.json","notifications":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Notifications.json","outgoing_caller_ids":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/OutgoingCallerIds.json",' + 
                          '"recordings":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Recordings.json","sandbox":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Sandbox.json","sms_messages":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/SMS/Messages.json","transcriptions":"/2010-04-01/Accounts/ACe8c6966c7c6b427ffc5b9f74badd50c8/Transcriptions.json"}}';
        TwilioAccountParser obj = new TwilioAccountParser();
        obj.parse(response);
    }
    
    @isTest
    private static void testSMSListParser(){
        string response = '{' + 
					    '"sms_messages": [{' + 
					        '"sid": "SMd24672aaab5580152d5ab7b7d035c734",' + 
					        '"date_created": "Mon, 29 Aug 2011 01:17:48 +0000",' + 
					        '"date_updated": "Mon, 29 Aug 2011 01:17:48 +0000",' + 
					        '"date_sent": "Mon, 29 Aug 2011 01:17:48 +0000",' + 
					        '"account_sid": "A1326989455kdfdkj495498509sdndfll9",' + 
					        '"to": "+14088346797",' + 
					        '"from": "+14155992671",' + 
					        '"body": "testing",' + 
					        '"status": "sent",' + 
					        '"direction": "outbound-api",' + 
					        '"price": "-0.01000",' + 
					        '"api_version": "2010-04-01",' + 
					        '"uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/SMS/Messages/SMd24672aaab5580152d5ab7b7d035c734.json"' +
					    '}],' + 
					    '"page":0,"num_pages":1,"page_size":50,"total":1,"start":0,"end":0,"uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/SMS/Messages.json?restProxyCsrfToken=4e5ad5239b6be&restProxyHttpMethod=GET",' + 
					    '"first_page_uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/SMS/Messages.json?restProxyCsrfToken=4e5ad5239b6be&restProxyHttpMethod=GET&Page=0&PageSize=50",' + 
					    '"previous_page_uri": null,' + 
					    '"next_page_uri": null,' + 
					    '"last_page_uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/SMS/Messages.json?restProxyCsrfToken=4e5ad5239b6be&restProxyHttpMethod=GET&Page=0&PageSize=50"' +
					'}';
        TwilioService t = new TwilioService();
        TwilioSMSListParser obj = new TwilioSMSListParser();
        obj.parse(response, t.client, t.GetUserName(), null);
    }
    @isTest
    private static void testSMSParser(){
        string response = '{' + 
						    '"sid": "SMd24672aaab5580152d5ab7b7d035c734",' +
						    '"date_created": "Mon, 29 Aug 2011 01:17:48 +0000",' +
						    '"date_updated": "Mon, 29 Aug 2011 01:17:48 +0000",' +
						    '"date_sent": "Mon, 29 Aug 2011 01:17:48 +0000",' +
						    '"account_sid": "A1326989455kdfdkj495498509sdndfll9",' +
						    '"to": "+14088346797",' +
						    '"from": "+14155992671",' +
						    '"body": "testing",' +
						    '"status": "sent",' +
						    '"direction": "outbound-api",' +
						    '"api_version": "2010-04-01",' +
						    '"price": "-0.01000",' +
						    '"uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/SMS/Messages/SMd24672aaab5580152d5ab7b7d035c734.json"' + 
						'}';
        TwilioSMSParser obj = new TwilioSMSParser();
        obj.parse(response);
    }
    
    @isTest
    private static void testCallListParser(){
        string response = '{' + 
						    '"calls": [{' +
						        '"sid": "CA1434e0ce255d9ee028d1ad94ef8409dd",' + 
						        '"date_created": "Mon, 29 Aug 2011 00:57:40 +0000",' + 
						        '"date_updated": "Mon, 29 Aug 2011 00:57:40 +0000",' + 
						        '"parent_call_sid": null,' +
						        '"account_sid": "A1326989455kdfdkj495498509sdndfll9",' + 
						        '"to": "client:tommy",' + 
						        '"to_formatted": "tommy",' + 
						        '"from": "+14158675309",' + 
						        '"from_formatted": "(415) 867-5309",' + 
						        '"phone_number_sid": null,' +
						        '"status": "no-answer",' + 
						        '"start_time": "Mon, 29 Aug 2011 00:57:40 +0000",' + 
						        '"end_time": null,' +
						        '"duration": null,' +
						        '"price": null,' +
						        '"direction": "outbound-api",' + 
						        '"answered_by": null,' +
						        '"annotation": null,' +
						        '"api_version": "2010-04-01",' + 
						        '"forwarded_from": null,' +
						        '"group_sid": null,' +
						        '"caller_name": null,' +
						        '"uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls/CA1434e0ce255d9ee028d1ad94ef8409dd.json",' + 
						        '"subresource_uris": {'+
						            '"notifications": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls/CA1434e0ce255d9ee028d1ad94ef8409dd/Notifications.json",' + 
						            '"recordings": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls/CA1434e0ce255d9ee028d1ad94ef8409dd/Recordings.json"' + 
						        '}' + 
						    '},  {' + 
						        '"sid": "CAeb1e18ff42b407053da9d9304bdfbbb0",' + 
						        '"date_created": "Mon, 22 Aug 2011 15:15:17 +0000",' + 
						        '"date_updated": "Mon, 22 Aug 2011 15:15:54 +0000",' + 
						        '"parent_call_sid": "CA46c277079cecd6e27539867710cd5f38",' + 
						        '"account_sid": "A1326989455kdfdkj495498509sdndfll9",' + 
						        '"to": "+14088346797",' + 
						        '"to_formatted": "(408) 834-6797",' + 
						        '"from": "+14083869281",' + 
						        '"from_formatted": "(408) 386-9281",' + 
						        '"phone_number_sid": "PN5be24e251ac46de2f8fadff75bd0c64b",' + 
						        '"status": "no-answer",' + 
						        '"start_time": "Mon, 22 Aug 2011 15:15:17 +0000",' + 
						        '"end_time": "Mon, 22 Aug 2011 15:15:54 +0000",' + 
						        '"duration": "0",' + 
						        '"price": null,' +
						        '"direction": "outbound-dial",' + 
						        '"answered_by": null,' +
						        '"annotation": null,' +
						        '"api_version": "2010-04-01",' + 
						        '"forwarded_from": "+19165121606",' + 
						        '"group_sid": null,' +
						        '"caller_name": "Testing",' + 
						        '"uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls/CAeb1e18ff42b407053da9d9304bdfbbb0.json",' + 
						        '"subresource_uris": {' +
						            '"notifications": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls/CAeb1e18ff42b407053da9d9304bdfbbb0/Notifications.json",' + 
						            '"recordings": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls/CAeb1e18ff42b407053da9d9304bdfbbb0/Recordings.json"' + 
						        '}' + 
						    '}],' + 
						    '"page":0,"num_pages":1,"page_size":50,"total":1,"start":0,"end":0,"uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls.json?restProxyCsrfToken=4e5ad5239b6be&restProxyHttpMethod=GET",' + 
						    '"first_page_uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls.json?restProxyCsrfToken=4e5ad5239b6be&restProxyHttpMethod=GET&Page=0&PageSize=50",' + 
						    '"previous_page_uri": null,' + 
						    '"next_page_uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls.json?restProxyCsrfToken=4e5ad5239b6be&restProxyHttpMethod=GET&Page=1&PageSize=50",' + 
						    '"last_page_uri": "/2010-04-01/Accounts/A1326989455kdfdkj495498509sdndfll9/Calls.json?restProxyCsrfToken=4e5ad5239b6be&restProxyHttpMethod=GET&Page=61&PageSize=50"' + 
						'}';
        TwilioService t = new TwilioService();
        TwilioCallListParser obj = new TwilioCallListParser();
        obj.parse(response, t.client, t.GetUserName(), null);
    }
    @isTest
    private static void testCallParser(){
        string response = '{"sid":"CA1434e0ce255d9ee028d1ad94ef8409dd","date_created":"Mon, 29 Aug 2011 00:57:40 +0000","date_updated":"Mon, 29 Aug 2011 00:57:40 +0000","parent_call_sid":null,'+
        '"account_sid":"ACc3jdfksdfj454543jdk9","to":"client:tommy","to_formatted":"tommy","from":"+14158675309","from_formatted":"(415) 867-5309",'+
        '"phone_number_sid":null,"status":"no-answer","start_time":"Mon, 29 Aug 2011 00:57:40 +0000","end_time":null,"duration":null,"price":null,'+
        '"direction":"outbound-api","answered_by":null,"api_version":"2010-04-01","annotation":null,"forwarded_from":null,"group_sid":null,"caller_name":null,'+
        '"uri":"/2010-04-01/Accounts/ACc3jdfksdfj454543jdk9/Calls/CA1434e0ce255d9ee028d1ad94ef8409dd.json","subresource_uris":{"notifications":"/2010-04-01/Accounts/ACc3jdfksdfj454543jdk9/Calls/CA1434e0ce255d9ee028d1ad94ef8409dd/Notifications.json",'+
        '"recordings":"/2010-04-01/Accounts/ACc3jdfksdfj454543jdk9/Calls/CA1434e0ce255d9ee028d1ad94ef8409dd/Recordings.json"}}';
        TwilioCallParser obj = new TwilioCallParser();
        obj.parse(response);
    }
    
    @isTest
    private static void testAvailablePhoneNumberParser(){
        string response = '{' +
                                '"available_phone_numbers": [{'+
                                    '"friendly_name": "(510) 342-3162",'+
                                    '"phone_number": "+15103423162",'+
                                    '"latitude": "37.660000",'+
                                    '"longitude": "-122.070000",'+
                                    '"region": "CA",'+
                                    '"postal_code": "94578",'+
                                    '"iso_country": "US",'+
                                    '"lata": "722",'+
                                    '"rate_center": "HAYWARD"'+
                                '}, {'+
                                    '"friendly_name": "(510) 342-3148",'+
                                    '"phone_number": "+15103423148",'+
                                    '"latitude": "37.660000",'+
                                    '"longitude": "-122.070000",'+
                                    '"region": "CA",'+
                                    '"postal_code": "94578",'+
                                    '"iso_country": "US",'+
                                    '"lata": "722",'+
                                    '"rate_center": "HAYWARD"'+
                                '}'+
                            '],'+
                                '"uri": "2010-04-01AccountsA1326989455kdfdkj495498509sdndfll9AvailablePhoneNumbersUS'+
                            'Local.json?restProxyCsrfToken=4e5325b6bbb4a&restProxyHttpMethod=GET&AreaCode=510"'+
                            '}';
        RestResponse restResponse = new RestResponse (response, 200);
        TwilioAvailablePhoneNumberParser obj = new TwilioAvailablePhoneNumberParser(restResponse);
    }
    
    @isTest
    private static void testTwilioCapability(){
        TwilioCapability cap = new TwilioCapability('test','test');

        cap.allowClientOutgoing('test');
        cap.allowClientIncoming('test');
        Map<string,string> params = new Map<string,string>();
        cap.allowEventStream(params);
        cap.generateToken();
        cap.generateToken(454545);
    }
    
    @isTest
    private static void testTwilioRestClient(){
        RestClient client = new RestClient('test','test');
        client = new RestClient('test','test','test');
        Map<string,string> params = new Map<string,string>();
        params.put('test','test');
        client.request('test','test',null);
        client.request('test','test',params);
    }
    
    @isTest
    private static void testTwilioService(){
        TwilioService serv = new TwilioService();
        //serv.Accounts();
        serv.AccountList();
        serv.AvailablePhoneNumbers(true, 'US', null);
        serv.GetSMSList();
        serv.GetSMS('test98989');
        serv.getUserName();
        serv.Calls();
        serv.Calls('test4345');
        serv.MakeCall('23434', '454545');
        serv.MakeCall('34355','4545',null);
        serv.SendSMS('454545','454545','test',null);
    }
    
    @isTest
    private static void testTwilioTestPageController(){
        TwilioTestPageController serv = new TwilioTestPageController();
        serv.TestAccountListResource();
    }
    
    @isTest
    private static void testTwilioOutgoingCallerIdParser(){
    	String response = '{' + 
					    '"outgoing_caller_ids": [{' + 
					        '"sid": "PN7b62b699acb05aea46ddb81629fd4a29",' + 
					        '"account_sid": "ACc33f8a640b4fec9645368557cd69b5b9",' + 
					        '"friendly_name": "(408) 834-6797",' + 
					        '"phone_number": "+14088346797",' + 
					        '"date_created": "Tue, 23 Aug 2011 15:27:08 +0000",' + 
					        '"date_updated": "Tue, 23 Aug 2011 15:27:08 +0000",' + 
					        '"uri": "/2010-04-01/Accounts/ACc33f8a640b4fec9645368557cd69b5b9/OutgoingCallerIds/PN7b62b699acb05aea46ddb81629fd4a29.json"' + 
					    '}]' + 
					'}';
    	RestResponse restResponse = new RestResponse (response, 200);
    	TwilioOutgoingCallerIdParser obj = new TwilioOutgoingCallerIdParser(restResponse);
    }
    
    @isTest
    private static void testTwilioApplicationParser(){
    	String response = '{' + 
					    '"applications": [{' + 
				        '"sid": "AP3e1d760d30d638e2c5cf40d2f9961a72",' + 
				        '"date_created": "Mon, 29 Aug 2011 05:41:14 +0000",' + 
				        '"date_updated": "Mon, 29 Aug 2011 05:41:14 +0000",' + 
				        '"account_sid": "ACjfdgkjrf9689890fgkjfgfgf9",' + 
				        '"friendly_name": "Testing",' + 
				        '"api_version": "2010-04-01",' + 
				        '"voice_url": "",' + 
				        '"voice_method": "POST",' + 
				        '"voice_fallback_url": "",' + 
				        '"voice_fallback_method": "POST",' + 
				        '"status_callback": "",' + 
				        '"status_callback_method": "POST",' + 
				        '"voice_caller_id_lookup": false,' +
				        '"sms_url": "",' + 
				        '"sidsms_method": "",' +
				        '"sms_method": "POST",' + 
				        '"sms_fallback_url": "",' + 
				        '"sms_fallback_method": "POST",' + 
				        '"sms_status_callback": "",' + 
				        '"uri": "/2010-04-01/Accounts/ACc33ffgdfg4595906859068b5b9/Applications/fgdfkgjkl56t590950685.json"' + 
				    '}],'+
				    					    '"page": 0,' + 
					    '"num_pages": 0,' + 
					    '"page_size": 50,' + 
					    '"total": 0,' + 
					    '"start": 0,' + 
					    '"end": 0,' + 
					    '"uri": "/2010-04-01/Accounts/dsfjsdkfj459u49549dfkdjlfkdj/Applications.json?restProxyCsrfToken=4e5ad5239b6be&restProxyHttpMethod=GET",' +
					    '"first_page_uri": null,' +
					    '"previous_page_uri": null,' +
					    '"next_page_uri": null,' +
					    '"last_page_uri": null' +
					'}';
    	RestResponse restResponse = new RestResponse (response, 200);
    	TwilioApplicationParser obj = new TwilioApplicationParser(restResponse);
    }
    
}