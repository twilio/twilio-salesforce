public class TwilioAccountParser extends TwilioAccount {
       
    public TwilioAccount twilioAccount { get; set; }
	public TwilioAccountParser(){}
    public void parse(String responseBody){
        JSONObject json = new JSONObject(responseBody);
      
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
    
    public TwilioAccountParser(TwilioAccount twilioAccount, RestResponse response) {
    	this.twilioAccount = twilioAccount;
        if(response != null)
            parse(response.responseBody);
    }
     
}