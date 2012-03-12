# Twilio Helper Library for Salesforce

Get ready to unleash the power of the Twilio cloud communications platform in Salesforce and Force.com!  Soon you'll be building powerful voice and text messaging apps in Apex and Visualforce.

With this toolkit you'll be able to:

* Make requests to Twilio's [REST API](http://www.twilio.com/docs/api)
* Control phone calls and respond to text messages in real time with [TwiML](http://www.twilio.com/docs/api/twiml)
* Embed [Twilio Client](http://www.twilio.com/docs/client) in-browser calling in your Salesforce and Force.com apps


Installation
============

We've made it easy to get started. Just grab the code from GitHub and deploy it to your Salesforce org with the included Ant script.

1. Checkout or download the [twilio-salesforce](https://github.com/twilio/twilio-salesforce) library from GitHub.

    ```bash
    $ git clone git@github.com:twilio/twilio-salesforce.git
    ```

1. Install the [Force.com Migration Tool](http://www.salesforce.com/us/developer/docs/daas/Content/forcemigrationtool_install.htm) plugin for Ant, if you don't already have it.

1. Edit `install/build.properties` to insert your Salesforce username and password.

1. Open a terminal window to the `install` folder, then deploy using Ant:

    ```bash
    $ ant deployTwilio
    ```

Now all the library code is in your org and you're ready to start coding!



Quickstart
==========

Getting started with the Twilio API couldn't be easier. Create a Twilio REST client to get started. For example, the following code makes a call using the Twilio REST API.

Make a Call
-----------
This sample calls the `to` phone number and plays music.  The `from` number must be a [verified number](https://www.twilio.com/user/account/phone-numbers/verified) on your Twilio account.

```javascript
// Find your Twilio API credentials at https://www.twilio.com/user/account
String account = 'ACXXXXXXXXXXXXXXXXX';
String token = 'YYYYYYYYYYYYYYYYYY';

TwilioRestClient client = new TwilioRestClient(account, token);

Map<String,String> params = new Map<String,String> {
        'to'   => '9991231234',
        'from' => '9991231234',
        'url' => 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.ambient'
    };
TwilioCall call = client.getAccount().getCalls().create(params);
```

Send an SMS
-----------
This sample texts *Hello there!* to the `to` phone number.  The `from` number must be a [verified number](https://www.twilio.com/user/account/phone-numbers/verified) on your Twilio account.

```javascript
String account = 'ACXXXXXXXXXXXXXXXXX';
String token = 'YYYYYYYYYYYYYYYYYY';
TwilioRestClient client = new TwilioRestClient(account, token);

Map<String,String> params = new Map<String,String> {
        'to'   => '+12316851234',
        'from' => '+15555555555',
        'body' => 'Hello there!'
    };
TwilioSMS sms = client.getAccount().getSMSMessages().create(params);
```

Generate TwiML
--------------

To control phone calls, your application needs to output [TwiML](http://www.twilio.com/docs/api/twiml/). Use `TwilioTwiML.Response` to easily create a TwiML document.

```javascript
TwilioTwiML.Response r = new TwilioTwiML.Response();
TwilioTwiML.Play p = new TwilioTwimL.Play('https://api.twilio.com/cowbell.mp3');
p.setLoop(5);
r.append(p);
System.debug(r.toXML());
```

```xml
<Response><Play loop="5">https://api.twilio.com/cowbell.mp3</Play><Response>
```



Next Steps
==========

The full power of the Twilio API is at your fingertips. Visit the [full documentation](http://readthedocs.org/docs/twilio-salesforce) for advanced topics.
