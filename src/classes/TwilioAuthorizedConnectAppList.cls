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
 * The ConnectApps list resource shows all of the Connect Apps that you have
 * authorized within your Twilio account. The instance resource shows you the
 * permissions you have authorized for a single Connect App as well as
 * information about the Connect App itself.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/authorized-connect-apps
 */
global class TwilioAuthorizedConnectAppList extends TwilioResource.ListResource
	implements Iterable<TwilioAuthorizedConnectApp> {

	/**
	 * Instantiates a new AuthorizedConnectApp list.
	 * 
	 * @param client
	 *            the client
	 */
	public TwilioAuthorizedConnectAppList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new AuthorizedConnectApp list.
	 * 
	 * @param client
	 *            the client
	 * @param filters
	 *            the filters
	 */
	public TwilioAuthorizedConnectAppList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/*
	 * see TwilioResource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/AuthorizedConnectApps.json';
	}

	/*
	 * see TwilioResource.ListResource#makeNew(TwilioRestClient, Map)
	 */
	public override Object makeNew(TwilioClient client, Map<String, Object> params) {
		TwilioAuthorizedConnectApp connectApp = new TwilioAuthorizedConnectApp((TwilioRestClient)client, params);
		connectApp.setRequestAccountSid(this.getRequestAccountSid());
		return connectApp;
	}

	/**
	 * see TwilioResource.ListResource#getListKey()
	 */
	public override String getListKey() {
		return 'authorized_connect_apps';
	}
	
	/** returns the current response results page */
	public List<TwilioAuthorizedConnectApp> getPageData() {
		List<TwilioAuthorizedConnectApp> returnList = new List<TwilioAuthorizedConnectApp>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioAuthorizedConnectApp) {
				returnList.add((TwilioAuthorizedConnectApp) o);
			}
		}
		return returnList;
	}
	
	/** returns an iterator spanning all data pages */
	global Iterator<TwilioAuthorizedConnectApp> iterator() {
		return new TwilioIterator.AuthorizedConnectAppIterator(this);
	}

}