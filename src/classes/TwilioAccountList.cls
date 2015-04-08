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
global class TwilioAccountList extends TwilioResource.ListResource
    implements Iterable<TwilioAccount> {  
    
    /**
     * Instantiates a new account list.
     *
     * @param client the client
     */
    public TwilioAccountList(TwilioRestClient client) {
        super(client);
    }
    
    /**
     * Instantiates a new call list.
     *
     * @param client the client
     * @param filters the filters
     */
    public TwilioAccountList(TwilioRestClient client, Map<String, String> filters) {
        super(client, filters);
    }

    /* implements method from TwilioResource */
    public override String getResourceLocation() {
        return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts.json';
    }

    /* implements method from TwilioResource.ListResource */
    public override Object makeNew(TwilioClient client,
            Map<String, Object> params) {
        return new TwilioAccount((TwilioRestClient)client, params);
    }

    /* implements method from TwilioResource.ListResource */
    public override String getListKey() {
        return 'accounts';
    }
    
    public TwilioAccount create(Map<String, String> params) {
        return (TwilioAccount)this.createInstance(params);
    }
    public TwilioAccount create(List<TwilioNameValuePair> params) {
        return (TwilioAccount)this.createInstance(params);
    }
    
    public List<TwilioAccount> getPageData() {
        List<TwilioAccount> returnList = new List<TwilioAccount>();
        
        for (Object o : this.getObjectPageData()) {
            if (o instanceof TwilioAccount) {
                returnList.add((TwilioAccount) o);
            }
        }
        return returnList;
    }
    
    global Iterator<TwilioAccount> iterator() {
        return new TwilioIterator.AccountIterator(this);
    }
}