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
 * The class TwilioOutgoingCallerIdList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/outgoing-caller-ids
 */
global class TwilioOutgoingCallerIdList extends TwilioResource.ListResource
		 {

	/**
	 * Instantiates a new outgoing caller id list.
	 *
	 * @param client the client
	 */
	public TwilioOutgoingCallerIdList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new outgoing caller id list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioOutgoingCallerIdList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/OutgoingCallerIds.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioClient client, Map<String, Object> params) {
		TwilioOutgoingCallerId callerId = new TwilioOutgoingCallerId((TwilioRestClient)client, params);
		callerId.setRequestAccountSid(this.getRequestAccountSid());
		return callerId;
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'outgoing_caller_ids';
	}
	
	public TwilioCallerIdValidation create(Map<String,String> params) {
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', params);
		return new TwilioCallerIdValidation(response);
	}
	
	/* returns the current response results page */
	public List<TwilioOutgoingCallerId> getPageData() {
		List<TwilioOutgoingCallerId> returnList = new List<TwilioOutgoingCallerId>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioOutgoingCallerId) {
				returnList.add((TwilioOutgoingCallerId) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioOutgoingCallerId> iterator() {
		return new TwilioIterator.OutgoingCallerIdIterator(this);
	}
	
	/* convenience methods */
	public TwilioCallerIdValidation validate(String phoneNumber) {
		Map<String,String> params = new Map<String,String> {
			'PhoneNumber' => phoneNumber
		};
		return create(params);
	}
}