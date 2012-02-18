/**
 * The class TwilioTranscriptionList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/transcription
 */
global class TwilioTranscriptionList extends TwilioResource.ListResource
	implements Iterable<TwilioTranscription> {

	/**
	 * Instantiates a new transcription list.
	 *
	 * @param client the client
	 */
	public TwilioTranscriptionList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new transcription list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioTranscriptionList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Transcriptions.json';
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#makeNew(com.twilio.sdk.TwilioRestClient, java.util.Map)
	 */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioTranscription(client, params);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'transcriptions';
	}
	
	/* returns the current response results page */
	public List<TwilioTranscription> getPageData() {
		List<TwilioTranscription> returnList = new List<TwilioTranscription>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioTranscription) {
				returnList.add((TwilioTranscription) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioTranscription> iterator() {
		return new TwilioIterator.TranscriptionIterator(this);
	}
}