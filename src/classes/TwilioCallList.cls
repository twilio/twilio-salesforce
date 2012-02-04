/**
 * The class TwilioCallList
 * 
 *  For more information see see http://www.twilio.com/docs/api/rest/call
 */
global class TwilioCallList extends TwilioResource.ListResource
	implements Iterable<TwilioCall> {  
	
	/**
	 * Instantiates a new call list.
	 *
	 * @param client the client
	 */
	public TwilioCallList(TwilioRestClient client) {
		super(client);
	}
	
	/**
	 * Instantiates a new call list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioCallList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Calls.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioCall(client, params);
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'calls';
	}
	
	public TwilioCall createCall(Map<String, String> params) {
		return (TwilioCall)this.create(params);
	}
	
	/* returns the current response results page */
	public List<TwilioCall> getPageData() {
		List<TwilioCall> returnList = new List<TwilioCall>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioCall) {
				returnList.add((TwilioCall) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioCall> iterator() {
		return new TwilioIterator.CallIterator(this);
	}
}