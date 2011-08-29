public class TwilioAccountParser {
    
    public TwilioAccount twilioAccount { get; set; }
    public TwilioAccountParser(){
    }
    public void parse(String responseBody){
        JSONObject json = new JSONObject(responseBody);
        
        this.twilioAccount = new TwilioAccount();
        this.twilioAccount.sid = json.getValue('sid').valueToString();
        this.twilioAccount.friendly_name = json.getValue('friendly_name').valueToString();
        this.twilioAccount.status = json.getValue('status').valueToString();
        this.twilioAccount.date_created = json.getValue('date_created').valueToString();
        this.twilioAccount.date_updated = json.getValue('date_updated').valueToString();
        this.twilioAccount.auth_token = json.getValue('auth_token').valueToString();
        this.twilioAccount.accountType = json.getValue('type').valueToString();
        this.twilioAccount.uri = json.getValue('uri').valueToString();
        
        JSONObject subresource_uris = json.getValue('subresource_uris').obj;
        
        for (string key : subresource_uris.keys()) {
            TwilioAccountResourceUri u = new TwilioAccountResourceUri(key, subresource_uris.getValue(key).valueToString());
            this.twilioAccount.subresource_uris.add(u);
        }
    }
    public TwilioAccountParser(RestResponse response) {
        if(response != null)
            parse(response.responseBody);
    }
    
    public class TwilioAccount {
        public String sid { get; set; }
        public String friendly_name { get; set;}
        public String status { get; set; }
        public String date_created { get; set; }
        public String date_updated { get; set; }
        public String auth_token { get; set; }
        public String accountType { get; set; } //type
        public String uri { get; set; }
        public List<TwilioAccountResourceUri> subresource_uris { get; set; }
        
        public TwilioAccount() {
            this.subresource_uris = new List<TwilioAccountResourceUri>();
            // defaults? 
        }
    }
    
    public class TwilioAccountResourceUri {
        public String resource { get; set; }
        public String uri { get; set; }
        
        public TwilioAccountResourceUri(String resource, String uri) {
            this.resource = resource;
            this.uri = uri;
        }
    }
}