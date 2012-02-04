global class TwilioCall extends TwilioResource.InstanceResource {
	
	/** The Constant SID_PROPERTY. */
	private static final String SID_PROPERTY = 'sid';
	
	/**
	 * Instantiates a new call.
	 *
	 * @param client the client
	 */
	 /*
	// never used
	public TwilioCall(TwilioRestClient client) {
    	super(client);
        //this.subresource_uris = new Map<String,String>(); // TODO use or delete 
    }
    */
    
    /**
	 * Instantiates a new call.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioCall(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty(SID_PROPERTY, sid);
	}

	/**
	 * Instantiates a new call.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioCall(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/**
	 * Gets the resource location.
	 *
	 * @return the resource location
	 *    
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Calls/' + this.getSid()
				+ '.json';
	}
	
	/** 
	 * Gets the sid.
	 * 
	 * @return the sid
	 */
	public String getSid() {
		return this.getProperty(SID_PROPERTY);
	}
	
	/**
	 * Gets the parent call sid.
	 *
	 * @return the parent call sid
	 */
	public String getParentCallSid() {
		return this.getProperty('parent_call_sid');
	}

	/**
	 * Gets the date created.
	 *
	 * @return the date created
	 */
	public Datetime getDateCreated() {
		return this.getPropertyDatetime('date_created');
	}

	/**
	 * Gets the date updated.
	 *
	 * @return the date updated
	 */
	public Datetime getDateUpdated() {
		return this.getPropertyDatetime('date_updated');
	}

	/**
	 * Gets the account sid.
	 *
	 * @return the account sid
	 */
	public String getAccountSid() {
		return this.getProperty('account_sid');
	}

	/**
	 * Gets the to.
	 *
	 * @return the to
	 */
	public String getTo() {
		return this.getProperty('to');
	}

	/**
	 * Gets the from.
	 *
	 * @return the from
	 */
	public String getFrom() {
		return this.getProperty('from');
	}

	/**
	 * Gets the phone number sid.
	 *
	 * @return the phone number sid
	 */
	public String getPhoneNumberSid() {
		return this.getProperty('phone_number_sid');
	}

	/**
	 * Gets the status.
	 *
	 * @return the status
	 */
	public String getStatus() {
		return this.getProperty('status');
	}

	/**
	 * Gets the start time.
	 *
	 * @return the start time
	 */
	public Datetime getStartTime() {
		return this.getPropertyDatetime('start_time');
	}

	/**
	 * Gets the end time.
	 *
	 * @return the end time
	 */
	public Datetime getEndTime() {
		return this.getPropertyDatetime('end_time');
	}

	/**
	 * Gets the duration.
	 *
	 * @return the duration
	 */
	public Integer getDuration() {
		return this.getPropertyInteger('duration');
	}

	/**
	 * Gets the price.
	 *
	 * @return the price
	 */
	public Decimal getPrice() {
		return this.getPropertyDecimal('price');
	}

	/**
	 * Gets the direction.
	 *
	 * @return the direction
	 */
	public String getDirection() {
		return this.getProperty('direction');
	}

	/**
	 * Gets the answered by.
	 *
	 * @return the answered by
	 */
	public String getAnsweredBy() {
		return this.getProperty('answered_by');
	}

	/**
	 * Gets the forwarded from.
	 *
	 * @return the forwarded from
	 */
	public String getForwardedFrom() {
		return this.getProperty('forwarded_from');
	}

	/**
	 * Gets the caller name.
	 *
	 * @return the caller name
	 */
	public String getCallerName() {
		return this.getProperty('caller_name');
	}
	
	/*
	 * 
	 * Useful functions
	 */
	/**
	 * Redirect.
	 *
	 * @param url the url
	 * @param method the method
	 * @return the call
	 * @throws TwilioRestException the twilio rest exception
	 */
	 /* shs */
	public TwilioCall redirect(String url, String method) {
		Map<String, String> vars = new Map<String, String>{
			'Method' => method,
			'Url' => url};
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioCall c = new TwilioCall(this.getClient(), response.toMap());
		c.setRequestAccountSid(this.getRequestAccountSid());
		return c;
	}
	
	/**
	 * Hangup.
	 *
	 * @return the call
	 * @throws TwilioRestException the twilio rest exception
	 */
	public TwilioCall hangup() {
		Map<String, String> vars = new Map<String, String>();
		vars.put('Status', 'completed');

		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioCall c = new TwilioCall(this.getClient(), response.toMap());
		c.setRequestAccountSid(this.getRequestAccountSid());
		return c;
	}

	/**
	 * Cancel.
	 *
	 * @return the call
	 * @throws TwilioRestException the twilio rest exception
	 */
	public TwilioCall cancel() {
		Map<String, String> vars = new Map<String, String>();
		vars.put('Status', 'canceled');

		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioCall c = new TwilioCall(this.getClient(), response.toMap());
		c.setRequestAccountSid(this.getRequestAccountSid());
		return c;
	}

	
	
	
	
	/*
	// TODO use or delete
	protected Set<string> SubresourceKeys = new Set<string>{
	       'available_phone_numbers',
	       'calls',
	       'conferences',
	       'incoming_phone_numbers',
	       'notifications',
	       'outgoing_caller_ids',
	       'recordings',
	       'sandbox',
	       'sms_messages',
	       'transcriptions'       
	 };
	 */
}