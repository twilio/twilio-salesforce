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
 * The class TwilioAvailablePhoneNumberList
 * 
 *  For more information see see http://www.twilio.com/docs/api/rest/available-phone-numbers
 */
global class TwilioAvailablePhoneNumberList extends TwilioResource.ListResource
	implements Iterable<TwilioAvailablePhoneNumber> {

	public static final String TYPE_LOCAL = 'Local';
	public static final String TYPE_TOLLFREE = 'TollFree';
	
	/** The iso country. */
	private String isoCountry = 'US';
	
	/** The type. */
	private String type = TYPE_LOCAL;

	/**
	 * Instantiates a new available phone number list.
	 *
	 * @param client the client
	 */
	public TwilioAvailablePhoneNumberList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new available phone number list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioAvailablePhoneNumberList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}

	/**
	 * Instantiates a new available phone number list.
	 *
	 * @param client the client
	 * @param isoCountryCode the iso country code
	 * @param type the type
	 */
	public TwilioAvailablePhoneNumberList(TwilioRestClient client,
			String isoCountryCode, String type) {
		super(client);
		this.isoCountry = isoCountryCode;
		this.type = type;
	}
	
	public TwilioAvailablePhoneNumberList(TwilioRestClient client,
			Map<String, String> filters, String isoCountryCode, String type) {
		super(client, filters);
		this.isoCountry = isoCountryCode;
		this.type = type;
	}
	

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/AvailablePhoneNumbers/'
				+ this.isoCountry + '/' + this.type + '.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioAvailablePhoneNumber(client, params);
	}
	
	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'available_phone_numbers';
	}

	/* returns the current response results page */
	public List<TwilioAvailablePhoneNumber> getPageData() {
		List<TwilioAvailablePhoneNumber> returnList = new List<TwilioAvailablePhoneNumber>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioAvailablePhoneNumber) {
				returnList.add((TwilioAvailablePhoneNumber) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all response result pages */
	global Iterator<TwilioAvailablePhoneNumber> iterator() {
		return new TwilioIterator.AvailablePhoneNumberIterator(this);
	}

	
}