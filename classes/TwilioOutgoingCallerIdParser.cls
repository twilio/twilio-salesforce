public class TwilioOutgoingCallerIdParser {
		
	public List<TwilioOutgoingCallerId> outgoingCallerIds { get; set; }
	
	public TwilioOutgoingCallerIdParser(RestResponse response) {
		if (response != null) {
			JSONObject json = new JSONObject(response.responseBody);
			List<JSONObject.value> callerIds = json.getValue('outgoing_caller_ids').values;
			this.outgoingCallerIds = new List<TwilioOutgoingCallerId>();
			
			for (JSONObject.value v : callerIds) {
				TwilioOutgoingCallerId n = new TwilioOutgoingCallerId();
				this.outgoingCallerIds.add(n);
			}
		}
	}
	
	public class TwilioOutgoingCallerId {
		public String sid { get; set; }
		public String account_sid { get; set; }
		public String friendly_name { get; set; }
		public String phone_number { get; set; }
		public String date_created { get; set; }
		public String date_updated { get; set; }
		public String uri { get; set; }
		
		public TwilioOutgoingCallerId() {
			// do nothing yet
		}
	}
}