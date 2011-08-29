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
    public TwilioSMSParser(RestResponse response) {
        if(response != null)
            parse(response.responseBody);
    }
    
    public class TwilioSMS {
        public String sid { get; set; }
        public String date_sent { get; set;}
        public String account_sid { get; set;}
        public String to { get; set;}
        public String body { get; set;}
        public String frm { get; set;}
        public String direction { get; set;}
        public String status { get; set;}
        public String price { get; set;}
        public String api_version { get; set;}
        public String date_created { get; set; }
        public String date_updated { get; set; }
        public String uri { get; set; }
        
        public TwilioSMS() {

        }
    }
}