/**
@ name        : TwilioSMSParser
@ author      : Aslam Bari (http://www.aslambari.com/contactme.html)
@ email		  : aslam.bari@gmail.com
@ date        : 29 Aug, 2011
@ description : Parser for Calls Twilio API
*/
public class TwilioSMSParser {
    
    public TwilioSMS TwilioSMS { get; set; }
    public TwilioSMSParser(){
    }
    public void parse(String responseBody){    	
        JSONObject json = new JSONObject(responseBody);
        
        system.debug('DEBUG response: '+ responseBody);
        
        this.TwilioSMS = new TwilioSMS();
        this.TwilioSMS.sid = json.getValue('sid').valueToString();
        this.TwilioSMS.date_sent = json.getValue('date_sent').valueToString();
        this.TwilioSMS.status = json.getValue('status').valueToString();
        this.TwilioSMS.date_created = json.getValue('date_created').valueToString();
        this.TwilioSMS.date_updated = json.getValue('date_updated').valueToString();
        this.TwilioSMS.uri = json.getValue('uri').valueToString();
        this.TwilioSMS.body = json.getValue('body').valueToString();
        this.TwilioSMS.account_sid = json.getValue('account_sid').valueToString();
        this.TwilioSMS.to = json.getValue('to').valueToString();
        this.TwilioSMS.frm = json.getValue('from').valueToString();
        this.TwilioSMS.direction = json.getValue('direction').valueToString();
        this.TwilioSMS.price = json.getValue('price').valueToString();
        this.TwilioSMS.api_version = json.getValue('api_version').valueToString();
    }
    public TwilioSMSParser(RestClient client, String smsMsgId) {
    	RestResponse response = client.request('/Accounts/' + client.username + '/SMS/Messages/' + smsMsgId +'.json', 'GET', null); 
        if(response != null)
            parse(response.responseBody);
    }
    
    public TwilioSMSParser(RestClient client, Map<string,string> params){
    	 RestResponse response = client.request('/Accounts/' + client.username + '/SMS/Messages.json', 'POST', params);
    	 if(response != null)
            parse(response.responseBody);
    }
 
}