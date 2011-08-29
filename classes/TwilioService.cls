public class TwilioService {
    private String endpoint = 'https://api.twilio.com/2010-04-01';
    
    
    private String username = '';
    private String password = '';
    
    public String responseString { get; set; }
    public RestClient client;
    
    public TwilioService() {
        client = new RestClient(username, password, endpoint); // using defaults
    }
    public String getUserName(){
    	return username;
    }
    public TwilioAccountParser MainAccount() {
        RestResponse response = client.request('/Accounts/' + username + '.json', 'GET', null);
        TwilioAccountParser accountParser = new TwilioAccountParser(response);
        
        return accountParser;
    }
    
    public TwilioAvailablePhoneNumberParser AvailablePhoneNumbers(Boolean toolFree, String isoCountryCode, Map<String, String>params) {
        String category = 'Local';
        if (toolFree == true) {
            category = 'TollFree';
        }
        RestResponse response = client.request('/Accounts/' + username + '/AvailablePhoneNumbers/' + isoCountryCode + '/' + category + '.json', 'GET', params);
        TwilioAvailablePhoneNumberParser phoneNumberParser = new TwilioAvailablePhoneNumberParser(response);
        
        return phoneNumberParser;
    }
    
     public TwilioAccountListParser AccountList(Map<string,string> params) {

        RestResponse response = client.request('/Accounts/' + '.json', 'GET', params);
        TwilioAccountListParser accountParser = new TwilioAccountListParser(response, client, params);
        
        return accountParser;
     }
     
     public TwilioAccountListParser AccountList() {

        RestResponse response = client.request('/Accounts/' + '.json', 'GET', null);
        TwilioAccountListParser accountParser = new TwilioAccountListParser(response, client, null);
        
        return accountParser;
     }
    
    public TwilioOutgoingCallerIdParser OutgoingCallerIds() {
    	RestResponse response = client.request('/Accounts/' + username + '/OutgoingCallerIds.json', 'GET', null);
    	TwilioOutgoingCallerIdParser outgoingCallerIdParser = new TwilioOutgoingCallerIdParser(response);
    	
    	return outgoingCallerIdParser;
    }
    
    public TwilioApplicationParser Applications() {
    	RestResponse response = client.request('/Accounts/' + username + '/Applications.json', 'GET', null);
    	TwilioApplicationParser applicationParser = new TwilioApplicationParser(response);
    	return applicationParser;
    }
     
    public TwilioCallParser Calls(String callSid) {
    	RestResponse response = client.request('/Accounts/' + username + '/Calls/' + callSid + '.json', 'GET', null);
    	TwilioCallParser callParser = new TwilioCallParser(response);
    	return callParser;
    }
    
    public TwilioCallListParser Calls() {
    	RestResponse response = client.request('/Accounts/' + username + '/Calls.json', 'GET', null);
    	TwilioCallListParser callListParser = new TwilioCallListParser(response, client, username, null);
    	return callListParser;
    }
    
    public TwilioCallParser MakeCall(String frm, String to) {
    	return MakeCall(frm, to, null);
    }
    
    public TwilioCallParser MakeCall(String frm, String to, Map<string,string> params) {
    	if(params == null)
    		params = new Map<string, string>();
    	params.put('To', to);
    	params.put('From', frm);
    	RestResponse response = client.request('/Accounts/' + username + '/Calls.json', 'POST', params);
    	TwilioCallParser callParser = new TwilioCallParser(response);
    	return callParser;
    }
    
    public TwilioSMSListParser GetSMSList() {
    	RestResponse response = client.request('/Accounts/' + username + '/SMS/Messages.json', 'GET', null);
    	TwilioSMSListParser smsListParser = new TwilioSMSListParser(response, client, username, null);
    	return smsListParser;
    }
    
    public TwilioSMSParser GetSMS(String smsMsgId) {
    	RestResponse response = client.request('/Accounts/' + username + '/SMS/Messages/' + smsMsgId +'.json', 'GET', null);
    	TwilioSMSParser smsParser = new TwilioSMSParser(response);
    	return smsParser;
    }
    
    public TwilioSMSParser SendSMS(String frm, String to, String body, Map<string,string> params) {
    	if(params == null)
    		params = new Map<string, string>();
    	params.put('To', to);
    	params.put('From', frm);
    	RestResponse response = client.request('/Accounts/' + username + '/SMS/Messages.json', 'POST', params);
    	TwilioSMSParser smsParser = new TwilioSMSParser(response);
    	return smsParser;
    }
    
    public TwilioCallParser ModifyCall(String callSid, Map<string,string> params) {
    	RestResponse response = client.request('/Accounts/' + username + '/Calls/' + callSid + '.json', 'POST', params);
    	TwilioCallParser callParser = new TwilioCallParser(response);
    	return callParser;
    }
}