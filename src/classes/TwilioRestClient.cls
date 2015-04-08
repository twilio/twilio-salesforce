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
 * The Class TwilioRestClient.
 */
public class TwilioRestClient extends TwilioClient{
    public static final String DEFAULT_VERSION = '2010-04-01';

    /** The auth account. */
    private TwilioAccount authAccount;


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
    public TwilioRestClient(String accountSid, String authToken) {
        super(accountSid, authToken, 'https://api.twilio.com');
        this.authAccount = new TwilioAccount(this);
        this.authAccount.setSid(accountSid);
        this.authAccount.setAuthToken(authToken);  
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
    public TwilioRestClient(String accountSid, String authToken, String endpoint) {
        super(accountSid, authToken, endpoint);
        this.authAccount = new TwilioAccount(this);
        this.authAccount.setSid(accountSid);
        this.authAccount.setAuthToken(authToken);        
    }
    

    /*
     * Resource related methods
     */
    /**
     * Get a list of Account objects.
     *
     * For more info see http://www.twilio.com/docs/api/rest/account
     * 
     * @param params
     *            Filter the list with the given params. See the Twilio docs for
     *            available filters.
     * @return the list of accounts.
     */
    public TwilioAccountList getAccounts(Map<String, String> params) {
        TwilioAccountList aclist = new TwilioAccountList(this, params);
        aclist.setRequestAccountSid(this.accountSid);
        return aclist;
    }

    /**
     * Get all accounts.
     *
     * For more info see http://www.twilio.com/docs/api/rest/account
     * 
     * @return the list of accounts.
     */
    public TwilioAccountList getAccounts() {
        return this.getAccounts(new Map<String, String>());
    }

    /**
     * A shortcut for the most common case, returning the Account object for
     * this authenticated client.
     * 
     * @return Account that maps to the authenticated account.
     */
    public TwilioAccount getAccount() {
        return this.authAccount;
    }

    /**
     * Get an account by account sid.
     * 
     * @param sid
     *            The sid of the account you want to fetch.
     * @return the account
     */
    public TwilioAccount getAccount(String sid) {
        TwilioAccount account = new TwilioAccount(this);
        account.setSid(sid);
        account.setRequestAccountSid(sid);

        return account;
    }

    public String getAccountSid() {
        return this.accountSid;
    }
    
}