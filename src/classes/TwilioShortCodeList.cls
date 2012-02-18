/**
 * The class TwilioShortCodeList
 * 
 * For more information see http://www.twilio.com/docs/api/rest/shortcodes
 */
global class TwilioShortCodeList extends TwilioResource.ListResource 
	implements Iterable<TwilioShortCode> {

	/**
	 * Instantiates a new incoming phone number list.
	 *
	 * @param client the client
	 */
	public TwilioShortCodeList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new incoming phone number list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioShortCodeList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/ShortCodes.json';
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient, java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioShortCode(client, params);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'short_codes';
	}
	
	/* returns the current response results page */
	public List<TwilioShortCode> getPageData() {
		List<TwilioShortCode> returnList = new List<TwilioShortCode>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioShortCode) {
				returnList.add((TwilioShortCode) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioShortCode> iterator() {
		return new TwilioIterator.ShortCodeIterator(this);
	}
	
}