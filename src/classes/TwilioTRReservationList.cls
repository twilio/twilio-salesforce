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
 * The class TwilioTRReservationList
 * 
 *  For more information see see http://www.twilio.com/docs/api/rest/call
 */
global class TwilioTRReservationList extends TwilioResource.NextGenListResource
	implements Iterable<TwilioTRReservation> {  
	
	/** The workspace sid. */
	private String workspaceSid;
	private String taskSid;
	/**
	 * Instantiates a new task list.
	 *
	 * @param client the client
	 */
	public TwilioTRReservationList(TwilioTRRestClient client) {
		super(client);
	}
	
	/**
	 * Instantiates a new task list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioTRReservationList(TwilioTRRestClient client, String workspaceSid, Map<String, String> filters) {
		super(client, filters);
		this.workspaceSid = workspaceSid;
	}

	/**
	 * Instantiates a new task list.
	 *
	 * @param client the client
	 * @param workspaceSid the workspace sid
	 */
	public TwilioTRReservationList(TwilioTRRestClient client, String workspaceSid, String taskSid) {
		super(client);
		this.workspaceSid = workspaceSid;
		this.taskSid = taskSid;
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioTRRestClient.DEFAULT_VERSION + '/Workspaces/'
				+ this.workspaceSid +  '/Tasks/'
				+ this.taskSid + '/Reservations';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioClient client,
			Map<String, Object> params) {
		return new TwilioTRReservation((TwilioTRRestClient)client, params);
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'reservations';
	}
	
	public TwilioTRReservation create(Map<String,String> params) {
		return (TwilioTRReservation)this.createInstance(params);
	}
	
	/* returns the current response results page */
	public List<TwilioTRReservation> getPageData() {
		List<TwilioTRReservation> returnList = new List<TwilioTRReservation>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioTRReservation) {
				returnList.add((TwilioTRReservation) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all data pages */
	global Iterator<TwilioTRReservation> iterator() {
		return new TwilioIterator.TRReservationIterator(this);
	}
}