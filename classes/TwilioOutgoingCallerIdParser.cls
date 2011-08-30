public class TwilioOutgoingCallerIdParser extends TwilioResource {
		
	public List<TwilioOutgoingCallerId> outgoingCallerIds { get; set; }
	
	public TwilioOutgoingCallerIdParser(RestClient client, String requestAccountSid) {
		setRequestAccountSid(requestAccountSid);
    	RestResponse response = client.request('/Accounts/' + getRequestAccountSid() + '/OutgoingCallerIds.json', 'GET', null);
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
}