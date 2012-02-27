.. _usage-client:


=============
Twilio Client
=============

Twilio Client extends the power of Twilio beyond the traditional telephone network. In the past, the only way to transport audio into and out of Twilio was via the PSTN using telephones. With Twilio Client you are no longer restricted to building Twilio applications that rely on interacting with traditional telephones. And best of all, your existing applications will already work with Twilio Client.

.. glossary::

  The twilio.js Library
    Take your existing Twilio applications and bring them to the browser using the `twilio.js Library <http://www.twilio.com/docs/client/twilio-js>`_.

  Twilio Client Mobile SDKs
    Add voice to your mobile applications with the `Twilio Client Mobile SDKs for iOS and Android <http://www.twilio.com/api/client/ios>`_.


How It Works
============

Twilio Client calls span three environments, just like a regular Twilio call. In both cases, the call comes in to Twilio, which then makes a request to your application for TwiML instructions to control the call. Unlike regular phone calls, however, Twilio Client calls use a client-side web or mobile app in place of a phone.

On the Client
-------------
From your client-side code running in your user's browser or mobile device, you setup your Twilio Client device and establish a connection to Twilio. Audio from your device's microphone is sent to Twilio, and Twilio plays audio through your device's speakers, like on a normal phone call.

The Twilio Application
----------------------

When you initiate a connection using Twilio Client, you're not connecting to another phone directly. Rather, you're connecting to Twilio and instructing Twilio to fetch TwiML from your server to handle the connection. This is analogous to the way Twilio handles incoming calls from a real phone. All the same TwiML verbs and nouns that are available for handling Twilio Voice calls are also available for handling Twilio Client connections. We've also added a ``<Client>`` noun for dialing to a Client.

Because Twilio Client connections aren't made to a specific phone number, Twilio relies on a Twilio Application within your account to determine how to interact with your server. A Twilio Application is just a convenient way to store a set of URLs, like the VoiceUrl and SmsUrl on a phone number, but without locking them to a specific phone number. This makes Twilio Applications perfect for handling connections from Twilio Client (which is actually why we created them in the first place).

Capability Tokens
-----------------

When your device initiates a Twilio Client connection to Twilio, it identifies itself using a Capability Token.  This token authorizes the client-side application to connect to Twilio using your Twilio account, and specifies which Application within your account to use.  Twilio then makes a request to the VoiceUrl property of the Application, and uses the TwiML response from the request direct what happens with the Client connection.

Because the purpose of the Capability Token is to authorize the direct connection between the client-side code and Twilio, you will use server-side code to generate the tokens. If your client-side app is a web page, you typically will generate the token when you generate the page itself.  If your client-side app is a mobile device, you may need to create a service for your the mobile app to request a token from your server.

Once your client-side app has a valid token, it can make outbound and/or receive inbound calls through Twilio directly, until the token expires.


