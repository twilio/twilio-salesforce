/**
@ name        : TwilioCallParser
@ author      : Aslam Bari (http://www.aslambari.com/contactme.html)
@ email		  : aslam.bari@gmail.com
@ date        : 29 Aug, 2011
@ description : Parser for Calls Twilio API
*/
public class TwilioCallParser {
    
    public TwilioCall twilioCall { get; set; }
    public TwilioCallParser(){
    }
    public void parse(String responseBody){
        JSONObject json = new JSONObject(responseBody);
        system.debug('$$$$$ ' + json);
        this.twilioCall = new TwilioCall();
        this.twilioCall.sid = json.getValue('sid').valueToString();
        this.twilioCall.status = json.getValue('status').valueToString();
        this.twilioCall.date_created = json.getValue('date_created').valueToString();
        this.twilioCall.date_updated = json.getValue('date_updated').valueToString();
        this.twilioCall.uri = json.getValue('uri').valueToString();
        this.twilioCall.parent_call_sid = json.getValue('parent_call_sid').valueToString();
        this.twilioCall.account_sid = json.getValue('account_sid').valueToString();
        this.twilioCall.to = json.getValue('to').valueToString();
        this.twilioCall.to_formatted = json.getValue('to_formatted').valueToString();
        this.twilioCall.frm = json.getValue('from').valueToString();
        this.twilioCall.phone_number_sid = json.getValue('phone_number_sid').valueToString();
        this.twilioCall.frm_formatted = json.getValue('from_formatted').valueToString();
        this.twilioCall.start_time = json.getValue('start_time').valueToString();
        this.twilioCall.end_time = json.getValue('end_time').valueToString();
        this.twilioCall.duration = json.getValue('duration').valueToString();
        this.twilioCall.price = json.getValue('price').valueToString();
        this.twilioCall.api_version = json.getValue('api_version').valueToString();
        this.twilioCall.answered_by = json.getValue('answered_by').valueToString();
        this.twilioCall.annotation = json.getValue('annotation').valueToString();
        this.twilioCall.forwarded_from = json.getValue('forwarded_from').valueToString();
        this.twilioCall.group_sid = json.getValue('group_sid').valueToString();
        this.twilioCall.caller_name = json.getValue('caller_name').valueToString();
        
        
        JSONObject subresource_uris = json.getValue('subresource_uris').obj;
        
        for (string key : subresource_uris.keys()) {
            twilioCallResourceUri u = new twilioCallResourceUri(key, subresource_uris.getValue(key).valueToString());
            this.twilioCall.subresource_uris.add(u);
        }
    }
    public twilioCallParser(RestResponse response) {
        if(response != null)
            parse(response.responseBody);
    }
    
    public class TwilioCall {
        public String sid { get; set; }
        public String parent_call_sid { get; set;}
        public String account_sid { get; set;}
        public String to { get; set;}
        public String to_formatted { get; set;}
        public String frm { get; set;}
        public String frm_formatted { get; set;}
        public String phone_number_sid { get; set;}
        public String status { get; set;}
        public String start_time { get; set;}
        public String end_time { get; set;}
        public String duration { get; set;}
        public String price { get; set;}
        public String api_version { get; set;}
        public String answered_by { get; set;}
        public String annotation { get; set;}
        public String forwarded_from { get; set;}
        public String group_sid { get; set;}
        public String caller_name { get; set;}
        public String date_created { get; set; }
        public String date_updated { get; set; }
        public String uri { get; set; }
        public List<twilioCallResourceUri> subresource_uris { get; set; }
        
        public TwilioCall() {
            this.subresource_uris = new List<twilioCallResourceUri>();
            // defaults? 
        }
    }
    
    public class twilioCallResourceUri {
        public String resource { get; set; }
        public String uri { get; set; }
        
        public twilioCallResourceUri(String resource, String uri) {
            this.resource = resource;
            this.uri = uri;
        }
    }
}