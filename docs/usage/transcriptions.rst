================
Transcriptions
================

Transcriptions are generated from recordings via the `TwiML <Record> verb <http://www.twilio.com/docs/api/twiml/record>`_. Using the API, you can only read your transcription records.

For more information, see the `Transcriptions REST Resource <http://www.twilio.com/docs/api/rest/transcription>`_ documentation.

Listing Your Transcriptions
----------------------------

The following code will print out recording length for each :class:`TwilioTranscription`.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    for (TwilioTranscription t : client.getAccount().getTransactions().getPageData()) {
    	System.debug(t.getDuration());
    }
