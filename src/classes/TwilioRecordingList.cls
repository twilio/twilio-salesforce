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
 * The Class TwilioRecordingList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/recording
 */
global class TwilioRecordingList extends TwilioResource.ListResource
	implements Iterable<TwilioRecording> {

	private String parentCallSid;

	/**
	 * Instantiates a new recording list.
	 *
	 * @param client the client
	 */
	public TwilioRecordingList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new recording list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioRecordingList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}
	
	/**
	 * Instantiates a new recording list under a Call resource.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioRecordingList(TwilioRestClient client, String parentCallSid) {
		super(client);
		this.parentCallSid = parentCallSid;
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid()				
				+ (this.parentCallSid!=null ? ('/Calls/'+this.parentCallSid) : '')
				+ '/Recordings.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioRecording(client, params);
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'recordings';
	}
	
	/* returns the current response results page */
	public List<TwilioRecording> getPageData() {
		List<TwilioRecording> returnList = new List<TwilioRecording>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioRecording) {
				returnList.add((TwilioRecording) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioRecording> iterator() {
		return new TwilioIterator.RecordingIterator(this);
	}
	
	/**
	 * Delete.
	 *
	 * @return true, if successful
	 * @throws TwilioRestException the twilio rest exception
	 */
	public boolean deleteResource(String sid) {
		TwilioAccount requestAccount = getClient().getAccount(getRequestAccountSid());
		TwilioRecording rec = requestAccount.getRecording(sid);
		return rec.deleteResource();
	}
}