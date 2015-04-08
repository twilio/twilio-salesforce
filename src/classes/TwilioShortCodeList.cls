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
 * The class TwilioShortCodeList
 * 
 * For more information see http://www.twilio.com/docs/api/rest/shortcodes
 */
global class TwilioShortCodeList extends TwilioResource.ListResource 
	implements Iterable<TwilioShortCode> {

	/**
	 * Instantiates a new incoming phone number list.
	 *
	 * @param client the client
	 */
	public TwilioShortCodeList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new incoming phone number list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioShortCodeList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/SMS/ShortCodes.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioClient client, Map<String, Object> params) {
		TwilioShortCode shortCode = new TwilioShortCode((TwilioRestClient)client, params);
		shortCode.setRequestAccountSid(this.getRequestAccountSid());
		return shortCode;
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'short_codes';
	}
	
	/* returns the current response results page */
	public List<TwilioShortCode> getPageData() {
		List<TwilioShortCode> returnList = new List<TwilioShortCode>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioShortCode) {
				returnList.add((TwilioShortCode) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioShortCode> iterator() {
		return new TwilioIterator.ShortCodeIterator(this);
	}
	
}