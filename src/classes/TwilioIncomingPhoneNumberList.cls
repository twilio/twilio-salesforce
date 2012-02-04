/**
 * The class TwilioIncomingPhoneNumberList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/incoming-phone-numbers
 */
global class TwilioIncomingPhoneNumberList extends TwilioResource.ListResource
		implements Iterable<TwilioIncomingPhoneNumber> {

	/**
	 * Instantiates a new incoming phone number list.
	 *
	 * @param client the client
	 */
	public TwilioIncomingPhoneNumberList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new incoming phone number list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioIncomingPhoneNumberList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/IncomingPhoneNumbers.json';
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient, java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioIncomingPhoneNumber(client, params);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'incoming_phone_numbers';
	}
	
	public TwilioIncomingPhoneNumber createIncomingPhoneNumber(Map<String, String> params) {
		return (TwilioIncomingPhoneNumber)this.create(params);
	}
	
	public List<TwilioIncomingPhoneNumber> getPageData() {
		List<TwilioIncomingPhoneNumber> returnList = new List<TwilioIncomingPhoneNumber>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioIncomingPhoneNumber) {
				returnList.add((TwilioIncomingPhoneNumber) o);
			}
		}
		return returnList;
	}
	
	global Iterator<TwilioIncomingPhoneNumber> iterator() {
		return new TwilioIterator.IncomingPhoneNumberIterator(this);
	}
}