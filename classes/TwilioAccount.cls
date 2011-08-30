public virtual class TwilioAccount extends TwilioResource {

 		private String sid;
        public String friendly_name { get; set;}
        public String status { get; set; }
        public String date_created { get; set; }
        public String date_updated { get; set; }
        public String auth_token { get; set; }
        public String accountType { get; set; } //type
        public String uri { get; set; }
        public List<TwilioAccountResourceUri> subresource_uris { get; set; }
        
        public TwilioAccount(){
        	this.subresource_uris = new List<TwilioAccountResourceUri>();
        }
         
        public TwilioAccount(RestClient client){
        	super(client);
        	this.subresource_uris = new List<TwilioAccountResourceUri>();
        }
        
        public String getSid() { return this.sid; }
        public void setSid(String sid) {
        	this.sid = sid;
        	setRequestAccountSid(sid);
        }
        
        public TwilioAccount ThisAccount() {
        	RestResponse response = getClient().request('/Accounts/' + getRequestAccountSid() + '.json', 'GET', null);
            TwilioAccountParser accountParser = new TwilioAccountParser(this, response); 
            //client.account = this;
            //client.username = this.sid;
            //client.password = this.auth_token;
            return this;
        }
        
        public List<TwilioAccount> AccountList(Map<string,string> params) {

        	TwilioAccountList tal = new TwilioAccountList(getClient(), params);
        	return tal.listAllAccounts;
   		}
        
        public List<TwilioAvailablePhoneNumber> AvailablePhoneNumbers(Boolean toolFree, String isoCountryCode, Map<String,String> params){
        	TwilioAvailablePhoneNumber tpnp = new TwilioAvailablePhoneNumber(getClient(), getRequestAccountSid(), toolFree, isoCountryCode, params);
        	return tpnp.availablePhoneNumbers;
        }
        
        public List<TwilioCall> Calls(Map<string,string> params){
        	TwilioCallListParser tclp = new TwilioCallListParser(getClient(), getRequestAccountSid(), params);
        	return tclp.listAllCalls;
        }
        
        public TwilioCall Call(String sid) {
        	TwilioCallParser tcp = new TwilioCallParser(getClient(), getRequestAccountSid(), sid);
        	return tcp.twilioCall;
        }
        
        public List<TwilioSMS> SmsMessages(Map<string,string> params){
        	TwilioSMSListParser smlp = new TwilioSMSListParser(getClient(), getRequestAccountSid(), params);
        	return smlp.listAllSMS;
        }
        
        public TwilioSMS Sms(String sid){
        	TwilioSMSParser smp = new TwilioSMSParser(getClient(), getRequestAccountSid(), sid);
        	return smp.TwilioSMS;
        }
        
        public List<TwilioApplication> Applications(){
        	TwilioApplicationParser tap = new TwilioApplicationParser(getClient(), getRequestAccountSid());
        	return tap.applications;
        }
        
        public List<TwilioOutgoingCallerId> OutgoingCallerIds() {
    		TwilioOutgoingCallerIdParser outgoingCallerIdParser = new TwilioOutgoingCallerIdParser(getClient(), getRequestAccountSid());
    		return outgoingCallerIdParser.outgoingCallerIds;
    	}
    	
    	public TwilioSMSParser SendSMS(String frm, String to, String body) {
    		return SendSMS(frm, to, body, null);
    	}
    
        public TwilioSMSParser SendSMS(String frm, String to, String body, Map<string,string> params){
        	if(params == null)
    			params = new Map<string, string>();
    		params.put('To', to);
    		params.put('From', frm);
    		params.put('Body', body);
    		TwilioSMSParser smsParser = new TwilioSMSParser(getClient(), getRequestAccountSid(), params);
    		return smsParser;
        }
        
        public TwilioCallParser MakeCall(String frm, String to) {
        	return MakeCall(frm, to, null);
        }
        
        public TwilioCallParser MakeCall(String frm, String to, Map<string,string> params) {
	    	if(params == null)
	    		params = new Map<string, string>();
	    	params.put('To', to);
	    	params.put('From', frm);
	    	
	    	TwilioCallParser callParser = new TwilioCallParser(getClient(), getRequestAccountSid(), params);
	    	return callParser;
    	}
    	
    	/*
    	public void UpdateClientUsernamePassword(){
    		client.username = this.sid;
            client.password = this.auth_token;            
    	}
    	*/
    	
        public class TwilioAccountResourceUri {
        public String resource { get; set; }
        public String uri { get; set; }
        
        public TwilioAccountResourceUri(String resource, String uri) {
            this.resource = resource;
            this.uri = uri;
        }
    }
}