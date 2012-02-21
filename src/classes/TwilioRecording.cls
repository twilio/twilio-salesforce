/**
 * The class TwilioRecording.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/recording
 */
global class TwilioRecording extends TwilioResource.InstanceResource {
	
	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';

	/**
	 * Instantiates a new recording.
	 *
	 * @param client the client
	 */
	public TwilioRecording(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new recording.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioRecording(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new recording.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioRecording(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return this.getResourceLocation('.json');
	}

	/**
	 * Gets the resource location.
	 *
	 * @param extension the extension
	 * @return the resource location
	 */
	public String getResourceLocation(String extension) {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Recordings/' + this.getSid()
				+ extension;
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
	 * Gets the call sid.
	 *
	 * @return the call sid
	 */
	public String getCallSid() {
		return this.getProperty('call_sid');
	}

	/**
	 * Gets the duration.
	 *
	 * @return the duration
	 */
	public Integer getDuration() {
		return Integer.valueOf(this.getProperty('duration'));
	}

	/**
	 * Gets the api version.
	 *
	 * @return the api version
	 */
	public String getApiVersion() {
		return this.getProperty('api_version');
	}
	
	public String getWavUri() {
		return getResourceLocation('.wav');
	}
	
	public String getMp3Uri() {
		return getResourceLocation('.mp3');
	}
	
	public TwilioTranscriptionList getTranscriptions() {
		TwilioTranscriptionList twlist = new TwilioTranscriptionList(this.getClient(), this.getSid());
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}

	/**
	 * Delete.
	 *
	 * @return true, if successful
	 * @throws TwilioRestException the twilio rest exception
	 */
	public boolean deleteResource() {
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'DELETE', null);

		return !response.isError();
	}
}