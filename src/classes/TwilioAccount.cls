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
/*
 * The Account class, representing a Twilio customer account.
 * For more information see http://www.twilio.com/docs/api/rest/account
 */
global class TwilioAccount extends TwilioResource.InstanceResource {

    /* property keys */
    private static final String DATE_UPDATED_PROPERTY = 'date_updated';
    private static final String DATE_CREATED_PROPERTY = 'date_created';
    private static final String STATUS_PROPERTY = 'status';
    private static final String FRIENDLY_NAME_PROPERTY = 'friendly_name';
    private static final String ACCOUNT_SID_PROPERTY = 'sid';
    private static final String AUTH_TOKEN_PROPERTY = 'auth_token';
    private static final String TYPE_PROPERTY = 'type';
    private static final String OWNER_ACCOUNT_SID_PROPERTY = 'owner_account_sid';
    private static final String CONNECT_APP_SID_PROPERTY = 'connect_app_sid';

    /* Constructor */
    public TwilioAccount(TwilioRestClient client) {
        super(client);
    }

    /* Constructor, using predefined set of property values */
    public TwilioAccount(TwilioRestClient client, Map<String, Object> properties) {
        super(client, properties);
        Object ac = properties.get(ACCOUNT_SID_PROPERTY);
        if (ac != null && ac instanceof String) {
            String accountSid = (String) ac;
            this.setRequestAccountSid(accountSid);
        }
    }

    /* Sid field accessor */
    public String getSid() {
        if (this.getRequestAccountSid() != null)
            return this.getRequestAccountSid();
        else
            return this.getProperty(ACCOUNT_SID_PROPERTY);
    }

    /* Sid field accessor */
    public void setSid(String accountSid) {
        this.setRequestAccountSid(accountSid);
        this.setProperty(ACCOUNT_SID_PROPERTY, accountSid);
        
    }
    
    /** Returns the sid for the ConnectApp using this Account */
    public String getConnectAppSid() {
        return this.getProperty(CONNECT_APP_SID_PROPERTY);
    }
    
    /** Returns the AccountSid of the primary account */
    public String getOwnerAccountSid() {
        return this.getProperty(OWNER_ACCOUNT_SID_PROPERTY);
    }

    /** Returns the API auth token (secret) for this account */
    public String getAuthToken() {
        return this.getProperty(AUTH_TOKEN_PROPERTY);
    }

    /** Sets the API auth token (secret) for this account */
    public void setAuthToken(String authToken) {
        this.setProperty(AUTH_TOKEN_PROPERTY, authToken);
    }

    /** Returns the human-readable label for this account */
    public String getFriendlyName() {
        return this.getProperty(FRIENDLY_NAME_PROPERTY);
    }

    /** Returns the status value for this account */
    public String getStatus() {
        return this.getProperty(STATUS_PROPERTY);
    }

    /** Returns the date and time this account was created */
    public Datetime getDateCreated() {
        return this.getPropertyDatetime(DATE_CREATED_PROPERTY);
    }

    /** Returns the date and time this account was last updated */
    public Datetime getDateUpdated() {
        return this.getPropertyDatetime(DATE_UPDATED_PROPERTY);
    }
     
    /** Returns the account type */
    public String getType() {
        return this.getProperty(TYPE_PROPERTY);
    }
    
    /** Return the Twilio URI for this resource. */
    public String getUri() {
        return this.getProperty('uri');
    }
    
    /** Returns the URIs for resources under this account */
    public Map<String,Object> getSubresourceUris() {
        return (Map<String,Object>)this.getObject('subresource_uris');
    }

    /** Constructs a Twilio API resource URI for this Account. Overrides method from TwilioResource. */
    public override String getResourceLocation() {
        return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
                + this.getRequestAccountSid() + '.json';
    }


    /* SUBRESOURCE METHODS */

    /* Returns the calls list resource without any filters.
     * See http://www.twilio.com/docs/api/rest/call
     */
    public TwilioCallList getCalls() {
        return this.getCalls(new Map<String, String>());
    }

    /* Returns the calls list resource with the given filters.
     * See http://www.twilio.com/docs/api/rest/call
     */
    public TwilioCallList getCalls(Map<String, String> filters) {
        TwilioCallList calls = new TwilioCallList(this.getClient(), filters);
        calls.setRequestAccountSid(this.getRequestAccountSid());
        
        return calls;
    }
    
    /** Returns a given call instance by sid */
    public TwilioCall getCall(String sid) {
        TwilioCall call = new TwilioCall(this.getClient(), sid);
        call.setRequestAccountSid(this.getRequestAccountSid());
        return call;
    }


    /**
     * Returns the sms message list.
     * See http://www.twilio.com/docs/api/rest/sms
     */
    public TwilioSmsList getSmsMessages() {
        return this.getSmsMessages(new Map<String, String>());
    }

    /**
     * Returns the SMS messages list, applying the supplied filters.
     * See http://www.twilio.com/docs/api/rest/sms
     */
    public TwilioSmsList getSmsMessages(Map<String, String> filters) {
        TwilioSmsList sms = new TwilioSmsList(this.getClient(), filters);
        sms.setRequestAccountSid(this.getRequestAccountSid());

        return sms;
    }
    
    /** Returns a given SMS message by sid */
    public TwilioSms getSms(String sid) {
        TwilioSms sms = new TwilioSms(this.getClient(), sid);
        sms.setRequestAccountSid(this.getRequestAccountSid());
        return sms;
    }
    
    /**
     * Returns the message list.
     * See http://www.twilio.com/docs/api/rest/message
     */
    public TwilioMessageList getMessages() {
        return this.getMessages(new Map<String, String>());
    }

    /**
     * Returns the messages list, applying the supplied filters.
     * See http://www.twilio.com/docs/api/rest/message
     */
    public TwilioMessageList getMessages(Map<String, String> filters) {
        TwilioMessageList message = new TwilioMessageList(this.getClient(), filters);
        message.setRequestAccountSid(this.getRequestAccountSid());

        return message;
    }
    
    /** Returns a given message by sid */
    public TwilioMessage getMessage(String sid) {
        TwilioMessage message = new TwilioMessage(this.getClient(), sid);
        message.setRequestAccountSid(this.getRequestAccountSid());
        return message;
    }
    
    public TwilioQueueList getQueues() 
    {
        TwilioQueueList Queuelist = new TwilioQueueList(this.getClient(), filters);
        Queuelist.setRequestAccountSid(this.getRequestAccountSid());
        return Queuelist;
    }

     /**
         * Get a given queue by sid
         *
         * @param sid The Sid starting with QU
         * @return the TwilioQueue object
     */
     public TwilioQueue getQueue(String sid) 
     {
         TwilioQueue queue = new TwilioQueue(this.getClient(), sid);
         queue.setRequestAccountSid(this.getRequestAccountSid());
         return queue;
     }
        
    /**
     * Suspend a subaccount.
     *
     * @return the account
     * @throws TwilioRestException the twilio rest exception
     */
    public TwilioAccount suspend() {
        Map<String, String> vars = new Map<String, String>
                { 'Status'=> 'suspended' };

        TwilioRestResponse response = this.getClient().safeRequest(
                this.getResourceLocation(), 'POST', vars);

        TwilioAccount a = new TwilioAccount(this.getClient(), response.toMap());
        a.setRequestAccountSid(this.getRequestAccountSid());
        return a;
    }
    
    /**
     * Activate a suspended subaccount.
     *
     * @return the account
     * @throws TwilioRestException the twilio rest exception
     */
    public TwilioAccount activate() {
        Map<String, String> vars = new Map<String, String>
                { 'Status'=> 'active' };

        TwilioRestResponse response = this.getClient().safeRequest(
                this.getResourceLocation(), 'POST', vars);

        TwilioAccount a = new TwilioAccount(this.getClient(), response.toMap());
        a.setRequestAccountSid(this.getRequestAccountSid());
        return a;
    }
    
    /**
     * Close a subaccount. WARNING: This cannot be undone.
     *
     * @return the account
     * @throws TwilioRestException the twilio rest exception
     */
    public TwilioAccount close() {
        Map<String, String> vars = new Map<String, String>
                { 'Status'=> 'closed' };

        TwilioRestResponse response = this.getClient().safeRequest(
                this.getResourceLocation(), 'POST', vars);

        TwilioAccount a = new TwilioAccount(this.getClient(), response.toMap());
        a.setRequestAccountSid(this.getRequestAccountSid());
        return a;
    }
    
    /**
     * Returns the list of Applications in this account.
     * See http://www.twilio.com/docs/api/rest/applications
     */
    public TwilioApplicationList getApplications() {
        return this.getApplications(new Map<String, String>());
    }

    /**
     * Returns a list of Applications in this account, applying the supplied filters.
     * See http://www.twilio.com/docs/api/rest/applications
     */
    public TwilioApplicationList getApplications(Map<String, String> filters) {
        TwilioApplicationList twlist = new TwilioApplicationList(this.getClient(), filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }
    
    /**
     * Returns a given Application instance by sid.
     */
    public TwilioApplication getApplication(String sid) {
        TwilioApplication app = new TwilioApplication(this.getClient(), sid);
        app.setRequestAccountSid(this.getRequestAccountSid());
        return app;
    }
    
    /**
     * Returns the available phone numbers. Defaults to US/Local.
     * See http://www.twilio.com/docs/api/rest/available-phone-numbers
     */
    public TwilioAvailablePhoneNumberList getAvailablePhoneNumbers() {
        return this.getAvailablePhoneNumbers(new Map<String, String>());
    }

    /**
     * Returns the available phone numbers. With the given search filters. Defaults
     * to US/Local numbers.
     * See http://www.twilio.com/docs/api/rest/available-phone-numbers
     */
    public TwilioAvailablePhoneNumberList getAvailablePhoneNumbers(Map<String, String> filters) {
        TwilioAvailablePhoneNumberList twlist = new TwilioAvailablePhoneNumberList(
                this.getClient(), filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }

    /**
     * Returns the available phone numbers with the given iso country and type.
     * See http://www.twilio.com/docs/api/rest/available-phone-numbers
     * 
     * @param filters
     *            the filters
     * @param isoCountry
     *            the Iso Country code you are searching in
     * @param type
     *            the type of phone number. Possible values are
     *            AvailablePhoneNumber.TYPE_LOCAL or
     *            AvailablePhoneNumber.TYPE_TOLLFREE
     * 
     * @return the available phone numbers
     */
    public TwilioAvailablePhoneNumberList getAvailablePhoneNumbers(
            Map<String, String> filters, String isoCountry, String type) {
        TwilioAvailablePhoneNumberList twlist = new TwilioAvailablePhoneNumberList(
                this.getClient(), filters, isoCountry, type);
        twlist.setRequestAccountSid(this.getRequestAccountSid());

        return twlist;
    }

    /**
     * Returns the conference list.
     * See http://www.twilio.com/docs/api/rest/conference
     */
    public TwilioConferenceList getConferences() {
        return this.getConferences(new Map<String, String>());
    }

    /**
     * Returns the conferences list with the given filters.
     * See http://www.twilio.com/docs/api/rest/conference
     */
    public TwilioConferenceList getConferences(Map<String, String> filters) {
        TwilioConferenceList twlist = new TwilioConferenceList(this.getClient(), filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }
    
    /**
     * Returns a given conference instance by sid.
     */
    public TwilioConference getConference(String sid) {
        TwilioConference conf = new TwilioConference(this.getClient(), sid);
        conf.setRequestAccountSid(this.getRequestAccountSid());
        return conf;
    }
    
    /**
     * Get the participant list
     * 
     * @return
     */
    public TwilioParticipantList getParticipants(String conferenceSid) {
        TwilioParticipantList twlist = new TwilioParticipantList(this.getClient(), conferenceSid);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }

    /**
     * Returns the incoming phone numbers list.
     * See http://www.twilio.com/docs/api/rest/incoming-phone-numbers
     */
    public TwilioIncomingPhoneNumberList getIncomingPhoneNumbers() {
        return this.getIncomingPhoneNumbers(new Map<String, String>());
    }

    /**
     * Returns the incoming phone numbers list with the given filters.
     * See http://www.twilio.com/docs/api/rest/incoming-phone-numbers
     */
    public TwilioIncomingPhoneNumberList getIncomingPhoneNumbers(
            Map<String, String> filters) {
        TwilioIncomingPhoneNumberList twlist = new TwilioIncomingPhoneNumberList(
                this.getClient(), filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }
    
    /**
     * Returns a given incoming phone number instance by sid.
     */
    public TwilioIncomingPhoneNumber getIncomingPhoneNumber(String sid) {
        TwilioIncomingPhoneNumber pn = new TwilioIncomingPhoneNumber(this.getClient(), sid);
        pn.setRequestAccountSid(this.getRequestAccountSid());
        return pn;
    }
    
    /**
     * Returns the Short Code list.
     */
    public TwilioShortCodeList getShortCodes() {
        return this.getShortCodes(new Map<String, String>());
    }

    /**
     * Returns the Short Code list with filters.
     */
    public TwilioShortCodeList getShortCodes(Map<String, String> filters) {
        TwilioShortCodeList twlist = new TwilioShortCodeList(this.getClient(), filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }

    /**
     * Returns a given Short Code instance by sid.
     */
    public TwilioShortCode getShortCode(String sid) {
        TwilioShortCode sc = new TwilioShortCode(this.getClient(), sid);
        sc.setRequestAccountSid(this.getRequestAccountSid());
        return sc;
    }
    
    /**
     * Returns the notifications.
     * 
     * @return the notifications
     */
    public TwilioNotificationList getNotifications() {
        return this.getNotifications(new Map<String, String>());
    }

    /**
     * Returns the notifications.
     */
    public TwilioNotificationList getNotifications(Map<String, String> filters) {
        TwilioNotificationList twlist = new TwilioNotificationList(this.getClient(), filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }

    /**
     * Returns a given notification instance by sid
     */
    public TwilioNotification getNotification(String sid) {
        TwilioNotification n = new TwilioNotification(this.getClient(), sid);
        n.setRequestAccountSid(this.getRequestAccountSid());
        return n;
    }

    /**
     * Returns the outgoing caller ids.
     * See http://www.twilio.com/docs/api/rest/outgoing-caller-ids
     */
    public TwilioOutgoingCallerIdList getOutgoingCallerIds() {
        return this.getOutgoingCallerIds(null);
    }

    /**
     * Returns the outgoing caller ids.
     * See http://www.twilio.com/docs/api/rest/outgoing-caller-ids
     */
    public TwilioOutgoingCallerIdList getOutgoingCallerIds(Map<String, String> filters) {
        TwilioOutgoingCallerIdList twlist;
        if (filters==null) {
            twlist = new TwilioOutgoingCallerIdList(this.getClient());
        } else {
            twlist = new TwilioOutgoingCallerIdList(this.getClient(), filters);
        }
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }

    /**
     * Returns a given outgoing caller id instance by sid.
     */
    public TwilioOutgoingCallerId getOutgoingCallerId(String sid) {
        TwilioOutgoingCallerId cid = new TwilioOutgoingCallerId(this.getClient(), sid);
        cid.setRequestAccountSid(this.getRequestAccountSid());
        return cid;
    }
    
    
    /**
     * Returns the recordings list.
     * See http://www.twilio.com/docs/api/rest/recording
     */
    public TwilioRecordingList getRecordings() {
        return this.getRecordings(new Map<String, String>());
    }

    /**
     * Returns the recordings list.
     * See http://www.twilio.com/docs/api/rest/recording
     */
    public TwilioRecordingList getRecordings(Map<String, String> filters) {
        TwilioRecordingList twlist = new TwilioRecordingList(this.getClient(), filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }

    /**
     * Returns a given recording instance by sid.
     */
    public TwilioRecording getRecording(String sid) {
        TwilioRecording r = new TwilioRecording(this.getClient(), sid);
        r.setRequestAccountSid(this.getRequestAccountSid());
        return r;
    }
    
    /**
     * Returns the transcriptions list.
     * See http://www.twilio.com/docs/api/rest/transcription
     */
    public TwilioTranscriptionList getTranscriptions() {
        return this.getTranscriptions(new Map<String, String>());
    }

    /**
     * Returns the transcriptions list with the given filters.
     * See http://www.twilio.com/docs/api/rest/transcription
     */
    public TwilioTranscriptionList getTranscriptions(Map<String, String> filters) {
        TwilioTranscriptionList twlist = new TwilioTranscriptionList(this.getClient(),
                filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }
    
    /**
     * Returns a given transcription instance by sid
     */
    public TwilioTranscription getTranscription(String sid) {
        TwilioTranscription tr = new TwilioTranscription(this.getClient(), sid);
        tr.setRequestAccountSid(this.getRequestAccountSid());
        return tr;
    }
    

    /**
     * Returns the connect app list with the given filters.
     * See http://www.twilio.com/docs/api/rest/connect-apps
     */
    public TwilioConnectAppList getConnectApps(Map<String, String> filters) {
        TwilioConnectAppList twlist = new TwilioConnectAppList(this.getClient(),
                filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }
    
    /**
     * Returns a given connect app instance by sid
     */
    public TwilioConnectApp getConnectApp(String sid) {
        TwilioConnectApp cn = new TwilioConnectApp(this.getClient(), sid);
        cn.setRequestAccountSid(this.getRequestAccountSid());
        return cn;
    }
    
    /**
     * Returns the connect app list with the given filters.
     * See http://www.twilio.com/docs/api/rest/connect-apps
     */
    public TwilioAuthorizedConnectAppList getAuthorizedConnectApps(Map<String, String> filters) {
        TwilioAuthorizedConnectAppList twlist = new TwilioAuthorizedConnectAppList(this.getClient(),
                filters);
        twlist.setRequestAccountSid(this.getRequestAccountSid());
        return twlist;
    }
    
    /**
     * Returns a given connect app instance by sid.
     */
    public TwilioAuthorizedConnectApp getAuthorizedConnectApp(String sid) {
        TwilioAuthorizedConnectApp cn = new TwilioAuthorizedConnectApp(this.getClient(), sid);
        cn.setRequestAccountSid(this.getRequestAccountSid());
        return cn;
    }
    
    /**
     * Returns the developer sandbox.
     */
    public TwilioSandbox getSandbox() {
        TwilioSandbox sb = new TwilioSandbox(this.getClient());
        sb.setRequestAccountSid(this.getRequestAccountSid());
        return sb;
    }
}