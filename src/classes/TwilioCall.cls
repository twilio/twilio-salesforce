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
global class TwilioCall extends TwilioResource.InstanceResource {
	
	/**
	 * Instantiates a new call.
	 *
	 * @param client the client
	 */
	public TwilioCall(TwilioRestClient client) {
    	super(client);
    }
    
    /**
	 * Instantiates a new call.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioCall(TwilioRestClient client, String sid) {
		super(client);
		this.setProperty('sid', sid);
	}

	/**
	 * Instantiates a new call.
	 *
	 * @param client  the client
	 * @param properties  properties to set on the new call as key/value pairs
	 */
	public TwilioCall(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/**
	 * Returns the URI of this resource, relative to the API endpoint.
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Calls/' + this.getSid()
				+ '.json';
	}
	
	/** 
	 * Returns the unique ID of this resource.
	 */
	public String getSid() {
		return this.getProperty('sid');
	}
	
	/**
	 * Returns the parent call sid.
	 */
	public String getParentCallSid() {
		return this.getProperty('parent_call_sid');
	}

	/**
	 * Returns the date created.
	 */
	public Datetime getDateCreated() {
		return this.getPropertyDatetime('date_created');
	}

	/**
	 * Returns the date updated.
	 */
	public Datetime getDateUpdated() {
		return this.getPropertyDatetime('date_updated');
	}

	/**
	 * Returns the account sid.
	 */
	public String getAccountSid() {
		return this.getProperty('account_sid');
	}

	/**
	 * Gets the to phone number.
	 */
	public String getTo() {
		return this.getProperty('to');
	}

	/**
	 * Returns the from phone number.
	 */
	public String getFrom() {
		return this.getProperty('from');
	}

	/**
	 * Returns the phone number sid.
	 */
	public String getPhoneNumberSid() {
		return this.getProperty('phone_number_sid');
	}

	/**
	 * Returns the status.
	 */
	public String getStatus() {
		return this.getProperty('status');
	}

	/**
	 * Returns the start time.
	 */
	public Datetime getStartTime() {
		return this.getPropertyDatetime('start_time');
	}

	/**
	 * Returns the end time.
	 */
	public Datetime getEndTime() {
		return this.getPropertyDatetime('end_time');
	}

	/**
	 * Returns the duration.
	 */
	public Integer getDuration() {
		return this.getPropertyInteger('duration');
	}

	/**
	 * Returns the price.
	 */
	public Decimal getPrice() {
		return this.getPropertyDecimal('price');
	}

	/**
	 * Returns the direction.
	 */
	public String getDirection() {
		return this.getProperty('direction');
	}

	/**
	 * Gets the answered by phone number.
	 */
	public String getAnsweredBy() {
		return this.getProperty('answered_by');
	}

	/**
	 * Returns the forwarded from phone number.
	 */
	public String getForwardedFrom() {
		return this.getProperty('forwarded_from');
	}
	
	/**
	 * Returns the Twilio URI for this resource.
	 */
	public String getUri() {
		return this.getProperty('uri');
	}

	/**
	 * Returns the caller name.
	 */
	public String getCallerName() {
		return this.getProperty('caller_name');
	}
	
	public TwilioNotificationList getNotifications() {
		TwilioNotificationList twlist = new TwilioNotificationList((TwilioRestClient)this.getClient(), this.getSid());
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}
	
	public TwilioRecordingList getRecordings() {
		TwilioRecordingList twlist = new TwilioRecordingList((TwilioRestClient)this.getClient(), this.getSid());
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}


	/** Returns the SubresourceUris */
	public Map<String,Object> getSubresourceUris() {
		return (Map<String,Object>)this.getObject('subresource_uris');
	}
	
	/* Convenience methods */

	/**
	 * Redirect.
	 *
	 * @param url the url
	 * @param method the method
	 * @return the call
	 */
	public TwilioCall redirect(String url, String method) {
		Map<String, String> vars = new Map<String, String>{
			'Method' => method,
			'Url' => url};
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioCall c = new TwilioCall((TwilioRestClient)this.getClient(), response.toMap());
		c.setRequestAccountSid(this.getRequestAccountSid());
		return c;
	}
	
	/**
	 * Hangup.
	 *
	 * @return the call
	 */
	public TwilioCall hangup() {
		Map<String, String> vars = new Map<String, String>();
		vars.put('Status', 'completed');

		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioCall c = new TwilioCall((TwilioRestClient)this.getClient(), response.toMap());
		c.setRequestAccountSid(this.getRequestAccountSid());
		return c;
	}

	/**
	 * Cancel.
	 *
	 * @return the call
	 */
	public TwilioCall cancel() {
		Map<String, String> vars = new Map<String, String>();
		vars.put('Status', 'canceled');

		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioCall c = new TwilioCall((TwilioRestClient)this.getClient(), response.toMap());
		c.setRequestAccountSid(this.getRequestAccountSid());
		return c;
	}

	/**
	 * Delete this Call. This will remove it from your
	 * account.
	 * 
	 * @throws TwilioRestException
	 *             if there is an error in the request
	 * @return true, if successful
	 * 
	 */
	public boolean deleteCall() {
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'DELETE', null);
		
		return !response.isError();
	}

}