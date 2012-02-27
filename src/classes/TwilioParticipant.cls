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
 * The class TwilioParticipant.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/participant
 */
global class TwilioParticipant extends TwilioResource.InstanceResource {
	/** The Constant CALL_SID_PROPERTY. */
	private static final String CALL_SID_PROPERTY = 'call_sid';
	
	/** The Constant CONFERENCE_SID_PROPERTY. */
	private static final String CONFERENCE_SID_PROPERTY = 'conference_sid';

	/**
	 * Instantiates a new participant.
	 *
	 * @param client the client
	 */
	public TwilioParticipant(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new participant.
	 *
	 * @param client the client
	 * @param conferenceSid the conference sid
	 * @param callSid the call sid
	 */
	public TwilioParticipant(TwilioRestClient client, String conferenceSid,
			String callSid) {
		super(client);
		this.setProperty(CONFERENCE_SID_PROPERTY, conferenceSid);
		this.setProperty(CALL_SID_PROPERTY, callSid);
	}

	/**
	 * Instantiates a new participant.
	 *
	 * @param client the client
	 * @param properties the properties
	 */
	public TwilioParticipant(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/* see TwilioResource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Conferences/'
				+ this.getConferenceSid() + '/Participants/'
				+ this.getCallSid() + '.json';
	}

	/*
	 * Property getters
	 */

	/**
	 * Gets the conference sid.
	 *
	 * @return the conference sid
	 */
	public String getConferenceSid() {
		return this.getProperty(CONFERENCE_SID_PROPERTY);
	}

	/**
	 * Gets the call sid.
	 *
	 * @return the call sid
	 */
	public String getCallSid() {
		return this.getProperty(CALL_SID_PROPERTY);
	}

	/* DateCreated field accessor */
	public Datetime getDateCreated() {
		return this.getPropertyDatetime('date_created');
	}

	/* DateUpdated field accessor */
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
	 * Gets the Twilio URI for this resource.
	 *
	 * @return the resource URI
	 */
	public String getUri() {
		return this.getProperty('uri');
	}
	
	/**
	 * Checks if is muted.
	 *
	 * @return true, if is muted
	 */
	public boolean isMuted() {
		return Boolean.valueOf(this.getProperty('muted'));
	}
	
	/**
	 * Checks if is start conference on enter.
	 *
	 * @return true, if is start conference on enter
	 */
	public boolean isStartConferenceOnEnter() {
		return Boolean.valueOf(this.getProperty('start_conference_on_enter'));
	}
	
	/**
	 * Checks if is end conference on exit.
	 *
	 * @return true, if is end conference on exit
	 */
	public boolean isEndConferenceOnExit() {
		return Boolean.valueOf(this.getProperty('end_conference_on_exit'));
	}
	
	/*
	 * Helper functions
	 * 
	 * 
	 */
	
	
	/**
	 * Mute.
	 *
	 * @return the participant
	 * @throws TwilioRestException the twilio rest exception
	 */
	public TwilioParticipant mute() {
		Map<String, String> vars = new Map<String, String>();
		vars.put('Muted', 'true');

		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioParticipant p = new TwilioParticipant(this.getClient(), response.toMap());
		p.setRequestAccountSid(this.getRequestAccountSid());
		return p;
	}

	/**
	 * Unmute.
	 *
	 * @return the participant
	 * @throws TwilioRestException the twilio rest exception
	 */
	public TwilioParticipant unmute() {
		Map<String, String> vars = new Map<String, String>();
		vars.put('Muted', 'false');

		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioParticipant p = new TwilioParticipant(this.getClient(), response.toMap());
		p.setRequestAccountSid(this.getRequestAccountSid());
		return p;
	}

	/**
	 * Kick.
	 *
	 * @return true, if successful
	 * @throws TwilioRestException the twilio rest exception
	 */
	public Boolean kick() {
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'DELETE', null);

		return !response.isError();
	}
}