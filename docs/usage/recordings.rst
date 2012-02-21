================
Recordings
================

For more information, see the `Recordings REST Resource <http://www.twilio.com/docs/api/rest/recording>`_ documentation.

Listing Your Recordings
----------------------------

The following code will print out the :attr:`duration` for each :class:`TwilioRecording`.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    for (TwilioRecording rec : client.getAccount().getRecordings().getPageData()) {
    	System.debug(rec.getDuration());
    }

You can filter recordings by the Call by passing the sid as :attr:`CallSid`, or you can filter by :attr:`DateCreated`.

The following will only show recordings made on January 1, 2012.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> filters = new Map<String,String> {
    		'DateCreated' => TwilioParser.formatFilterDatetime(2012,1,1)
    	};
    for (TwilioRecording rec : client.getAccount().getRecordings(filters).getPageData()) {
    	System.debug(rec.getDuration());
    }

Deleting Recordings
---------------------

The :class:`TwilioRecordingList` resource allows you to delete unnecessary recordings.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    client.getAccount().getRecordings().deleteResource("RC123");

Audio Formats
-----------------

Each :class:`TwilioRecording` can return the the URI to the recorded audio in WAV or MP3 format.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    TwilioRecording rec = client.getRecording("RC123");
    System.debug(rec.getWavUri());
    System.debug(rec.getMp3Uri());


Accessing Related Transcriptions
--------------------------------

The :class:`TwilioRecording` resource provides access to transcriptions generated from the recording (if any). The following code prints out the text for each of the transcriptions associated with this recording.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    recording = client.getRecording("RC123");
    for (TwilioTranscription t : recording.getTranscriptions().getPageData()) {
        System.debug(t.getTranscriptionText());
    }

