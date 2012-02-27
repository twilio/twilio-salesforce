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
 * The AuthorizedConnectApps list resource shows all of the Connect Apps that
 * you have authorized for your account. Each Connect App corresponds to a
 * subaccount within your Twilio account, which acts as that Connect App's
 * sandbox. The instance resource shows you the permissions you have granted for
 * a Connect App as well as information about the Connect App itself.
 * 
 * 
 * 
 * For more information see http://www.twilio.com/docs/api/rest/authorized-connect-apps
 */
global class TwilioAuthorizedConnectApp extends TwilioResource.InstanceResource {

	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'connect_app_sid';

	/** The Constant DATE_UPDATED_PROPERTY. */
	private static final String DATE_UPDATED_PROPERTY = 'date_updated';

	/** The Constant DATE_CREATED_PROPERTY. */
	private static final String DATE_CREATED_PROPERTY = 'date_created';

	/** The Constant FRIENDLY_NAME_PROPERTY. */
	private static final String FRIENDLY_NAME_PROPERTY = 'connect_app_friendly_name';

	/**
	 * Instantiates a new application.
	 * 
	 * @param client
	 *            the client
	 */
	public TwilioAuthorizedConnectApp(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new application.
	 * 
	 * @param client
	 *            the client
	 * @param sid
	 *            the sid
	 */
	public TwilioAuthorizedConnectApp(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new application.
	 * 
	 * @param client
	 *            the client
	 * @param properties
	 *            the properties
	 */
	public TwilioAuthorizedConnectApp(TwilioRestClient client,
			Map<String, Object> properties) {
		super(client, properties);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/AuthorizedConnectApps/' + this.getSid()
				+ '.json';
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
		return this.getProperty('connect_app_description');
	}

	/**
	 * Gets the company name.
	 * 
	 * @return the company name
	 */
	public String getCompanyName() {
		return this.getProperty('connect_app_company_name');
	}

	/**
	 * Gets the homepage url.
	 * 
	 * @return the homepage url
	 */
	public String getHomepageUrl() {
		return this.getProperty('connect_app_homepage_url');
	}

	/**
	 * Gets the permissions granted.
	 * 
	 * @return the permissions
	 */
	public List<String> getPermissions() {
		return this.getStringList('permissions');
	}
}