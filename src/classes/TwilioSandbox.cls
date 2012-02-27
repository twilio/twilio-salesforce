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
 * The Sandbox resource gives you programatic access to your Twilio
 * Developer Sandbox phone number. Using this resource you can get
 * the phone number and PIN for your sandbox, view the current voice
 * and SMS URLs, and update those URLs just like any other
 * IncomingPhoneNumber resource on a full Twilio Account.
 *
 * For more information see http://www.twilio.com/docs/api/rest/sandbox
 */
global class TwilioSandbox extends TwilioResource.InstanceResource {
	/**
	 * Instantiates a new sandbox.
	 *
	 * @param client the client
	 */
	public TwilioSandbox(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new sandbox.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioSandbox(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/**
	 * Returns the URI of this resource, relative to the API endpoint.
	 *
	 * @return the resource location
	 *    
	 */
	protected override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Sandbox.json';
	}

	/*
	 * Property getters
	 */
	 
	 /**
	 * Gets the account sid.
	 *
	 * @return the account sid
	 */
	public String getAccountSid() {
		return this.getProperty('account_sid');
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
	 * Gets the phone number.
	 *
	 * @return the phone number
	 */
	public String getPhoneNumber() {
		return this.getProperty('phone_number');
	}

	/**
	 * Gets the application sid.
	 *
	 * @return the application sid
	 */
	public String getApplicationSid() {
		return this.getProperty('application_sid');
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
	 * Gets the pin.
	 *
	 * @return the pin
	 */
	public String getPin() {
		return this.getProperty('pin');
	}
	
	/**
	 * Gets the URI of this resource returned by the server.
	 *
	 * @return the URI
	 */
	public String getUri() {
		return this.getProperty('uri');
	}
}