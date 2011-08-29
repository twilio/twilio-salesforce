/**
@ name        : TwilioSMSListParser
@ author      : Aslam Bari (http://www.aslambari.com/contactme.html)
@ email		  : aslam.bari@gmail.com
@ date        : 24 Aug, 2011
@ description : Parser for Call List Resource Twilio API
*/
public class TwilioSMSListParser {
  
  private TwilioSMS TwilioSMS { get; set; }
  private integer CalloutCounter = 1;
  public List<TwilioSMS> listAllSMS {get;set;}
  public TwilioSMSListParser(){
  }
  public TwilioSMSListParser(RestResponse response, RestClient client, String accSid, Map<string,string> params) {
    if(response != null)
        parse(response.responseBody, client, accSid, params);    
  }
  public void parse(String response, RestClient client, String accSid, Map<string,string> params){
    listAllSMS = new List<TwilioSMS>();

    while(true){        
        string text = response.replace('{"sms_messages":[', '');
        list<string> accTokens = text.split('},');
        for(integer i = 0; i < accTokens.size() - 1; i++){
            string eachAcc = accTokens[i]; 
            parseCallRecord(eachAcc + '}');            
        }
        string lastToken = accTokens[accTokens.size() - 1];
        parseCallRecord(lastToken);
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
            response = client.request('/Accounts/' + accSid + '/SMS/Messages.json', 'GET', params).responseBody;
        else
            break;
    }
  } 
  private void parseCallRecord(String accRecordJson){
    this.TwilioSMS = new TwilioSMS();
        this.TwilioSMS.sid = getValue(accRecordJson,'"sid":');
        this.TwilioSMS.date_sent = getValue(accRecordJson,'"date_sent":');
        this.TwilioSMS.status = getValue(accRecordJson,'"status":');
        this.TwilioSMS.date_created = getValue(accRecordJson,'"date_created":');
        this.TwilioSMS.date_updated = getValue(accRecordJson,'"date_updated":');
        this.TwilioSMS.uri = getValue(accRecordJson,'"uri":');
        this.TwilioSMS.body = getValue(accRecordJson,'"body":');
        this.TwilioSMS.account_sid = getValue(accRecordJson,'"account_sid":');
        this.TwilioSMS.to = getValue(accRecordJson,'"to":');
        this.TwilioSMS.frm = getValue(accRecordJson,'"from":');
        this.TwilioSMS.direction = getValue(accRecordJson,'"direction":');
        this.TwilioSMS.price = getValue(accRecordJson,'"price":');
        this.TwilioSMS.api_version = getValue(accRecordJson,'"api_version":');
        
    	listAllSMS.add(this.TwilioSMS);
    
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