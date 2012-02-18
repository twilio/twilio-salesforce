/**
 * The Class TwilioRecordingList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/recording
 */
global class TwilioRecordingList extends TwilioResource.ListResource
	implements Iterable<TwilioRecording> {

	private String parentCallSid;

	/**
	 * Instantiates a new recording list.
	 *
	 * @param client the client
	 */
	public TwilioRecordingList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new recording list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioRecordingList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}
	
	/**
	 * Instantiates a new recording list under a Call resource.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioRecordingList(TwilioRestClient client, String parentCallSid) {
		super(client);
		this.parentCallSid = parentCallSid;
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid()				
				+ (this.parentCallSid!=null ? ('/Calls/'+this.parentCallSid) : '')
				+ '/Recordings.json';
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient, java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioRecording(client, params);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'recordings';
	}
	
	/* returns the current response results page */
	public List<TwilioRecording> getPageData() {
		List<TwilioRecording> returnList = new List<TwilioRecording>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioRecording) {
				returnList.add((TwilioRecording) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioRecording> iterator() {
		return new TwilioIterator.RecordingIterator(this);
	}
}