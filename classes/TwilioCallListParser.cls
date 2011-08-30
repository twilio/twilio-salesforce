public class TwilioCallListParser extends TwilioCall {
  
  private twilioCall twilioCall { get; set; }
  private integer CalloutCounter = 1;
  public List<twilioCall> listAllCalls {get;set;}
  public TwilioCallListParser(){
  }
  public TwilioCallListParser(RestClient client, String requestAccountSid, Map<string,string> params) {
    setRequestAccountSid(requestAccountSid);
    RestResponse response = client.request('/Accounts/' + getRequestAccountSid() + '/Calls.json', 'GET', null);
    if(response != null)
        parse(response.responseBody, client, params);    
  }
  
  public void parse(String response, RestClient client, Map<string,string> params){
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
        /*
        if(!Test.IsRunningTest())
            response = client.request('/Accounts/' + accSid + '/Calls.json', 'GET', params).responseBody;
        else
            break;
        */
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

}