/**
 * The class TwilioSmsList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/sms
 */
global class TwilioSmsList extends TwilioResource.ListResource implements Iterable<TwilioSms> {
	
	/**
	 * Instantiates a new sms list.
	 *
	 * @param client the client
	 */
	public TwilioSmsList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new sms list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioSmsList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/SMS/Messages.json';
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient, java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client, Map<String, Object> params) {
		return new TwilioSms(client, params);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'sms_messages';
	}
	
	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.factory.SmsFactory#create(java.util.Map)
	 */
	public TwilioSms createSms(Map<String, String> params) {
		return (TwilioSms)this.create(params);
	}
	
	public List<TwilioSms> getPageData() {
		List<TwilioSms> returnList = new List<TwilioSms>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioSms) {
				returnList.add((TwilioSms) o);
			}
		}
		return returnList;
	}
	
	global Iterator<TwilioSms> iterator() {
		return new TwilioIterator.SmsIterator(this);
	}

}