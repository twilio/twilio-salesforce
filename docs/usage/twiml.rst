.. _usage-twiml:

==================
Working with TwiML
==================

TwiML controls live phone calls and respond to text messages in real time through Twilio's API.

When an SMS or incoming call is received, Twilio asks your web application for instructions by making an HTTP request. Your application decides how the call should proceed by returning a Twilio Markup XML (TwiML) document telling Twilio to say text to the caller, send an SMS message, play audio files, get input from the keypad, record audio, connect the call to another phone and more.

You can create TwiML documents in Apex using the verb classes defined inside the :class:`TwilioTwiML` class.

Generating TwiML in Apex
========================

TwiML creation begins with the :class:`TwilioTwiML.Response` class. Each successive TwiML command is created by adding additional verb classes such as :class:`Say` or :class:`Play` to the response using :meth:`append`. When your instruction set is complete, call :meth:`Response.toXML` to produce a TwiML document.

.. code-block:: javascript

    TwilioTwiML.Response r = new TwilioTwiML.Response();
    r.append(new TwilioTwiML.Say('Hello'));
    System.debug(r.toXML());

.. code-block:: xml

   <Response>
     <Say>Hello</Say>
   <Response>


Sometimes you'll want to set properties beyond what's covered in the constructor.  In these cases, assign the verb class to its own variable and set its properties before appending it to the response.

.. code-block:: javascript
   
    TwilioTwiML.Response r = new TwilioTwiML.Response();
    TwilioTwiML.Play p = new TwilioTwimL.Play('https://api.twilio.com/cowbell.mp3');
    p.setLoop(5);
    r.append(p);
    System.debug(r.toXML());

.. code-block:: xml

    <Response>
      <Play loop="3">https://api.twilio.com/cowbell.mp3</Play>
    <Response>

You can provide multiple actions in sequence simply by appending more verbs to the response. Some verbs can be nested inside other verbs, like :class:`Say` inside of :class:`Gather`.

.. code-block:: javascript

    TwilioTwiML.Response r = new TwilioTwiML.Response();
    r.append(new TwilioTwiML.Say('Hello'));
    TwilioTwiML.Gather g = new TwilioTwiML.Gather();
    g.setFinishOnKey('4');
    g.append(new TwilioTwiML.Say('World');
    r.append(g);    
    System.debug(r.toXML());

.. code-block:: xml

    <Response>
      <Say>Hello</Say>
      <Gather finishOnKey="4"><Say>World</Say></Gather>
    </Response>


Serving TwiML Requests from a Force.com Site
============================================

#. Log into `Salesforce <https://login.salesforce.com>`_. Go to **Setup | App Setup | Develop | Sites** and create a new site. Set the home page to TwilioSamplePage and add TwilioTestUser to the list of Site Visualforce Pages. Ensure you activate the site.

#. Log into your `Twilio account <https://www.twilio.com/user/account>`_. Go to **Apps** and click **Create TwiML App**.  Set the **Voice Request URL** to your site's secure URL -- for example, https://twiliotest-developer-edition.na14.force.com/

#. TODO: Copy your Twilio API credentials

#. TODO: Test your app

#. Now you have the sample page working, you have a starting point for a TwiML app running on Force.com. Examine TwilioSamplePage and TwilioSampleController to see how the sample app is put together.


More Information
================

The complete list of TwiML verbs and attributes is available in the `Twilio Markup Language <http://www.twilio.com/docs/api/twiml>`_ documentation.


