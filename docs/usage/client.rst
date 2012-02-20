.. _usage-client:


=============
Twilio Client
=============

Twilio Client extends the power of Twilio beyond the traditional telephone network. In the past, the only way to transport audio into and out of Twilio was via the PSTN using telephones. With Twilio Client you are no longer restricted to building Twilio applications that rely on interacting with traditional telephones. And best of all, your existing applications will already work with Twilio Client.


The twilio.js Library
=====================

Take your existing Twilio applications and bring them to the browser using the `twilio.js Library <http://www.twilio.com/docs/client/twilio-js>`_.


Twilio Client Mobile SDKs
=========================

Add voice to your mobile applications with the `Twilio Client Mobile SDKs for Android and iOS <http://www.twilio.com/api/client/sdk>`_.


Token Generation
================

You setup your device and establish a connection to Twilio. Audio from your device's microphone is sent to Twilio, and Twilio plays audio through your device's speakers, like on a normal phone call. But with Twilio Client, your device need not be a phone.

When you initiate a connection using Twilio Client, you're not connecting to another phone directly. Rather, you're connecting to Twilio and instructing Twilio to fetch TwiML from your server to handle the connection. This is analogous to the way Twilio handles incoming calls from a real phone. All the same TwiML verbs and nouns that are available for handling Twilio Voice calls are also available for handling Twilio Client connections. We've also added a new <Client> noun for dialing to a Client.
