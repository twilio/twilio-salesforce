/**
 * The class TwilioIncomingPhoneNumber.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/incoming-phone-numbers
 */
global class TwilioIncomingPhoneNumber extends TwilioResource.InstanceResource {

	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';

	/**
	 * Instantiates a new incoming phone number.
	 * 
	 * @param client
	 *            the client
	 */
	public TwilioIncomingPhoneNumber(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new incoming phone number.
	 * 
	 * @param client
	 *            the client
	 * @param sid
	 *            the sid
	 */
	public TwilioIncomingPhoneNumber(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new incoming phone number.
	 * 
	 * @param client
	 *            the client
	 * @param properties
	 *            the properties
	 */
	public TwilioIncomingPhoneNumber(TwilioRestClient client,
			Map<String, Object> properties) {
		super(client, properties);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/IncomingPhoneNumbers/'
				+ this.getSid() + '.json';
	}

	/**
	 * Deprovision this IncomingPhoneNumber. This will remove it from your
	 * account.
	 * 
	 * @throws TwilioRestException
	 *             if there is an error in the request
	 * @return true, if successful
	 * 
	 */
	public boolean deleteIncomingPhoneNumber() {
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'DELETE', null);
		
		return !response.isError();
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
	 * Gets the voice applicaiton sid.
	 * 
	 * @return the voice applicaiton sid
	 */
	public String getVoiceApplicaitonSid() {
		return this.getProperty('voice_application_sid');
	}

	/**
	 * Gets the sms applicaiton sid.
	 * 
	 * @return the sms applicaiton sid
	 */
	public String getSmsApplicaitonSid() {
		return this.getProperty('sms_application_sid');
	}

	/**
	 * Gets the api version.
	 * 
	 * @return the api version
	 */
	public String getApiVersion() {
		return this.getProperty('api_version');
	}

	/**
	 * Gets the voice url.
	 * 
	 * @return the voice url
	 */
	public String getVoiceUrl() {
		return this.getProperty('voice_url');
	}

	/**
	 * Gets the voice method.
	 * 
	 * @return the voice method
	 */
	public String getVoiceMethod() {
		return this.getProperty('voice_method');
	}

	/**
	 * Gets the voice fallback url.
	 * 
	 * @return the voice fallback url
	 */
	public String getVoiceFallbackUrl() {
		return this.getProperty('voice_fallback_url');
	}

	/**
	 * Gets the voice fallback method.
	 * 
	 * @return the voice fallback method
	 */
	public String getVoiceFallbackMethod() {
		return this.getProperty('voice_fallback_method');
	}

	/**
	 * Gets the status callback.
	 * 
	 * @return the status callback
	 */
	public String getStatusCallback() {
		return this.getProperty('status_callback');
	}

	/**
	 * Gets the status callback method.
	 * 
	 * @return the status callback method
	 */
	public String getStatusCallbackMethod() {
		return this.getProperty('status_callback_method');
	}

	/**
	 * Gets the voice caller id lookup.
	 * 
	 * @return the voice caller id lookup
	 */
	public String getVoiceCallerIdLookup() {
		return this.getProperty('voice_caller_id_lookup');
	}

	/**
	 * Gets the sms url.
	 * 
	 * @return the sms url
	 */
	public String getSmsUrl() {
		return this.getProperty('sms_url');
	}

	/**
	 * Gets the sms method.
	 * 
	 * @return the sms method
	 */
	public String getSmsMethod() {
		return this.getProperty('sms_method');
	}

	/**
	 * Gets the sms fallback url.
	 * 
	 * @return the sms fallback url
	 */
	public String getSmsFallbackUrl() {
		return this.getProperty('sms_fallback_url');
	}

	/**
	 * Gets the sms fallback method.
	 * 
	 * @return the sms fallback method
	 */
	public String getSmsFallbackMethod() {
		return this.getProperty('sms_fallback_method');
	}

	/**
	 * Gets the sms status callback.
	 * 
	 * @return the sms status callback
	 */
	public String getSmsStatusCallback() {
		return this.getProperty('sms_status_callback');
	}
}