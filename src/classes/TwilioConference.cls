/**
 * The class TwilioConference.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/conference
 */
global class TwilioConference extends TwilioResource.InstanceResource {
	
	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';

	/**
	 * Instantiates a new conference.
	 *
	 * @param client the client
	 */
	public TwilioConference(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new conference.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioConference(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new conference.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioConference(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Conferences/' + this.getSid() + '.json';
	}
	
	/**
	 * Gets the api version.
	 *
	 * @return the api version
	 */
	public String getApiVersion() {
		return this.getProperty('api_version');
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
	
	/* DateCreated field accessor */
	public Datetime getDateCreated() {
		return this.getPropertyDatetime('date_created');
	}

	/* DateUpdated field accessor */
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
	 * Gets the friendly name.
	 *
	 * @return the friendly name
	 */
	public String getFriendlyName() {
		return this.getProperty('friendly_name');
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
	 * Get the participant list
	 * 
	 * @return
	 */
	public TwilioParticipantList getParticipants() {
		TwilioParticipantList twlist = new TwilioParticipantList(this.getClient(), this.getSid());
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}
}