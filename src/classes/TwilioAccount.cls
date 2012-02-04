/*
 * The Account class, representing a Twilio customer account. For more information see http://www.twilio.com/docs/api/rest/account
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
	
	/* ConnectAppSid field accessor */
	public String getConnectAppSid() {
		return this.getProperty(CONNECT_APP_SID_PROPERTY);
	}
	
	/* OwnerAccountSid field accessor */
	public String getOwnerAccountSid() {
		return this.getProperty(OWNER_ACCOUNT_SID_PROPERTY);
	}

	/* AuthToken field accessor */
	public String getAuthToken() {
		return this.getProperty(AUTH_TOKEN_PROPERTY);
	}

	/* AuthToken field accessor */
	public void setAuthToken(String authToken) {
		this.setProperty(AUTH_TOKEN_PROPERTY, authToken);
	}

	/* FriendlyName field accessor */
	public String getFriendlyName() {
		return this.getProperty(FRIENDLY_NAME_PROPERTY);
	}

	/* Status field accessor */
	public String getStatus() {
		return this.getProperty(STATUS_PROPERTY);
	}

	/* DateCreated field accessor */
	public Datetime getDateCreated() {
		return this.getPropertyDatetime(DATE_CREATED_PROPERTY);
	}

	/* DateUpdated field accessor */
	public Datetime getDateUpdated() {
		return this.getPropertyDatetime(DATE_UPDATED_PROPERTY);
	}
	 
	/* Type field accessor */
	public String getType() {
		return this.getProperty(TYPE_PROPERTY);
	}
	
	/* SubresourceUris field accessor */
	public Map<String,Object> getSubresourceUris() {
		return (Map<String,Object>)this.getObject('subresource_uris');
	}

	/* Constructs a Twilio API resource URI for this Account. Overrides method from TwilioResource. */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '.json';
	}


	/**** Subresource methods ****/

	/* Gets the calls list resource without any filters.
	 * See http://www.twilio.com/docs/api/rest/call
	 */
	public TwilioCallList getCalls() {
		return this.getCalls(new Map<String, String>());
	}

	/* Gets the calls list resource with the given filters.
	 * See http://www.twilio.com/docs/api/rest/call
	 */
	public TwilioCallList getCalls(Map<String, String> filters) {
		TwilioCallList calls = new TwilioCallList(this.getClient(), filters);
		calls.setRequestAccountSid(this.getRequestAccountSid());
		
		return calls;
	}
	
	/**
	 * Get a given call instance by sid
	 * @param sid The 34 character sid starting with CA
	 * @return
	 */
	public TwilioCall getCall(String sid) {
		TwilioCall call = new TwilioCall(this.getClient(), sid);
		call.setRequestAccountSid(this.getRequestAccountSid());
		return call;
	}


	/**
	 * Gets the sms message list.
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/sms">http://www.twilio.com/docs/api/rest/sms</a>}
	 * 
	 * @return the sms messages
	 */
	public TwilioSmsList getSmsMessages() {
		return this.getSmsMessages(new Map<String, String>());
	}

	/**
	 * Gets the sms messages list with the given filters
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/sms">http://www.twilio.com/docs/api/rest/sms</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the sms messages
	 */
	public TwilioSmsList getSmsMessages(Map<String, String> filters) {
		TwilioSmsList sms = new TwilioSmsList(this.getClient(), filters);
		sms.setRequestAccountSid(this.getRequestAccountSid());

		return sms;
	}
	
	/**
	 * Get a given sms instance by sid
	 * @param sid The 34 character sid starting with SM
	 * @return
	 */
	public TwilioSms getSms(String sid) {
		TwilioSms sms = new TwilioSms(this.getClient(), sid);
		sms.setRequestAccountSid(this.getRequestAccountSid());
		return sms;
	}
	
	/**
	 * Gets the application list
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/applications">http://www.twilio.com/docs/api/rest/applications</a>}
	 * @return the applications
	 */
	public TwilioApplicationList getApplications() {
		return this.getApplications(new Map<String, String>());
	}

	/**
	 * Gets the application list with the given filters
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/applications">http://www.twilio.com/docs/api/rest/applications</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the applications
	 */
	public TwilioApplicationList getApplications(Map<String, String> filters) {
		TwilioApplicationList twlist = new TwilioApplicationList(this.getClient(), filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}
	
	/**
	 * Get a given application instance by sid
	 * @param sid The 34 character sid starting with AP
	 * @return
	 */
	public TwilioApplication getApplication(String sid) {
		TwilioApplication app = new TwilioApplication(this.getClient(), sid);
		app.setRequestAccountSid(this.getRequestAccountSid());
		return app;
	}
	
	/**
	 * Gets the available phone numbers. Defaults to US/Local
	 * 
	 * See: http://www.twilio.com/docs/api/rest/available-phone-numbers
	 * @return the available phone numbers
	 */
	public TwilioAvailablePhoneNumberList getAvailablePhoneNumbers() {
		return this.getAvailablePhoneNumbers(new Map<String, String>());
	}

	/**
	 * Gets the available phone numbers. With the given search filters. Defaults
	 * to US/Local numbers
	 * 
	 * See: http://www.twilio.com/docs/api/rest/available-phone-numbers
	 * 
	 * @param filters
	 *            the filters
	 * @return the available phone numbers
	 */
	public TwilioAvailablePhoneNumberList getAvailablePhoneNumbers(Map<String, String> filters) {
		TwilioAvailablePhoneNumberList twlist = new TwilioAvailablePhoneNumberList(
				this.getClient(), filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}

	/**
	 * Gets the available phone numbers with the given iso country and type
	 * 
	 * See: http://www.twilio.com/docs/api/rest/available-phone-numbers
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
	 * Gets the conference list
	 * 
	 * See: {@see <a href="http://www.twilio.com/docs/api/rest/conference">http://www.twilio.com/docs/api/rest/conference</a>}
	 * 
	 * @return the conferences
	 */
	public TwilioConferenceList getConferences() {
		return this.getConferences(new Map<String, String>());
	}

	/**
	 * Gets the conferences list with the given filters
	 * 
	 * See: {@see <a href="http://www.twilio.com/docs/api/rest/conference">http://www.twilio.com/docs/api/rest/conference</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the conferences
	 */
	public TwilioConferenceList getConferences(Map<String, String> filters) {
		TwilioConferenceList twlist = new TwilioConferenceList(this.getClient(), filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}
	
	/**
	 * Get a given conference instance by sid
	 * @param sid The 34 character sid starting with CF
	 * @return
	 */
	public TwilioConference getConference(String sid) {
		TwilioConference conf = new TwilioConference(this.getClient(), sid);
		conf.setRequestAccountSid(this.getRequestAccountSid());
		return conf;
	}

	/**
	 * Gets the incoming phone numbers list
	 * 
	 * See: {@see <a href="http://www.twilio.com/docs/api/rest/incoming-phone-nubmers">http://www.twilio.com/docs/api/rest/incoming-phone-numbers</a>}
	 * 
	 * @return the incoming phone numbers
	 */
	public TwilioIncomingPhoneNumberList getIncomingPhoneNumbers() {
		return this.getIncomingPhoneNumbers(new Map<String, String>());
	}

	/**
	 * Gets the incoming phone numbers list with the given filters
	 * 
	 * See: {@see <a href="http://www.twilio.com/docs/api/rest/incoming-phone-nubmers">http://www.twilio.com/docs/api/rest/incoming-phone-numbers</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the incoming phone numbers
	 */
	public TwilioIncomingPhoneNumberList getIncomingPhoneNumbers(
			Map<String, String> filters) {
		TwilioIncomingPhoneNumberList twlist = new TwilioIncomingPhoneNumberList(
				this.getClient(), filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}
	
	/**
	 * Get a given incoming phone number instance by sid
	 * @param sid The 34 character sid starting with PN
	 * @return
	 */
	public TwilioIncomingPhoneNumber getIncomingPhoneNumber(String sid) {
		TwilioIncomingPhoneNumber pn = new TwilioIncomingPhoneNumber(this.getClient(), sid);
		pn.setRequestAccountSid(this.getRequestAccountSid());
		return pn;
	}
	
	/**
	 * Gets the shortcode list.
	 * 
	 * @return the short code list
	 */
	public TwilioShortCodeList getShortCodes() {
		return this.getShortCodes(new Map<String, String>());
	}

	/**
	 * Gets the short code list with filters
	 * 
	 * @param filters
	 *            the filters
	 * @return the short code list
	 */
	public TwilioShortCodeList getShortCodes(Map<String, String> filters) {
		TwilioShortCodeList twlist = new TwilioShortCodeList(this.getClient(), filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}

	/**
	 * Get a given short code instance by sid
	 * @param sid The 34 character sid starting with SC
	 * @return
	 */
	public TwilioShortCode getShortCode(String sid) {
		TwilioShortCode sc = new TwilioShortCode(this.getClient(), sid);
		sc.setRequestAccountSid(this.getRequestAccountSid());
		return sc;
	}
	
	/**
	 * Gets the notifications.
	 * 
	 * @return the notifications
	 */
	public TwilioNotificationList getNotifications() {
		return this.getNotifications(new Map<String, String>());
	}

	/**
	 * Gets the notifications.
	 * 
	 * @param filters
	 *            the filters
	 * @return the notifications
	 */
	public TwilioNotificationList getNotifications(Map<String, String> filters) {
		TwilioNotificationList twlist = new TwilioNotificationList(this.getClient(), filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}

	/**
	 * Get a given notification instance by sid
	 * @param sid The 34 character sid starting with NO
	 * @return
	 */
	public TwilioNotification getNotification(String sid) {
		TwilioNotification n = new TwilioNotification(this.getClient(), sid);
		n.setRequestAccountSid(this.getRequestAccountSid());
		return n;
	}

	/**
	 * Gets the outgoing caller ids.
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/outoing-caller-ids">http://www.twilio.com/docs/api/rest/outgoing-caller-ids</a>}
	 * 
	 * @return the outgoing caller ids
	 */
	public TwilioOutgoingCallerIdList getOutgoingCallerIds() {
		return this.getOutgoingCallerIds(null);
	}

	/**
	 * Gets the outgoing caller ids.
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/outoing-caller-ids">http://www.twilio.com/docs/api/rest/outgoing-caller-ids</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the outgoing caller ids
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
	 * Get a given outgoing caller id instance by sid
	 * @param sid The 34 character sid starting with PN
	 * @return
	 */
	public TwilioOutgoingCallerId getOutgoingCallerId(String sid) {
		TwilioOutgoingCallerId cid = new TwilioOutgoingCallerId(this.getClient(), sid);
		cid.setRequestAccountSid(this.getRequestAccountSid());
		return cid;
	}
	
	
	/**
	 * Gets the recordings list
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/recording">http://www.twilio.com/docs/api/rest/recording</a>}
	 * 
	 * @return the recordings
	 */
	public TwilioRecordingList getRecordings() {
		return this.getRecordings(new Map<String, String>());
	}

	/**
	 * Gets the recordings list 
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/recording">http://www.twilio.com/docs/api/rest/recording</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the recordings
	 */
	public TwilioRecordingList getRecordings(Map<String, String> filters) {
		TwilioRecordingList twlist = new TwilioRecordingList(this.getClient(), filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}

	/**
	 * Get a given recording instance by sid
	 * @param sid The 34 character sid starting with RE
	 * @return
	 */
	public TwilioRecording getRecording(String sid) {
		TwilioRecording r = new TwilioRecording(this.getClient(), sid);
		r.setRequestAccountSid(this.getRequestAccountSid());
		return r;
	}
	
	/**
	 * Gets the transcriptions list
	 * 
	 * {@see <a href="http://www.twilio.com/docs/api/rest/transcription">http://www.twilio.com/docs/api/rest/transcription</a>}
	 * 
	 * @return the transcriptions
	 */
	public TwilioTranscriptionList getTranscriptions() {
		return this.getTranscriptions(new Map<String, String>());
	}

	/**
	 * Gets the transcriptions list with the given filters
	 * 
	 *  {@see <a href="http://www.twilio.com/docs/api/rest/transcription">http://www.twilio.com/docs/api/rest/transcription</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the transcriptions
	 */
	public TwilioTranscriptionList getTranscriptions(Map<String, String> filters) {
		TwilioTranscriptionList twlist = new TwilioTranscriptionList(this.getClient(),
				filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}
	
	/**
	 * Get a given transcription instance by sid
	 * @param sid The 34 character sid starting with TR
	 * @return
	 */
	public TwilioTranscription getTranscription(String sid) {
		TwilioTranscription tr = new TwilioTranscription(this.getClient(), sid);
		tr.setRequestAccountSid(this.getRequestAccountSid());
		return tr;
	}
	

	/**
	 * Gets the connect app list with the given filters
	 * 
	 *  {@see <a href="http://www.twilio.com/docs/api/rest/connect-apps">http://www.twilio.com/docs/api/rest/connect-apps</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the connect app list
	 */
	public TwilioConnectAppList getConnectApps(Map<String, String> filters) {
		TwilioConnectAppList twlist = new TwilioConnectAppList(this.getClient(),
				filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}
	
	/**
	 * Get a given connect app instance by sid
	 * @param sid The 34 character sid starting with CN
	 * @return the connect app
	 */
	public TwilioConnectApp getConnectApp(String sid) {
		TwilioConnectApp cn = new TwilioConnectApp(this.getClient(), sid);
		cn.setRequestAccountSid(this.getRequestAccountSid());
		return cn;
	}
	
	/**
	 * Gets the connect app list with the given filters
	 * 
	 *  {@see <a href="http://www.twilio.com/docs/api/rest/connect-apps">http://www.twilio.com/docs/api/rest/connect-apps</a>}
	 * 
	 * @param filters
	 *            the filters
	 * @return the connect app list
	 */
	public TwilioAuthorizedConnectAppList getAuthorizedConnectApps(Map<String, String> filters) {
		TwilioAuthorizedConnectAppList twlist = new TwilioAuthorizedConnectAppList(this.getClient(),
				filters);
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}
	
	/**
	 * Get a given connect app instance by sid
	 * @param sid The 34 character sid starting with CN
	 * @return the connect app
	 */
	public TwilioAuthorizedConnectApp getAuthorizedConnectApp(String sid) {
		TwilioAuthorizedConnectApp cn = new TwilioAuthorizedConnectApp(this.getClient(), sid);
		cn.setRequestAccountSid(this.getRequestAccountSid());
		return cn;
	}
}