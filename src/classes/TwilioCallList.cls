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
 * The class TwilioCallList
 * 
 *  For more information see see http://www.twilio.com/docs/api/rest/call
 */
global class TwilioCallList extends TwilioResource.ListResource
	implements Iterable<TwilioCall> {  
	
	/**
	 * Instantiates a new call list.
	 *
	 * @param client the client
	 */
	public TwilioCallList(TwilioClient client) {
		super(client);
	}
	
	/**
	 * Instantiates a new call list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioCallList(TwilioClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Calls.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioClient client, 
		Map<String, Object> params) {
			TwilioCall call = new TwilioCall((TwilioRestClient)client, params);
			call.setRequestAccountSid(this.getRequestAccountSid());
			return call;
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'calls';
	}
	
	public TwilioCall create(Map<String,String> params) {
		return (TwilioCall)this.createInstance(params);
	}
	
	/* returns the current response results page */
	public List<TwilioCall> getPageData() {
		List<TwilioCall> returnList = new List<TwilioCall>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioCall) {
				returnList.add((TwilioCall) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioCall> iterator() {
		return new TwilioIterator.CallIterator(this);
	}
}