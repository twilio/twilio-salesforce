public virtual class TwilioCall extends TwilioResource {

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
    	super();
        this.subresource_uris = new List<twilioCallResourceUri>();
        // defaults? 
    }
    
	 public class TwilioCallResourceUri {
	    public String resource { get; set; }
	    public String uri { get; set; }
	    
	    public TwilioCallResourceUri(String resource, String uri) {
	      this.resource = resource;
	      this.uri = uri;
	    }
	  }
	  
	  protected Set<string> SubresourceKeys = new Set<string>{
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