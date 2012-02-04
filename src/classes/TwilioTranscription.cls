/**
 * The Class Transcription.
 * 
 * For more information see {@see <a href='http://www.twilio.com/docs/api/rest/transcription'>http://www.twilio.com/docs/api/rest/transcription}
 */
global class TwilioTranscription extends TwilioResource.InstanceResource {
	
	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';

	/**
	 * Instantiates a new transcription.
	 *
	 * @param client the client
	 */
	public TwilioTranscription(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new transcription.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioTranscription(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new transcription.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioTranscription(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Transcriptions/'
				+ this.getSid() + '.json';
	}

	/*
	 * Property getters
	 */
	/**
	 * Gets the sid.
	 *
	 * @return the sid
	 */
	public String getSid() {
		return this.getProperty(SID_PROPERTY);
	}

	/**
	 * Gets the date created.
	 *
	 * @return the date created
	 */
	public Datetime getDateCreated() {
		return this.getPropertyDatetime('date_created');
	}

	/**
	 * Gets the date updated.
	 *
	 * @return the date updated
	 */
	public Datetime getDateUpdated() {
		return this.getPropertyDatetime('date_updated');
	}

	/**
	 * Gets the account sid.
	 *
	 * @return the account sid
	 */
	public String getAccountSid() {
		return this.getProperty('account_sid');
	}

	/**
	 * Gets the status.
	 *
	 * @return the status
	 */
	public String getStatus() {
		return this.getProperty('status');
	}

	/**
	 * Gets the recording sid.
	 *
	 * @return the recording sid
	 */
	public String getRecordingSid() {
		return this.getProperty('recording_sid');
	}

	/**
	 * Gets the duration.
	 *
	 * @return the duration
	 */
	public Integer getDuration() {
		return this.getPropertyInteger('duration');
	}

	/**
	 * Gets the price.
	 *
	 * @return the price
	 */
	public String getPrice() {
		return this.getProperty('price');
	}

	/**
	 * Gets the transcription text.
	 *
	 * @return the transcription text
	 */
	public String getTranscriptionText() {
		return this.getProperty('transcription_text');
	}
}