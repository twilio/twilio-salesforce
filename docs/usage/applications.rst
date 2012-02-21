=================
Applications
=================

A TwiML application inside of Twilio is just a set of URLs and other configuration data that tells Twilio how to behave when one of your Twilio numbers receives a call or SMS message.

For more information, see the `Application REST Resource <http://www.twilio.com/docs/api/rest/applications>`_ documentation.

Listing Your Applications
--------------------------

The following code will print out the :attr:`FriendlyName` for each :class:`TwilioApplication`.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    for (TwilioApplication app : client.getAccount().getApplications().getPageData()) {
    	System.debug(app.getFriendlyName());
    }


Filtering Applications
---------------------------

You can filter applications by Friendly Name

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> filters = new Map<String,String> {
    		'FriendlyName' => 'FOO'
    	};
    TwilioApplicationList apps = client.getAccount().getApplications(filters);
    
    for (TwilioApplication app : apps.getPageData()) {
    	System.debug(app.getSid());
    }

Creating an Application
-------------------------

When creating an application, no fields are required. We create an application with only a Friendly Name. :meth:`TwilioApplicationList.create()` accepts many other arguments for url configuration.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> properties = new Map<String,String> {
    		'FriendlyName' => 'My New App'
    	};
    TwilioApplication app = client.getAccount().getApplications().create(properties);


Updating an Application
------------------------

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    String app_sid = 'AP123';
    TwilioApplication app = client.getAccount().getApplication(app_sid);
    Map<String,String> properties = new Map<String,String> {
    		'VoiceUrl' =>
    		'http://twimlets.com/holdmusic?Bucket=com.twilio.music.ambient'
    	};
    app.updateResource(properties);


Deleting an Application
-------------------------

You can delete an application from the list resource or the instance resource:

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    String app_sid = 'AP123';
    // delete from the list resource
    client.getAccount().getApplications().deleteApplication(app_sid);
    // or do the same thing from the instance resource
    client.getAccount().getApplication(app_sid).deleteApplication();
    
