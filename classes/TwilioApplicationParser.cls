public class TwilioApplicationParser {
	
	public List<TwilioApplication> applications { get; set; }
	
	public TwilioApplicationParser(RestResponse response) {
		if (response != null) {
			JSONObject json = new JSONObject(response.responseBody);
			list<JSONObject.value> applicationList = json.getValue('applications').values;
			this.applications = new List<TwilioApplication>();
			
			for (JSONObject.value v : applicationList) {
				TwilioApplication a = new TwilioApplication();
				a.sid = v.obj.getValue('sid').valueToString();
				a.date_created = v.obj.getValue('date_created').valueToString();
				a.date_updated = v.obj.getValue('date_updated').valueToString();
				a.account_sid = v.obj.getValue('account_sid').valueToString();
				a.api_version = v.obj.getValue('api_version').valueToString();
				a.voice_url = v.obj.getValue('voice_url').valueToString();
				a.voice_method = v.obj.getValue('voice_method').valueToString();
				a.voice_fallback_url = v.obj.getValue('voice_fallback_url').valueToString();
				a.voice_fallback_method = v.obj.getValue('voice_fallback_method').valueToString();
				a.status_callback = v.obj.getValue('status_callback').valueToString();
				a.status_callback_method = v.obj.getValue('status_callback_method').valueToString();
				a.voice_caller_id_lookup = v.obj.getValue('voice_caller_id_lookup').valueToString();
				a.sms_url = v.obj.getValue('sms_url').valueToString();
				a.sms_method = v.obj.getValue('sidsms_method').valueToString();
				a.sms_fallback_url = v.obj.getValue('sms_fallback_url').valueToString();
				a.sms_fallback_method = v.obj.getValue('sms_fallback_method').valueToString();
				a.sms_status_callback = v.obj.getValue('sms_status_callback').valueToString();
				a.uri = v.obj.getValue('uri').valueToString();
				this.applications.add(a);
			}
		}	
	}
	
	public class TwilioApplication {
		public String sid { get; set; }
		public String date_created { get; set; }
		public String date_updated { get; set; }
		public String account_sid { get; set; }
		public String api_version  { get; set; }
		public String voice_url  { get; set; }
		public String voice_method  { get; set; }
		public String voice_fallback_url  { get; set; }
		public String voice_fallback_method  { get; set; }
		public String status_callback  { get; set; }
		public String status_callback_method  { get; set; }
		public String voice_caller_id_lookup  { get; set; }
		public String sms_url  { get; set; }
		public String sms_method  { get; set; }
		public String sms_fallback_url  { get; set; }
		public String sms_fallback_method  { get; set; }
		public String sms_status_callback  { get; set; }
		public String uri  { get; set; }
	}
}