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
 * The class TwilioParticipantList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/participant
 */
global class TwilioParticipantList extends TwilioResource.ListResource
	implements Iterable<TwilioParticipant> {
	
	/** The conference sid. */
	private String conferenceSid;

	/**
	 * Instantiates a new participant list.
	 *
	 * @param client the client
	 */
	public TwilioParticipantList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new participant list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioParticipantList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/**
	 * Instantiates a new participant list.
	 *
	 * @param client the client
	 * @param conferenceSid the conference sid
	 */
	public TwilioParticipantList(TwilioRestClient client, String conferenceSid) {
		super(client);
		this.conferenceSid = conferenceSid;
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Conferernces/'
				+ this.conferenceSid + '/Participants.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioParticipant(client, params);
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'participants';
	}
	
	public List<TwilioParticipant> getPageData() {
		List<TwilioParticipant> returnList = new List<TwilioParticipant>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioParticipant) {
				returnList.add((TwilioParticipant) o);
			}
		}
		return returnList;
	}
	
	global Iterator<TwilioParticipant> iterator() {
		return new TwilioIterator.ParticipantIterator(this);
	}
}