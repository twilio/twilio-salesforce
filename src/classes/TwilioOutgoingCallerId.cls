/**
 * The class TwilioOutgoingCallerId.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/outgoing-caller-ids
 */
global class TwilioOutgoingCallerId extends TwilioResource.InstanceResource {
	
	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';

	/**
	 * Instantiates a new outgoing caller id.
	 *
	 * @param client the client
	 */
	public TwilioOutgoingCallerId(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new outgoing caller id.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioOutgoingCallerId(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new outgoing caller id.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioOutgoingCallerId(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/OutgoingCallerIds/' + this.getSid() + '.json';
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
	 * Gets the friendly name.
	 *
	 * @return the friendly name
	 */
	public String getFriendlyName() {
		return this.getProperty('friendly_name');
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
	 * Gets the phone number.
	 *
	 * @return the phone number
	 */
	public String getPhoneNumber() {
		return this.getProperty('phone_number');
	}
	
	/**
	 * Gets the validation code.
	 * use when adding outgoing callerid
	 * @return the validation code
	 */
	public String getValidationCode() {
		return this.getProperty('validation_code');
	}
	
		/**
	 * Delete.
	 *
	 * @return true, if successful
	 * @throws TwilioRestException the twilio rest exception
	 */
	public boolean deleteOutgoingCallerid() {
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'DELETE', null);

		return !response.isError();
	}
}