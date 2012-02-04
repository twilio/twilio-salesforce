/**
 * The class TwilioSms.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/sms
 */
global class TwilioSms extends TwilioResource.InstanceResource {
	
	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';

	/**
	 * Instantiates a new sms.
	 *
	 * @param client the client
	 */
	public TwilioSms(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new sms.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioSms(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new sms.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioSms(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/SMS/Messages/' + this.getSid() + '.json';
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
	
	/* DateUpdated field accessor */
	public Datetime getDateSent() {
		return this.getPropertyDatetime('date_sent');
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
	 * Gets the to.
	 *
	 * @return the to
	 */
	public String getTo() {
		return this.getProperty('to');
	}

	/**
	 * Gets the from.
	 *
	 * @return the from
	 */
	public String getFrom() {
		return this.getProperty('from');
	}
	
	/**
	 * Gets the body.
	 *
	 * @return the body
	 */
	public String getBody() {
		return this.getProperty('body');
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
	 * Gets the price.
	 *
	 * @return the price
	 */
	public String getPrice() {
		return this.getProperty('price');
	}

	/**
	 * Gets the direction.
	 *
	 * @return the direction
	 */
	public String getDirection() {
		return this.getProperty('direction');
	}
	
	/**
	 * Gets the api version.
	 *
	 * @return the api version
	 */
	public String getApiVersion() {
		return this.getProperty('api_version');
	}

}