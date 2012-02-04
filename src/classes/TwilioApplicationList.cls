/**
 * The Class ApplicationList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/applications
 */
global class TwilioApplicationList extends TwilioResource.ListResource
		implements Iterable<TwilioApplication> {

	/**
	 * Instantiates a new application list.
	 *
	 * @param client the client
	 */
	public TwilioApplicationList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new application list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioApplicationList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Applications.json';
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient, java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioApplication(client, params);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'applications';
	}

	public TwilioApplication createApplication(Map<String, String> params) {
		return (TwilioApplication)this.create(params);
	}
	
	public List<TwilioApplication> getPageData() {
		List<TwilioApplication> returnList = new List<TwilioApplication>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioApplication) {
				returnList.add((TwilioApplication) o);
			}
		}
		return returnList;
	}
	
	global Iterator<TwilioApplication> iterator() {
		return new TwilioIterator.ApplicationIterator(this);
	}
}