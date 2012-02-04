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