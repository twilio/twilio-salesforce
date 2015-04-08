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
 * The class TwilioTRWorkerList
 * 
 *  For more information see see http://www.twilio.com/docs/api/rest/call
 */
global class TwilioTRWorkerList extends TwilioResource.NextGenListResource
	implements Iterable<TwilioTRWorker> {  
	
	/** The workspace sid. */
	private String workspaceSid;

	/**
	 * Instantiates a new worker list.
	 *
	 * @param client the client
	 */
	public TwilioTRWorkerList(TwilioTRRestClient client) {
		super(client);
	}
	
	/**
	 * Instantiates a new worker list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioTRWorkerList(TwilioTRRestClient client, String workspaceSid, Map<String, String> filters) {
		super(client, filters);
		this.workspaceSid = workspaceSid;	
	}

	/**
	 * Instantiates a new worker list.
	 *
	 * @param client the client
	 * @param workspaceSid the workspace sid
	 */
	public TwilioTRWorkerList(TwilioTRRestClient client, String workspaceSid) {
		super(client);
		this.workspaceSid = workspaceSid;
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {		
		return '/' + TwilioTRRestClient.DEFAULT_VERSION + '/Workspaces/'
				+ this.workspaceSid +  '/Workers';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioClient client,
			Map<String, Object> params) {
		return new TwilioTRWorker((TwilioTRRestClient)client, params);
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'workers';
	}
	
	public TwilioTRWorker create(Map<String,String> params) {
		return (TwilioTRWorker)this.createInstance(params);
	}
	
	/* returns the current response results page */
	public List<TwilioTRWorker> getPageData() {
		List<TwilioTRWorker> returnList = new List<TwilioTRWorker>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioTRWorker) {
				returnList.add((TwilioTRWorker) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioTRWorker> iterator() {
		return new TwilioIterator.TRWorkerIterator(this);
	}
}