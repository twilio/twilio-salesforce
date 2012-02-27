==============================
Conferences and Participants
==============================

For more information, see the `Conference REST Resource <http://www.twilio.com/docs/api/rest/conference>`_ and `Participant REST Resource <http://www.twilio.com/docs/api/rest/conference>`_ documentation.

Listing Conferences
-----------------------

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    TwilioConferenceList confs = client.getAccount().getConferences();
    for (TwilioConference conference : confs.getPageData()) {
	    System.debug(conference.getSid());
    }

Filtering Conferences
-----------------------

The Twilio API supports filtering *Conferences* on :attr:`Status`, :attr:`DateUpdated`, :attr:`DateCreated` and :attr:`FriendlyName`. The following code will return a list of all active conferences and print their friendly name.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> filters = new Map<String,String> {
    		'Status' => 'active'
    	};
    TwilioConferenceList confs = client.getAccount().getConferences(filters);
    for (TwilioConference conference : confs.getPageData()) {
    	System.debug(conference.getFriendlyName());
    }


Listing Participants
----------------------

Each :class:`TwilioConference` has a :meth:`getParticipants` method which represents all current users in the conference

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    TwilioConference conference = client.getAccount().getConference("CF123");
    for (TwilioParticipant p : conference.getParticipants().getPageData()) {
    	System.debug(p.getSid());
    }

Managing Participants
----------------------

Each :class:`TwilioConference` has a :attr:`participants` function that returns a
:class:`TwilioParticipantList` resource. This behavior differs from other list resources
because :class:`TwilioParticipant` needs a participant sid AND a conference sid to
access the participants resource.

Participants can be either muted or kicked out of the conference. The following
code kicks out the first participant and mutes the others.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    String conferenceSid = 'CF123';
    Iterator<TwilioParticipants> participants =
    		client.getAccount().getParticipants(conferenceSid).iterator();

    if (!participants.hasNext())
        return;

	# Kick the first person out
    participants.next().kick();

    # And mute the rest
    while (participants.hasNext()) {
        participants.next().mute();
    }

