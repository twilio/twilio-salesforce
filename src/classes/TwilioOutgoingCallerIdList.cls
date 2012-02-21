/**
 * The class TwilioOutgoingCallerIdList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/outgoing-caller-ids
 */
global class TwilioOutgoingCallerIdList extends TwilioResource.ListResource
		 {

	/**
	 * Instantiates a new outgoing caller id list.
	 *
	 * @param client the client
	 */
	public TwilioOutgoingCallerIdList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new outgoing caller id list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioOutgoingCallerIdList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/OutgoingCallerIds.json';
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient, java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioOutgoingCallerId(client, params);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'outgoing_caller_ids';
	}
	
	public TwilioCallerIdValidation create(Map<String,String> params) {
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', params);
		return new TwilioCallerIdValidation(response);
	}
	
	/* returns the current response results page */
	public List<TwilioOutgoingCallerId> getPageData() {
		List<TwilioOutgoingCallerId> returnList = new List<TwilioOutgoingCallerId>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioOutgoingCallerId) {
				returnList.add((TwilioOutgoingCallerId) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioOutgoingCallerId> iterator() {
		return new TwilioIterator.OutgoingCallerIdIterator(this);
	}
	
	/* convenience methods */
	public TwilioCallerIdValidation validate(String phoneNumber) {
		Map<String,String> params = new Map<String,String> {
			'PhoneNumber' => phoneNumber
		};
		return create(params);
	}
}