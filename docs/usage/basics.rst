=========================
Accessing REST Resources
=========================

The Twilio REST API allows you to query information about your account, phone numbers, calls, text messages, and recordings. You can also do some fancy things like initiate outbound calls and send text messages. For more information, see the `Twilio REST Web Service Interface <http://www.twilio.com/docs/api/rest>`_ documentation.

To access Twilio REST resources, you'll first need to instantiate a :class:`TwilioRestClient`.


Authentication
==============

:class:`TwilioRestClient` needs your Twilio credentials to access the Twilio API. While these can be passed in directly to the constructor, we suggest storing your credentials inside the `TwilioConfig` custom setting. Why? You'll never have to worry about committing your credentials and accidentally posting them somewhere public.

The :class:`TwilioAPI` helper class looks up your Twilio AccountSid and AuthToken from your current organization, in the *TwilioConfig* custom setting.  You can configure *TwilioConfig* by going to **Setup | Develop | Custom Settings**, and your AccountSid and AuthToken can be found on the `Twilio account dashboard <https://www.twilio.com/user/account>`_.

Once you've set up *TwilioConfig*, you can easily get a :class:`TwilioRestClient` from :class:`TwilioAPI`.

.. code-block:: javascript

    TwilioRestClient client = TwilioAPI.getDefaultClient();

Alternatively, if you'd rather not use *TwilioConfig* or you want to use a different set of credentials, pass your account credentials directly to the the constructor.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);

Get an Individual Resource
==========================

Most resources in the Twilio API can be accessed from :class:`TwilioAccount`, available from :meth:`TwilioRestClient.getAccount`. You can get an individual instance resource by passing its unique identifier, or *sid*, to the appropriate method.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    TwilioCall call = client.getAccount().getCall('CA123');
    System.debug(call.getSid());


Get List Resources
==================

The Twilio API gives you access to various list resources. A list resource object represents a query for instances resource of a given type. For example, :class:`TwilioCallsList` provides access to individual :class:`TwilioCall` resources.  You can get the list resource from its parent class, typically :class:`TwilioAccount`.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    TwilioCallList callsResource = client.getAccount().getCalls();


Paging Through List Results
---------------------------

For long lists, the Twilio API breaks the responses into pages of records and returns one at a time.  Each list resource has a :meth:`getPageData` method that, by default, returns the most recent 50 instance resources.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    TwilioCallList callsResource = client.getAccount().getCalls();
    List<TwilioCall> calls = callsResource.getPageData()

You can provide arguments to control the page size and current page. The following will return page 3 using a page size of 25.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    Map<String,String> params = new Map<String,String> {
            'page' => 3,
            'page_size' => 25
        };
    List<TwilioCall> calls = client.getAccount().getCalls(params).getPageData();


Listing All Resources with iterator()
-------------------------------------

Sometimes you'd like to retrieve all records from a list resource. Instead of manually paging over the resource, each list resource class has an :meth:`iterator` method that returns a generator. After exhausting the current page, the generator will request the next page of results.

.. warning:: Accessing all your records can be slow. We suggest only doing so when you absolutely need all the records

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    Iterator<TwilioCall> callsIterator = client.getAccount().getCalls().iterator();



