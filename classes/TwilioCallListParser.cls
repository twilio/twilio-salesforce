/**
@ name        : TwilioCallListParser
@ author      : Aslam Bari (http://www.aslambari.com/contactme.html)
@ email		  : aslam.bari@gmail.com
@ date        : 24 Aug, 2011
@ description : Parser for Call List Resource Twilio API
*/
public class TwilioCallListParser {
  
  private twilioCall twilioCall { get; set; }
  private integer CalloutCounter = 1;
  public List<twilioCall> listAllCalls {get;set;}
  public TwilioCallListParser(){
  }
  public TwilioCallListParser(RestResponse response, RestClient client, String accSid, Map<string,string> params) {
    if(response != null)
        parse(response.responseBody, client, accSid, params);    
  }
  public void parse(String response, RestClient client, String accSid, Map<string,string> params){
    listAllCalls = new List<twilioCall>();

    while(true){        
        string text = response.replace('{"calls":[', '');
        list<string> accTokens = text.split('},');
        for(integer i = 0; i < accTokens.size() - 1; i++){
            string eachAcc = accTokens[i]; 
            parseCallRecord(eachAcc + '}');            
        }
        string lastToken = accTokens[accTokens.size() - 1];
        parseCallRecord(lastToken + '}');
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
            response = client.request('/Accounts/' + accSid + '/Calls.json', 'GET', params).responseBody;
        else
            break;
    }
  } 
  private void parseCallRecord(String accRecordJson){
    this.twilioCall = new TwilioCall();
        this.twilioCall.sid = getValue(accRecordJson,'"sid":');
        this.twilioCall.status = getValue(accRecordJson,'"status":');
        this.twilioCall.date_created = getValue(accRecordJson,'"date_created":');
        this.twilioCall.date_updated = getValue(accRecordJson,'"date_updated":');
        this.twilioCall.uri = getValue(accRecordJson,'"uri":');
        this.twilioCall.parent_call_sid = getValue(accRecordJson,'"parent_call_sid":');
        this.twilioCall.account_sid = getValue(accRecordJson,'"account_sid":');
        this.twilioCall.to = getValue(accRecordJson,'"to":');
        this.twilioCall.to_formatted = getValue(accRecordJson,'"to_formatted":');
        this.twilioCall.frm = getValue(accRecordJson,'"from":');
        this.twilioCall.phone_number_sid = getValue(accRecordJson,'"phone_number_sid":');
        this.twilioCall.frm_formatted = getValue(accRecordJson,'"from_formatted":');
        this.twilioCall.start_time = getValue(accRecordJson,'"start_time":');
        this.twilioCall.end_time = getValue(accRecordJson,'"end_time":');
        this.twilioCall.duration = getValue(accRecordJson,'"duration":');
        this.twilioCall.price = getValue(accRecordJson,'"price":');
        this.twilioCall.api_version = getValue(accRecordJson,'"api_version":');
        this.twilioCall.answered_by = getValue(accRecordJson,'"answered_by":');
        this.twilioCall.annotation = getValue(accRecordJson,'"annotation":');
        this.twilioCall.forwarded_from = getValue(accRecordJson,'"forwarded_from":');
        this.twilioCall.group_sid = getValue(accRecordJson,'"group_sid":');
        this.twilioCall.caller_name = getValue(accRecordJson,'"caller_name":');
        
        
        for (string key : SubresourceKeys) {
	      TwilioCallResourceUri u = new TwilioCallResourceUri(key, getValue(accRecordJson, '"' + key + '":'));
	      this.twilioCall.subresource_uris.add(u);
	    }
        
    	listAllCalls.add(this.twilioCall);
    
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
  
  public class TwilioCallResourceUri {
    public String resource { get; set; }
    public String uri { get; set; }
    
    public TwilioCallResourceUri(String resource, String uri) {
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