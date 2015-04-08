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
 * The Class ApplicationList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/applications
 */
global class TwilioApplicationList extends TwilioResource.ListResource
		implements Iterable<TwilioApplication> {

	/**
	 * Instantiates a new application list.
	 *
	 * @param client the client
	 */
	public TwilioApplicationList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new application list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioApplicationList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Applications.json';
	}

	/* 
	 * see TwilioResource.ListResource#makeNew()
	 */
	public override Object makeNew(TwilioClient client, Map<String, Object> params) {
			TwilioApplication application = new TwilioApplication((TwilioRestClient)client, params);
			application.setRequestAccountSid(this.getRequestAccountSid());
			return application;
	}

	/* 
	 * see TwilioResource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'applications';
	}

	public TwilioApplication create(Map<String, String> params) {
		return (TwilioApplication)this.createInstance(params);
	}
	
	public List<TwilioApplication> getPageData() {
		List<TwilioApplication> returnList = new List<TwilioApplication>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioApplication) {
				returnList.add((TwilioApplication) o);
			}
		}
		return returnList;
	}
	
	global Iterator<TwilioApplication> iterator() {
		return new TwilioIterator.ApplicationIterator(this);
	}
	
	/**
	 * Delete.
	 *
	 * @return true, if successful
	 * @throws TwilioRestException the twilio rest exception
	 */
	public boolean deleteResource(String sid) {
		TwilioAccount requestAccount = ((TwilioRestClient)getClient()).getAccount(getRequestAccountSid());
		TwilioApplication app = requestAccount.getApplication(sid);
		return app.deleteResource();
	}
}