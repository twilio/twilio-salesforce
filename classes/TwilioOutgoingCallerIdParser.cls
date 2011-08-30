public class TwilioOutgoingCallerIdParser {
		
	public List<TwilioOutgoingCallerId> outgoingCallerIds { get; set; }
	
	public TwilioOutgoingCallerIdParser(RestClient client) {
		RestResponse response = client.request('/Accounts/' + client.username + '/OutgoingCallerIds.json', 'GET', null);
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