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
 * The class TwilioTranscriptionList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/transcription
 */
global class TwilioTranscriptionList extends TwilioResource.ListResource
	implements Iterable<TwilioTranscription> {

	private String parentCallSid;

	/**
	 * Instantiates a new transcription list.
	 *
	 * @param client the client
	 */
	public TwilioTranscriptionList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new transcription list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioTranscriptionList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}
	
	/**
	 * Instantiates a new recording list under a Call resource.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioTranscriptionList(TwilioRestClient client, String parentCallSid) {
		super(client);
		this.parentCallSid = parentCallSid;
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid()
				+ (this.parentCallSid!=null ? ('/Recordings/'+this.parentCallSid) : '')
				+ '/Transcriptions.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioClient client, Map<String, Object> params) {
		TwilioTranscription transcription = new TwilioTranscription((TwilioRestClient)client, params);
		transcription.setRequestAccountSid(this.getRequestAccountSid());
		return transcription;
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'transcriptions';
	}
	
	/* returns the current response results page */
	public List<TwilioTranscription> getPageData() {
		List<TwilioTranscription> returnList = new List<TwilioTranscription>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioTranscription) {
				returnList.add((TwilioTranscription) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioTranscription> iterator() {
		return new TwilioIterator.TranscriptionIterator(this);
	}
}