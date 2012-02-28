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


Adding Twilio Client to Salesforce
==================================

Using the TwilioCapability class
--------------------------------

Capability tokens are used by Twilio Client to provide connection security and authorization. The `Capability Token documentation <http://www.twilio.com/docs/client/capability-tokens>`_ explains in depth the purpose and features of these tokens.

:class:`TwilioCapability` is responsible for the creation of these capability tokens. You’ll need your Twilio AccountSid and AuthToken.

.. code-block:: javascript

    String accountSid = 'ACXXXXXXXXXXXXXXXXX';
    String authToken = 'YYYYYYYYYYYYYYYYYY';
    TwilioCapability capability = new TwilioCapability(accountSid, authToken);

Allow Incoming Connections
--------------------------
Before a device running Twilio Client can recieve incoming connections, the instance must first register a name (such as “Alice” or “Bob”). The :meth:`allowClientIncoming()` method adds the client name to the capability token.

.. code-block:: javascript

    capability.allowClientIncoming('Alice');

Allow Outgoing Connections
--------------------------
To make an outgoing connection from a Twilio Client device, you’ll need to choose a Twilio Application to handle TwiML URLs. A Twilio Application is a collection of URLs responsible for outputing valid TwiML to control phone calls and SMS.

.. code-block:: javascript

    // Twilio Application Sid
    String applicationSid = 'APabe7650f654fc34655fc81ae71caa3ff';
    capability.allowClientOutgoing(applicationSid);

Generate a Token
----------------

.. code-block:: javascript

	String token = capability.generateToken();

By default, this token will expire in one hour. If you’d like to change the token expiration, :meth:`generateToken()` takes an optional expires argument.

.. code-block:: javascript

	String token = capability.generateToken(600);

This token will now expire in 10 minutes. If you haven’t guessed already, expires is expressed in seconds.

Visualforce Example
===================

The controller is responsible for generating the token so it can be embedded in the Visualforce page.

.. code-block:: javascript

	public class TwilioClientController {
		private TwilioCapability capability;
		
		public TwilioClientController() {
			capability = TwilioAPI.createCapability();
			capability.allowClientOutgoing(
				TwilioAPI.getTwilioConfig().ApplicationSid__c,
				null);
		}
		
		public String getToken() { return capability.generateToken(); }
	}

The Visualforce page includes the `twilio.min.js` Javascript library and calls `Twilio.Device.setup(token)` to authorize the client-side device.  Buttons on the page allow the user to invoke :meth:`Twilio.Device.connect` and :meth:`Twilio.Device.disconnectAll`.

.. code-block:: html

	<apex:page controller="TwilioClientController" showHeader="false">
		<apex:includeScript 
		  value="//static.twilio.com/libs/twiliojs/1.0/twilio.min.js"/>
		<apex:includeScript 
		  value="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"/>
		<apex:stylesheet 
		  value="http://static0.twilio.com/packages/quickstart/client.css"/>
		
		<script type="text/javascript">
		  // pass the Capability Token to the Device
		  Twilio.Device.setup("{! token }");
	 
		  Twilio.Device.connect(function (conn) {
			$("#log").text("Successfully established call");
		  });
		  
		  Twilio.Device.disconnect(function (conn) {
			$("#log").text("Call ended");
		  });
	 
		  function call() {
			Twilio.Device.connect();
		  }
		  
		  function hangup() {
			Twilio.Device.disconnectAll();
		  }
		</script>
		<div height="100%" width="100%" class="bg">
			<button class="call" onclick="call();">
			  Call
			</button>
			
			<button class="hangup" onclick="hangup();">
			  Hangup
			</button>
		 
			<div id="log"/>
			<br/>
		</div>
	</apex:page>