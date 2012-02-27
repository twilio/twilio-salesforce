/*
Copyright (c) 2012 Twilio, Inc.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
/**
 * The class TwilioApplication.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/applications
 */
global class TwilioApplication extends TwilioResource.InstanceResource {
	
	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';
	
	/** The Constant DATE_UPDATED_PROPERTY. */
	private static final String DATE_UPDATED_PROPERTY = 'date_updated';
	
	/** The Constant DATE_CREATED_PROPERTY. */
	private static final String DATE_CREATED_PROPERTY = 'date_created';
	
	/** The Constant STATUS_PROPERTY. */
	private static final String STATUS_PROPERTY = 'status';
	
	/** The Constant FRIENDLY_NAME_PROPERTY. */
	private static final String FRIENDLY_NAME_PROPERTY = 'friendly_name';

	/**
	 * Instantiates a new application.
	 *
	 * @param client the client
	 */
	public TwilioApplication(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new application.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioApplication(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new application.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioApplication(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/*
	 * see TwilioResource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Applications/' + this.getSid() + '.json';
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
	 * Gets the friendly name.
	 *
	 * @return the friendly name
	 */
	public String getFriendlyName() {
		return this.getProperty(FRIENDLY_NAME_PROPERTY);
	}
	
	/**
	 * Gets the status.
	 *
	 * @return the status
	 */
	public String getStatus() {
		return this.getProperty(STATUS_PROPERTY);
	}
	
	/* DateCreated field accessor */
	public Datetime getDateCreated() {
		return this.getPropertyDatetime(DATE_CREATED_PROPERTY);
	}

	/* DateUpdated field accessor */
	public Datetime getDateUpdated() {
		return this.getPropertyDatetime(DATE_UPDATED_PROPERTY);
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
		return this.getProperty('sms_method_url');
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
	
	/**
	 * Gets the Twilio URI for this resource.
	 *
	 * @return the resource URI
	 */
	public String getUri() {
		return this.getProperty('uri');
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