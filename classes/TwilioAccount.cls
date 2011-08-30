public virtual class TwilioAccount {

 		public String sid { get; set; }
        public String friendly_name { get; set;}
        public String status { get; set; }
        public String date_created { get; set; }
        public String date_updated { get; set; }
        public String auth_token { get; set; }
        public String accountType { get; set; } //type
        public String uri { get; set; }
        public List<TwilioAccountResourceUri> subresource_uris { get; set; }
        public RestClient client { get; set; }
        
        public TwilioAccount(){
        	this.subresource_uris = new List<TwilioAccountResourceUri>();
        }
         
        public TwilioAccount(RestClient client){
        	this.client = client;
        	this.subresource_uris = new List<TwilioAccountResourceUri>();
        }
        
        public TwilioAccount ThisAccount() {
        	RestResponse response = client.request('/Accounts/' + client.username + '.json', 'GET', null);
            TwilioAccountParser accountParser = new TwilioAccountParser(this, response); 
            client.account = this;
            client.username = this.sid;
            client.password = this.auth_token;
            return this;
        }
        
        public List<TwilioAccount> AccountList(Map<string,string> params) {

        	TwilioAccountList tal = new TwilioAccountList(client, params);
        	return tal.listAllAccounts;
   		}
        
        public List<TwilioAvailablePhoneNumber> AvailablePhoneNumbers(Boolean toolFree, String isoCountryCode, Map<String,String> params){
        	TwilioAvailablePhoneNumber tpnp = new TwilioAvailablePhoneNumber(client, toolFree, isoCountryCode, params);
        	return tpnp.availablePhoneNumbers;
        }
        
        public List<TwilioCall> Calls(Map<string,string> params){
        	TwilioCallListParser tclp = new TwilioCallListParser(client, params);
        	return tclp.listAllCalls;
        }
        
        public TwilioCall Call(String sid) {
        	TwilioCallParser tcp = new TwilioCallParser(client, sid);
        	return tcp.twilioCall;
        }
        
        public List<TwilioSMS> SmsMessages(Map<string,string> params){
        	TwilioSMSListParser smlp = new TwilioSMSListParser(client, params);
        	return smlp.listAllSMS;
        }
        
        public TwilioSMS Sms(String sid){
        	TwilioSMSParser smp = new TwilioSMSParser(client, sid);
        	return smp.TwilioSMS;
        }
        
        public List<TwilioApplication> Applications(){
        	TwilioApplicationParser tap = new TwilioApplicationParser(client);
        	return tap.applications;
        }
        
        public List<TwilioOutgoingCallerId> OutgoingCallerIds() {
    		TwilioOutgoingCallerIdParser outgoingCallerIdParser = new TwilioOutgoingCallerIdParser(client);
    		return outgoingCallerIdParser.outgoingCallerIds;
    	}
    
        public TwilioSMSParser SendSMS(String frm, String to, String body, Map<string,string> params){
        	if(params == null)
    		params = new Map<string, string>();
    		params.put('To', to);
    		params.put('From', frm);
    		params.put('Body', body);
    		TwilioSMSParser smsParser = new TwilioSMSParser(client, params);
    		return smsParser;
        }
        
        public TwilioCallParser MakeCall(String frm, String to, Map<string,string> params) {
	    	if(params == null)
	    		params = new Map<string, string>();
	    	params.put('To', to);
	    	params.put('From', frm);
	    	
	    	TwilioCallParser callParser = new TwilioCallParser(client, params);
	    	return callParser;
    	}
    	
    	public void UpdateClientUsernamePassword(){
    		client.username = this.sid;
            client.password = this.auth_token;            
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