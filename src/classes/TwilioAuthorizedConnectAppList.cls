/**
 * The ConnectApps list resource shows all of the Connect Apps that you have
 * authorized within your Twilio account. The instance resource shows you the
 * permissions you have authorized for a single Connect App as well as
 * information about the Connect App itself.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/authorized-connect-apps
 */
global class TwilioAuthorizedConnectAppList extends TwilioResource.ListResource
	implements Iterable<TwilioAuthorizedConnectApp> {

	/**
	 * Instantiates a new AuthorizedConnectApp list.
	 * 
	 * @param client
	 *            the client
	 */
	public TwilioAuthorizedConnectAppList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new AuthorizedConnectApp list.
	 * 
	 * @param client
	 *            the client
	 * @param filters
	 *            the filters
	 */
	public TwilioAuthorizedConnectAppList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/AuthorizedConnectApps.json';
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient
	 * , java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioAuthorizedConnectApp(client, params);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'authorized_connect_apps';
	}
	
	public TwilioAuthorizedConnectApp createAuthorizedConnectApp(Map<String, String> params) {
		return (TwilioAuthorizedConnectApp)this.create(params);
	}
	
	/* returns the current response results page */
	public List<TwilioAuthorizedConnectApp> getPageData() {
		List<TwilioAuthorizedConnectApp> returnList = new List<TwilioAuthorizedConnectApp>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioAuthorizedConnectApp) {
				returnList.add((TwilioAuthorizedConnectApp) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioAuthorizedConnectApp> iterator() {
		return new TwilioIterator.AuthorizedConnectAppIterator(this);
	}

}