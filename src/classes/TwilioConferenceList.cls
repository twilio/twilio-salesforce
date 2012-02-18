/**
 * The class TwilioConferenceList.
 * 
 *  For more information see http://www.twilio.com/docs/api/rest/conference
 */
global class TwilioConferenceList extends TwilioResource.ListResource
	implements Iterable<TwilioConference> {

	/**
	 * Instantiates a new conference list.
	 *
	 * @param client the client
	 */
	public TwilioConferenceList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new conference list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioConferenceList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Conferences.json';
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient, java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioConference(client, params);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'conferences';
	}
	
	public List<TwilioConference> getPageData() {
		List<TwilioConference> returnList = new List<TwilioConference>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioConference) {
				returnList.add((TwilioConference) o);
			}
		}
		return returnList;
	}
	
	global Iterator<TwilioConference> iterator() {
		return new TwilioIterator.ConferenceIterator(this);
	}
}