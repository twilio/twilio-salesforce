=====================
Phone Calls
=====================

The class :class:`TwilioCall` resource manages all interaction with Twilio phone calls,
including the creation and termination of phone calls.

Making a Phone Call
-------------------

The :class:`TwilioCallList` resource allows you to make outgoing calls. Before a call
can be successfully started, you'll need a url which outputs valid `TwiML
<http://www.twilio.com/docs/api/twiml/>`_.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> params = new Map<String,String>() {
			'To' => '9991231234',
			'From' => '9991231234',
			'Url' => 'http://foo.com/call.xml'
		};
    
    TwilioCall call = client.getAccount().getCalls().create(params);
    System.debug(call.getDuration());
    System.debug(call.getSid());

Retrieve a Call Record
-------------------------

If you already have a :class:`TwilioCall` sid, you can use the client to retrieve that record:

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    String sid = 'CA12341234';
    TwilioCall call = client.getAccount().getCall(sid);

Accessing Specific Call Resources
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

Each :class:`TwilioCall` resource also has access to its `notifications`, `recordings`, and `transcriptions`. These attributes are *list resources*, just like the :class:`TwilioCallList` resource itself.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    String sid = 'CA12341234';
    TwilioCall call = client.getAccount().getCall(sid);

    System.debug(call.getNotifications().getPageData());
    System.debug(call.getRecordings().getPageData());
    System.debug(call.getTranscriptions().getPageData());

Modifying Live Calls
--------------------

The :class:`TwilioCall` resource makes it easy to find current live calls and redirect them as necessary:

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> filters = new Map<String,String>{'Status'=>'in-progress'};
    Iterator<TwilioCall> calls = client.getAccount().getCalls(filters).iterator();
    while (calls.hasNext()) {
    	TwilioCall call = calls.next();
        call.redirect('http://twimlets.com/holdmusic?Bucket=com.twilio.music.ambient', 
                'POST');
    }

Ending all live calls is also possible:

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> filters = new Map<String,String>{'Status'=>'in-progress'};
    Iterator<TwilioCall> calls = client.getAccount().getCalls(filters).iterator();
    while (calls.hasNext()) {
    	TwilioCall call = calls.next();
        call.hangup();
    }

Note that :meth:`hangup` will also cancel calls currently queued.

In addition to the convenience methods :meth:`hangup`, :meth:`redirect`, and :meth:`cancel` you can also use :meth:`updateResource` to update the record directly.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    String sid = "CA12341234"
    TwilioCall call = client.getAccount().getCall(sid);
    Map<String,String> properties = new Map<String,String>{
    		'Url'=> 'http://twimlets.com/holdmusic?Bucket=com.twilio.music.ambient',
    		'Method' => 'POST'
    	};
    call.updateResource(properties);

