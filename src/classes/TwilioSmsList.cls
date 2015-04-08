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
 * The class TwilioSmsList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/sms
 */
global class TwilioSmsList extends TwilioResource.ListResource implements Iterable<TwilioSms> {
	
	/**
	 * Instantiates a new sms list.
	 *
	 * @param client the client
	 */
	public TwilioSmsList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new sms list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioSmsList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/SMS/Messages.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioClient client, Map<String, Object> params) {
		TwilioSms sms = new TwilioSms((TwilioRestClient)client, params);
		sms.setRequestAccountSid(this.getRequestAccountSid());
		return sms;
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'sms_messages';
	}
	
	/**
	 * Send a new SMS message using the supplied parameters
	 *
	 * See http://www.twilio.com/docs/api/rest/sending-sms
	 *   for a list of parameters
	 */
	public TwilioSms create(Map<String, String> params) {
		return (TwilioSms)this.createInstance(params);
	}
	
	public List<TwilioSms> getPageData() {
		List<TwilioSms> returnList = new List<TwilioSms>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioSms) {
				returnList.add((TwilioSms) o);
			}
		}
		return returnList;
	}
	
	global Iterator<TwilioSms> iterator() {
		return new TwilioIterator.SmsIterator(this);
	}

}