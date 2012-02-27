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
 * The Class AvailablePhoneNumber.
 * 
 * For more information see see http://www.twilio.com/docs/api/rest/available-phone-numbers
 */
global class TwilioAvailablePhoneNumber extends TwilioResource.InstanceResource {

	/**
	 * Instantiates a new available phone number.
	 *
	 * @param client the client
	 */
	public TwilioAvailablePhoneNumber(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new available phone number.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioAvailablePhoneNumber(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	public override String getResourceLocation() {
		throw new TwilioRestException('AvailablePhoneNumbers do not have an instance resource location');
	}

	/*
	 * Property getters
	 */
	
	/**
	 * Gets the friendly name.
	 *
	 * @return the friendly name
	 */
	public String getFriendlyName() {
		return this.getProperty('friendly_name');
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
	 * Gets the lata.
	 *
	 * @return the lata
	 */
	public String getLata() {
		return this.getProperty('lata');
	}
	
	/**
	 * Gets the rate center.
	 *
	 * @return the rate center
	 */
	public String getRateCenter() {
		return this.getProperty('rate_center');
	}
	
	/**
	 * Gets the latitude.
	 *
	 * @return the latitude
	 */
	public String getLatitude() {
		return this.getProperty('latitude');
	}
	
	/**
	 * Gets the longitude.
	 *
	 * @return the longitude
	 */
	public String getLongitude() {
		return this.getProperty('longitude');
	}
	
	/**
	 * Gets the region.
	 *
	 * @return the region
	 */
	public String getRegion() {
		return this.getProperty('region');
	}
	
	/**
	 * Gets the postal code.
	 *
	 * @return the postal code
	 */
	public String getPostalCode() {
		return this.getProperty('postal_code');
	}
	
	/**
	 * Gets the iso country.
	 *
	 * @return the iso country
	 */
	public String getIsoCountry() {
		return this.getProperty('iso_country');
	}
	
	/* Convenience Methods */
	
	private boolean purchased = false;
	
	public TwilioIncomingPhoneNumber purchase() {
		if (this.purchased) {
			throw new AlreadyPurchasedException('You have already purchased this number: '+getPhoneNumber());
		}
		Map<String,String> props = new Map<String,String>();
		props.put('PhoneNumber', getPhoneNumber());
		
		TwilioAccount requestAccount = getClient().getAccount(getRequestAccountSid());
		TwilioIncomingPhoneNumber incoming = requestAccount.getIncomingPhoneNumbers().create(props);
		this.purchased = true;
		return incoming;
	}
	
	private class AlreadyPurchasedException extends Exception {}
}