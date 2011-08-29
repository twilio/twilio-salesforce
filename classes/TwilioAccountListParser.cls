/**
@ name        : TwilioAccountListParser
@ author      : Aslam Bari (http://www.aslambari.com/contactme.html)
@ email		  : aslam.bari@gmail.com
@ date        : 24 Aug, 2011
@ description : Parser for Account List Resource Twilio API
*/
public class TwilioAccountListParser {
  
  private TwilioAccount twilioAccount { get; set; }
  private integer CalloutCounter = 1;
  public List<TwilioAccount> listAllAccounts {get;set;}
  public TwilioAccountListParser(){
  }
  public TwilioAccountListParser(RestResponse response, RestClient client, Map<string,string> params) {
    if(response != null)
        parse(response.responseBody, client, params);    
  }
  public void parse(String response, RestClient client, Map<string,string> params){
    listAllAccounts = new List<TwilioAccount>();

    while(true){        
        string text = response.replace('{"accounts":[', '');
        list<string> accTokens = text.split('},');
        for(integer i = 0; i < accTokens.size() - 1; i++){
            string eachAcc = accTokens[i];
            parseAccount(eachAcc + '}');            
        }
        string lastToken = accTokens[accTokens.size() - 1];
        parseAccount(lastToken);
        integer currentPageNum = Integer.valueOf(getNumValue(lastToken, '"page":'));
        integer endRecords = Integer.valueOf(getNumValue(lastToken, '"end":'));
        integer totalRecords = Integer.valueOf(getNumValue(lastToken, '"total":'));
        if((endRecords + 1) >= totalRecords || (CalloutCounter >= 10)){
            break;
        }
        CalloutCounter++;
        currentPageNum = currentPageNum + 1;
        if(params == null)
            params = new Map<string,string>();
        params.put('Page',currentPageNum + '');
        params.put('PageSize','50');
        if(!Test.IsRunningTest())
            response = client.request('/Accounts/' + '.json', 'GET', params).responseBody;
        else
            break;
    }
  }
  private void parseAccount(String accRecordJson){
    this.twilioAccount = new TwilioAccount();
    this.twilioAccount.sid = getValue(accRecordJson,'"sid":');
    this.twilioAccount.friendly_name = getValue(accRecordJson,'"friendly_name":');
    this.twilioAccount.status = getValue(accRecordJson,'"status":');
    this.twilioAccount.date_created = getValue(accRecordJson,'"date_created":');
    this.twilioAccount.date_updated = getValue(accRecordJson,'"date_updated":');
    this.twilioAccount.auth_token = getValue(accRecordJson,'"auth_token":');
    this.twilioAccount.accountType = getValue(accRecordJson,'"type":');
    this.twilioAccount.uri = getValue(accRecordJson,'"uri":');

    for (string key : SubresourceKeys) {
      TwilioAccountResourceUri u = new TwilioAccountResourceUri(key, getValue(accRecordJson, '"' + key + '":'));
      this.twilioAccount.subresource_uris.add(u);
    }
    
    listAllAccounts.add(this.twilioAccount);
    
  }
  
  private string getValue(string accRecordJson, string fieldName){
    integer startIdx = accRecordJson.indexOf(fieldName);
    integer endIdx = -1;
    if(startIdx > 0){
        endIdx = accRecordJson.indexOf('",', startIdx);
    }
    if(startIdx > 0 && endIdx > startIdx){
        
        return accRecordJson.substring(startIdx + fieldName.length() + 1,endIdx);
    }
    return '';
  }
  
  private string getNumValue(string accRecordJson, string fieldName){
    integer startIdx = accRecordJson.indexOf(fieldName);
    integer endIdx = -1;
    if(startIdx > 0){
        endIdx = accRecordJson.indexOf(',"', startIdx);
    }
    if(startIdx > 0 && endIdx > startIdx){
        //system.debug('### ' +startIdx + '---' + endIdx);
        return accRecordJson.substring(startIdx + fieldName.length(),endIdx);
    }
    return '';
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
  
  private Set<string> SubresourceKeys = new Set<string>{
       'available_phone_numbers',
       'calls',
       'conferences',
       'incoming_phone_numbers',
       'notifications',
       'outgoing_caller_ids',
       'recordings',
       'sandbox',
       'sms_messages',
       'transcriptions'       
   };
}