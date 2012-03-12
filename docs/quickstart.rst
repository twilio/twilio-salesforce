==========
Quickstart
==========

Getting started with the Twilio API couldn't be easier. Create a Twilio REST client to get started. For example, the following code makes a call using the Twilio REST API.

Make a Call
===========

This sample calls the `to` phone number and plays music.  The `from` number must be a `verified number <https://www.twilio.com/user/account/phone-numbers/verified>`_ on your Twilio account.

.. code-block:: javascript

    // To find these visit https://www.twilio.com/user/account
    String account = 'ACXXXXXXXXXXXXXXXXX';
    String token = 'YYYYYYYYYYYYYYYYYY';
    
    TwilioRestClient client = new TwilioRestClient(account, token);
    
    Map<String,String> params = new Map<String,String> {
            'To'   => '9991231234',
            'From' => '9991231234',
            'Url' => 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.ambient'
        };
    TwilioCall call = client.getAccount().getCalls().create(params);

Send an SMS
===========

This sample texts *Hello there!* to the `to` phone number.  The `from` number must be a `verified number <https://www.twilio.com/user/account/phone-numbers/verified>`_ on your Twilio account.

.. code-block:: javascript

    String account = 'ACXXXXXXXXXXXXXXXXX';
    String token = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(account, token);
    
    Map<String,String> params = new Map<String,String> {
            'To'   => '+12316851234',
            'From' => '+15555555555',
            'Body' => 'Hello there!'
        };
    TwilioSMS sms = client.getAccount().getSMSMessages().create(params);

Generate TwiML
==============

To control phone calls, your application needs to output `TwiML <http://www.twilio.com/docs/api/twiml/>`_. Use :class:`TwilioTwiML.Response` to easily create a TwiML document.

.. code-block:: javascript

    TwilioTwiML.Response r = new TwilioTwiML.Response();
    TwilioTwiML.Play p = new TwilioTwiML.Play('https://api.twilio.com/cowbell.mp3');
    p.setLoop(5);
    r.append(p);
    System.debug(r.toXML());

.. code-block:: xml

    <Response><Play loop="5">https://api.twilio.com/cowbell.mp3</Play><Response>



Next Steps
==========

The full power of the Twilio API is at your fingertips. The :ref:`user-guide` explains all the awesome features available to use.
