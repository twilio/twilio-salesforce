/**
 * The ConnectApps list resource shows all of the Connect Apps that you have
 * created within your Twilio account. The instance resource shows you the
 * permissions you are requesting for a single Connect App as well as
 * information about the Connect App itself.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/connect-apps
 */
global class TwilioConnectApp extends TwilioResource.InstanceResource {
	
	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';
	
	/** The Constant FRIENDLY_NAME_PROPERTY. */
	private static final String FRIENDLY_NAME_PROPERTY = 'friendly_name';

	/**
	 * Instantiates a new application.
	 *
	 * @param client the client
	 */
	public TwilioConnectApp(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new application.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioConnectApp(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new application.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioConnectApp(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/ConnectApps/' + this.getSid() + '.json';
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
	 * Gets the description.
	 *
	 * @return the description
	 */
	public String getDescription() {
		return this.getProperty('description');
	}
	
	/**
	 * Gets the company name.
	 *
	 * @return the company name
	 */
	public String getCompanyName() {
		return this.getProperty('company_name');
	}
	
	/**
	 * Gets the homepage url.
	 *
	 * @return the homepage url
	 */
	public String getHomepageUrl() {
		return this.getProperty('homepage_url');
	}
	
	/**
	 * Gets the deauthorize callback url.
	 *
	 * @return the deauthorize callback url
	 */
	public String getDeauthorizeCallbackUrl() {
		return this.getProperty('deauthorize_callback_url');
	}
	
	/**
	 * Gets the authorize redirect url.
	 *
	 * @return the authorize redirect url
	 */
	public String getAuthorizeRedirectUrl() {
		return this.getProperty('authorize_redirect_url');
	}
	
	/**
	 * Gets the deauthorize callback method.
	 *
	 * @return the deauthorize callback method
	 */
	public String getDeauthorizeCallbackMethod() {
		return this.getProperty('deauthorize_callback_method');
	}
	
	/**
	 * Gets the permissions required.
	 * 
	 * @return the permissions
	 */
	public List<String> getPermissions() {
		return this.getStringList('permissions');
	}
	
}