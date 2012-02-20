==========
Quickstart
==========

Getting started with the Twilio API couldn't be easier. Create a Twilio REST client to get started. For example, the following code makes a call using the Twilio REST API.

Make a Call
===========

.. code-block:: none

    // To find these visit https://www.twilio.com/user/account
    String account = 'ACXXXXXXXXXXXXXXXXX';
    String token = 'YYYYYYYYYYYYYYYYYY';
    
    TwilioRestClient client = new TwilioRestClient(account, token);
    
    Map<String,String> params = new Map<String,String> {
            'to'   => '9991231234',
            'from' => '9991231234',
            'url' => 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.ambient'
        };
    TwilioCall call = client.getAccount().getCalls().createCall(params);
    System.debug(call.getSid());

Send an SMS
===========

.. code-block:: none

    String account = 'ACXXXXXXXXXXXXXXXXX';
    String token = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(account, token);
    
    Map<String,String> params = new Map<String,String> {
            'to'   => '+12316851234',
            'from' => '+15555555555',
            'body' => 'Hello there!'
        };
    TwilioSMS sms = client.getAccount().getSMSMessages().createSMS(params);

Generate TwiML
==============

To control phone calls, your application needs to output `TwiML <http://www.twilio.com/docs/api/twiml/>`_. Use :class:`TwilioTwiML.Response` to easily create such responses.

.. code-block:: none

    TwilioTwiML.Response r = new TwilioTwiML.Response();
    TwilioTwiML.Play p = new TwilioTwimL.Play('https://api.twilio.com/cowbell.mp3');
    p.setLoop(5);
    r.append(p);
    System.debug(r.toXML());

.. code-block:: xml

    <Response><Play loop="5">https://api.twilio.com/cowbell.mp3</Play><Response>




Dig Deeper
==========

The full power of the Twilio API is at your fingertips. The :ref:`user-guide` explains all the awesome features available to use.
