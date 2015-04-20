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
 * The Class TwilioTRRestClient.
 */

public class TwilioLookupsRestClient extends TwilioClient{

   public static final String DEFAULT_VERSION = 'v1';
    /**
     * Explcitly construct a TwilioRestClient with the given API credentials.
     * 
     * @param accountSid
     *            the 34 character Account identifier (starting with 'AC'). This
     *            can be found on your Twilio dashboard page.
     * @param authToken
     *            the 32 character AuthToken. This can be found on your Twilio
     *            dashboard page.
     * 
     */

    public TwilioLookupsRestClient(String accountSid, String authToken) {
        super(accountSid, authToken, 'https://lookups.twilio.com');
    }


    /**
     * Explcitly construct a TwilioRestClient with the given API credentials and
     * endpoint.
     * 
     * @param accountSid
     *            the 34 character Account identifier (starting with 'AC'). This
     *            can be found on your Twilio dashboard page.
     * @param authToken
     *            the 32 character AuthToken. This can be found on your Twilio
     *            dashboard page.
     * @param endpoint
     *            the url of API endpoint you wish to use. (e.g. -
     *            'https://api.twilio.com')
     */
    public TwilioLookupsRestClient(String accountSid, String authToken, String endpoint) {
    	super(accountSid, authToken, endpoint);
    }


   /**
     * Returns the PhoneNumber.
     * See http://www.twilio.com/docs/api/rest/recording
     */

	public TwilioLookupsPhoneNumber getPhoneNumber(final String phoneNumber) {
        TwilioLookupsPhoneNumber pn = getPhoneNumber(phoneNumber, null, false);
        pn.getPhoneNumber();
        return pn;
		//return getPhoneNumber(phoneNumber, null, false);
	}

	public TwilioLookupsPhoneNumber getPhoneNumber(final String phoneNumber, final Boolean includeCarrierInfo) {
		TwilioLookupsPhoneNumber pn =  getPhoneNumber(phoneNumber, null, includeCarrierInfo);
        pn.getPhoneNumber();
        return pn;
        //return getPhoneNumber(phoneNumber, null, includeCarrierInfo);
	}

	public TwilioLookupsPhoneNumber getPhoneNumber(final String phoneNumber, final String countryCode, final Boolean includeCarrierInfo) {
		Map<String, String> params = new Map<String, String>();
		if (includeCarrierInfo) {
			params.put('Type', 'carrier');
		}

		if (countryCode != null) {
			params.put('CountryCode', countryCode);
		}
        TwilioLookupsPhoneNumber pn = new TwilioLookupsPhoneNumber(this, phoneNumber, params);
        pn.getPhoneNumber();
        return pn;
		//return new TwilioLookupsPhoneNumber(this, phoneNumber, params);
	}       
}