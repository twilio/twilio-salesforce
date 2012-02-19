.. _usage-twiml:

==================
Working with TwiML
==================

TwiML controls live phone calls and respond to text messages in real time through Twilio's API.

When an SMS or incoming call is received, Twilio asks your web application for instructions by making an HTTP request. Your application decides how the call should proceed by returning a Twilio Markup XML (TwiML) document telling Twilio to say text to the caller, send an SMS message, play audio files, get input from the keypad, record audio, connect the call to another phone and more.

Using the Twilio Helper Library for Salesforce, you can create TwiML documents in Apex using the classes defined in :class:`TwilioTwiML`.

TwiML creation begins with the :class:`TwilioTwiML.Response` verb. Each successive verb is created by adding additional verbs such as :class:`Say` or :class:`Play` to the response using :meth:`append`. To finish, call the :meth:`toXML` method on :class:`Response`, which returns raw TwiML.

.. code-block:: none

    TwilioTwiML.Response r = new TwilioTwiML.Response();
    r.append(new TwilioTwiML.Say('Hello'));
    System.debug(r.toXML());

.. code-block:: xml

   <Response><Say>Hello</Say><Response>


When you need to set attributes on the verbs (outlined in the :doc:`complete reference </api/twiml>`), instantiate the verb class and set its properties before appending it to the response.

.. code-block:: none
   
    TwilioTwiML.Response r = new TwilioTwiML.Response();
    TwilioTwiML.Play p = new TwilioTwimL.Play('https://api.twilio.com/cowbell.mp3');
    p.setLoop(5);
    r.append(p);
    System.debug(r.toXML());

.. code-block:: xml

    <Response><Play loop="3">https://api.twilio.com/cowbell.mp3</Play><Response>

You can provide multiple actions in sequence simply by appending more verbs to the response. Some verbs can be nested inside other verbs, like :class:`Say` inside of :class:`Gather`.

.. code-block:: none

    TwilioTwiML.Response r = new TwilioTwiML.Response();
    r.append(new TwilioTwiML.Say('Hello'));
    TwilioTwiML.Gather g = new TwilioTwiML.Gather();
    g.setFinishOnKey('4');
    g.append(new TwilioTwiML.Say('World');
    r.append(g);    
    System.debug(r.toXML());

which returns the following (excluding linebreaks)

.. code-block:: xml

    <Response>
      <Say>Hello</Say>
      <Gather finishOnKey="4"><Say>World</Say></Gather>
    </Response>

More Information
----------------

The complete list of TwiML verbs and attributes is available in the library's :doc:`TwiML reference </api/twiml>` and in the `Twilio docs <http://www.twilio.com/docs/api/twiml>`_.
