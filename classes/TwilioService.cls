public class TwilioService {
    private String endpoint = 'https://api.twilio.com/2010-04-01';
    
    private String username = 'Account SID here';
    private String password = 'AuthToken here'; 
  
    private String responseString { get; set; }
    private RestClient client;
    public TwilioAccount account;
    
    public TwilioService() {
        client = new RestClient(username, password); // using defaults
        account = new TwilioAccount(client);
    }
    
    public TwilioService(String accountSid, String authKey) {
        client = new RestClient(accountSid, authKey);
        account = new TwilioAccount(client);
		account.setRequestAccountSid(accountSid);
    }
  
  
    public String getUserName(){
        return username;
    }
    
    public TwilioAccount ThisAccount() {
        TwilioAccount ta = new TwilioAccount(client);
        return ta.ThisAccount();
    }
    
    public List<TwilioAccount> AccountList(Map<string,string> params){
        List<TwilioAccount> acctList = account.AccountList(params);
 
        return acctList;
    }
    
    public List<TwilioAvailablePhoneNumber> AvailablePhoneNums(Boolean toolFree, String isoCountryCode, Map<String, String> params) {
        
        return account.AvailablePhoneNumbers(toolFree, isoCountryCode, params);
        
    }
    
    public List<TwilioCall> AllCalls(Map<string,string> params){
        
        return account.Calls(params);
        
    }
    
    public TwilioCall Call(String sid){
        TwilioCall call = account.Call(sid);
        system.debug('INFO: call = '+ call.caller_name);
        return call;
    }
    
    public List<TwilioSMS> AllSms(Map<string,string> params){
        return account.SmsMessages(params);
    }
    
    public TwilioSMS Sms(String sid) {
        TwilioSMS sms = account.Sms(sid);
        system.debug('INFO: sms = '+ sms.to);
        return sms;
    }
    
   public List<TwilioApplication> Applications() {
        return account.Applications();
   }
    
  
    
    public TwilioSMSParser SendSMS(String frm, String to, String body, Map<string,string> params) {
        return account.SendSMS(frm, to, body, params);
    }
    
    public TwilioCallParser MakeCall(String frm, String to, Map<string,string> params){
        return account.MakeCall(frm, to, params);
    }
    
    public List<TwilioOutgoingCallerId> OutgoingCallerIds() {
        return account.OutgoingCallerIds();
    }
    
    public List<TwilioCall> Calls() {
        return account.Calls(null);
    }

}