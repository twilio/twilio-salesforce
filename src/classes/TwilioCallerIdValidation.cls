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
global class TwilioCallerIdValidation {
	
	/** The properties. */
	private Map<String, Object> properties;
	
	/** The json keys. */
	private boolean jsonKeys = true;
	
	/**
	 * Instantiates a new caller id validation.
	 *
	 * @param response the response
	 */
	public TwilioCallerIdValidation(TwilioRestResponse response) {
		this.properties = new Map<String, Object>(response.toMap());
		this.jsonKeys = response.isJson();
	}
	
	/**
	 * Gets the unique id of the Account to which the Validation Request belongs.
	 *
	 * @return the account sid
	 */
	public String getAccountSid() {
		if (this.jsonKeys) {
			return getProperty('account_sid');
		}
		return getProperty('AccountSid');
	}
	
	/**
	 * Gets the validation code that must be entered via the phone
	 * to validate this phone number for Caller ID.
	 *
	 * @return the validation code
	 */
	public String getValidationCode() {
		//TODO better parsing here
		if (this.jsonKeys) {
			return getProperty('validation_code');
		}
		
		return getProperty('ValidationCode');
	}
	
	/**
	 * Gets the incoming phone number being validated, formatted with
	 * a '+' and country code e.g., +16175551212 (E.164 format).
	 *
	 * @return the phone number
	 */
	public String getPhoneNumber() {
		//TODO better parsing here
		if (this.jsonKeys) {
			return getProperty('phone_number');
		}
		
		return getProperty('PhoneNumber');
	}
	
	/**
	 * Gets the friendly name you provided, if any.
	 *
	 * @return the friendly name
	 */
	public String getFriendlyName() {
		if (this.jsonKeys) {
			return getProperty('friendly_name');
		}
		
		return getProperty('FriendlyName');
	}
	
	/**
	 * Gets the property.
	 *
	 * @param name the name
	 * @return the property
	 */
	public String getProperty(String name) {
		Object prop = properties.get(name);
		prop = properties.get(name);

		if (prop == null) {
			throw new IllegalArgumentException('Property ' + name
					+ ' does not exist');
		}

		if (prop instanceof String) {
			return (String) prop;
		}

		throw new IllegalArgumentException('Property ' + name
				+ ' is an object.  Use getOjbect() instead.');
	}
	
	public class IllegalArgumentException extends Exception {}
}