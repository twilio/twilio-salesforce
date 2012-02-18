/**
 * The ConnectApps list resource shows all of the Connect Apps that you have
 * created within your Twilio account. The instance resource shows you the
 * permissions you are requesting for a single Connect App as well as
 * information about the Connect App itself.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/connect-apps
 */
global class TwilioConnectAppList extends TwilioResource.ListResource
	implements Iterable<TwilioConnectApp> {

	/**
	 * Instantiates a new ConnectApp list.
	 * 
	 * @param client
	 *            the client
	 */
	public TwilioConnectAppList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new ConnectApp list.
	 * 
	 * @param client
	 *            the client
	 * @param filters
	 *            the filters
	 */
	public TwilioConnectAppList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/ConnectApps.json';
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
		return new TwilioConnectApp(client, params);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'connect_apps';
	}
	
	/* returns the current response results page */
	public List<TwilioConnectApp> getPageData() {
		List<TwilioConnectApp> returnList = new List<TwilioConnectApp>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioConnectApp) {
				returnList.add((TwilioConnectApp) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioConnectApp> iterator() {
		return new TwilioIterator.ConnectAppIterator(this);
	}

}