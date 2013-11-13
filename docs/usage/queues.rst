.. module:: twilio.rest.resources

==============================
Queues and Members
==============================

For more information, see the
`Queue REST Resource <http://www.twilio.com/docs/api/rest/queue>`_
and `Member REST Resource <http://www.twilio.com/docs/api/rest/member>`_
documentation.


Listing Queues
-----------------------

.. code-block:: javascript

    String ACCOUNT_SID = 'XXXXXXXXXXXXXXX';
	String AUTH_TOKEN = 'XXXXXXXXXXXXXXX';
	TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);

	List<TwilioNameValuePair> params = new List<TwilioNameValuePair>();
	params.add(new TwilioNameValuePair('FriendlyName','TestQueue'));

	TwilioQueue queue = client.getAccount().getQueues().create(params);


List All Available Queues
----------------------


.. code-block:: javascript

	String ACCOUNT_SID = 'XXXXXXXXXXXXXXX';
	String AUTH_TOKEN = 'XXXXXXXXXXXXXXX';
	TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);

	TwilioQueueList queues = client.getAccount().getQueues();

	for(TwilioQueue queue :queues.getPageData())
	{
     	system.debug(queue);
	}


Retrieving Queue information using QueueId
----------------------


.. code-block:: javascript

	String ACCOUNT_SID = 'XXXXXXXXXXXXXXX';
	String AUTH_TOKEN = 'XXXXXXXXXXXXXXX';
	TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
	TwilioQueue queue = client.getAccount().getQueue('YYYYYYYYYYYYYYYYY');

	system.debug(queue);

Updating Queue Properties
----------------------


.. code-block:: javascript

	String ACCOUNT_SID = 'XXXXXXXXXXXXXXX';
	String AUTH_TOKEN = 'XXXXXXXXXXXXXXX';
	TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
	TwilioQueue queue = client.getAccount().getQueue('YYYYYYYYYYYYYYYYY');

	List<TwilioNameValuePair> params = new List<TwilioNameValuePair>();
	params.add(new TwilioNameValuePair('MaxSize','120'));

	queue.updateResource(params);



List of Members in a queue
----------------------


.. code-block:: javascript

	String ACCOUNT_SID = 'XXXXXXXXXXXXXXX';
	String AUTH_TOKEN = 'XXXXXXXXXXXXXXX';
	TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
	TwilioMemberList members = client.getAccount().getQueue('QUcdbadab1b3de41f39f2257395e9b80a9').getMembers();

	system.debug('Members :'+members);

Getting a specific Queue Member
----------------------


.. code-block:: javascript

	String ACCOUNT_SID = 'XXXXXXXXXXXXXXX';
	String AUTH_TOKEN = 'XXXXXXXXXXXXXXX';
	TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
	TwilioMember member = client.getAccount().getQueue('QUcdbadab1b3de41f39f2257395e9b80a9').getMember('ZZZZZZZZZZZZZZZZZ');

Updating Member information
----------------------


.. code-block:: javascript

	String ACCOUNT_SID = 'XXXXXXXXXXXXXXX';
	String AUTH_TOKEN = 'XXXXXXXXXXXXXXX';
	TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
	//need to have callSid
	TwilioMember member = client.getAccount().getQueue('QUcdbadab1b3de41f39f2257395e9b80a9').getMember('Front');
	List<TwilioNameValuePair> params = new List<TwilioNameValuePair>();
	params.add(new TwilioNameValuePair('URL','http://demo.twilio.com/docs/voice.xml'));
	params.add(new TwilioNameValuePair('Method','POST'));
	member.updateResource(params);
