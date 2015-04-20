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
global class TwilioLookupsPhoneNumber extends TwilioResource.InstanceResource {

	public enum PhoneType {LANDLINE, MOBILE, VOIP}

	private String phoneNumber;

	/**
	 * Instantiates a new lookup phonenumber.
	 *
	 * @param client the client
	 */
	public TwilioLookupsPhoneNumber(TwilioLookupsRestClient client) {
    	super(client);
    }
    
    /**
	 * Instantiates a lookup phonenumber
	 *
	 * @param client the client
	 * @param phoneNumber the phonenumber to lookup
	 */
	public TwilioLookupsPhoneNumber(TwilioLookupsRestClient client, String phoneNumber) {
		super(client);
		this.phoneNumber = phoneNumber;
	}


	/**
	 * Instantiates a lookup phonenumber
	 *
	 * @param client  the client
	 * @param phoneNumber the phonenumber to lookup
	 * @param properties  properties to set on the new lookup as key/value pairs
	 */
	public TwilioLookupsPhoneNumber(TwilioLookupsRestClient client, String phoneNumber, Map<String, String> params) {
		super(client, params);
		this.phoneNumber = phoneNumber;
	}


	/**
	 * Returns the URI of this resource, relative to the API endpoint.
	 */
	public override String getResourceLocation() {
		return '/' + TwilioLookupsRestClient.DEFAULT_VERSION + '/PhoneNumbers/' + this.phoneNumber;
	}
	

	/*
	 * Property getters
	 */

	/**
	 * Gets the phone number.
	 *
	 * @return the phone number
	 */
	public String getPhoneNumber() {
		return this.getProperty('phone_number');
	}

	/**
	 * @return The ISO 3166-1 alpha-2 country code for this phone number's country.
	 */
	public String getCountryCode() {
		return getProperty('country_code');
	}


	/**
	 * @return The phone number in localized format, e.g. "(415) 867-5309"
	 */
	public String getFormattedNumber() {
		return getProperty('national_format');
	}

	/**
	 * The country code for the mobile carrier, or null.
	 * Only available if carrier information was requested and the number is
	 * a mobile number.
	 * @return Mobile carrier country code
	 */
	public String getMobileCountryCode() {
		return (String) getCarrierProperty('mobile_country_code');
	}

	/**
	 * The mobile carrier's network code, or null.
	 * Only populated if carrier information was requested and the number is a mobile number.
	 * @return Mobile carrier network code
	 */
	public String getMobileNetworkCode() {
		return (String) getCarrierProperty('mobile_network_code');
	}

	/**
	 * Only available if carrier information was requested.
	 * @return The carrier name
	 */
	public String getCarrierName() {
		return (String) getCarrierProperty('name');
	}

	/**
	 * @return Number type, or null if carrier information wasn't requested or lookup failed
	 */
	public PhoneType getPhoneType() {
		String t = (String) getCarrierProperty('type');
		if (t != null) {
			for (PhoneType ptype : PhoneType.values()) {
				if (ptype.name().equalsIgnoreCase(t)) {
					return ptype;
				}
			}
		}
		return null;
	}

	/**
	 * @return Error code, if carrier lookup failed
	 */
	public Integer getErrorCode() {
		return (Integer) getCarrierProperty('error_code');
	}

	/**
	 * @return This resource's URL
	 */
	public String getUrl() {
		return getProperty('url');
	}

	private Object getCarrierProperty(String name) {
		Map<String, Object> carrierProperties = (Map<String, Object>) getObject('carrier');
		if (carrierProperties != null) {
			return carrierProperties.get(name);
		}
		return null;
	}

}