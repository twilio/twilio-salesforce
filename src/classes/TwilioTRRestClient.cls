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
 * The Class TwilioTRRestClient.
 */

public class TwilioTRRestClient extends TwilioClient{

   public static final String DEFAULT_VERSION = 'v1';
    /**
     * Explcitly construct a TwilioRestClient with the given API credentials.
     * 
     * @param accountSid
     *            the 34 character Account identifier (starting with 'AC'). This
     *            can be found on your Twilio dashboard page.
     * @param authToken
     *            the 32 character AuthToken. This can be found on your Twilio
     *            dashboard page.
     * 
     */

    public TwilioTRRestClient(String accountSid, String authToken) {
        super(accountSid, authToken, 'https://taskrouter.twilio.com');
    }


    /**
     * Explcitly construct a TwilioRestClient with the given API credentials and
     * endpoint.
     * 
     * @param accountSid
     *            the 34 character Account identifier (starting with 'AC'). This
     *            can be found on your Twilio dashboard page.
     * @param authToken
     *            the 32 character AuthToken. This can be found on your Twilio
     *            dashboard page.
     * @param endpoint
     *            the url of API endpoint you wish to use. (e.g. -
     *            'https://api.twilio.com')
     */
    public TwilioTRRestClient(String accountSid, String authToken, String endpoint) {
    	super(accountSid, authToken, endpoint);
    }

   /**
     * Returns the Workspaces list.
     * See http://www.twilio.com/docs/api/rest/recording
     */
    public TwilioTRWorkspaceList getWorkspaces() {
       return this.getWorkspaces(new Map<String, String>());
    }

    /**
     * Returns a list of Workspaces in this account, applying the supplied filters.
     * See http://www.twilio.com/docs/api/rest/applications
     */
    public TwilioTRWorkspaceList getWorkspaces(Map<String, String> filters) {
       TwilioTRWorkspaceList twlist = new TwilioTRWorkspaceList(this, filters);
       return twlist;
    }
    
    /**
     * Returns a given Workspace instance by sid.
     */
    public TwilioTRWorkspace getWorkspace(String sid) {
       TwilioTRWorkspace workspace = new TwilioTRWorkspace(this, sid);
       return workspace;
    }
       
}