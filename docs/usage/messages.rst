============
SMS Messages
============

For more information, see the `SMS Message REST Resource <http://www.twilio.com/docs/api/rest/message>`_ documentation.

Sending a Text Message
----------------------

Send a text message in only a few lines of code.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> properties = new Map<String,String> {
    		'To'   => '+13216851234',
        	'From' => '+15555555555',
    		'Body' => 'Hello!'
    	};
    TwilioMessage message = client.getAccount().getMessages().create(properties);


.. note:: The message body must be less than 160 characters in length

Sending a MMS
----------------------

Send a MMS in only a few lines of code.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    List<TwilioNameValuePair> properties = new List<TwilioNameValuePair>();
    properties.add(new TwilioNameValuePair('To','+13216851234'));
	properties.add(new TwilioNameValuePair('From','+15555555555'));
	properties.add(new TwilioNameValuePair('MediaUrl','https://www.twilio.com/packages/company/img/logos_downloadable_round.png'));  
    
    TwilioMessage message = client.getAccount().getMessages().create(properties);


.. note:: The message body must be less than 160 characters in length


If you want to send a message from a `short code
<http://www.twilio.com/api/sms/short-codes>`_ on Twilio, just set :attr:`From`
to your short code's number.


Retrieving Sent Messages
-------------------------

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    for (TwilioSms message : client.getAccount().getSmsMessages().getPageData()) {
    	System.debug(message.getBody());
    }
    

Filtering Your Messages
-------------------------

The list resource supports filtering on :attr:`To`, :attr:`From`, and :attr:`DateSent`. The following will only show messages to "+5466758723" on January 1st, 2012.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> filters = new Map<String,String> {
    		'To'       => '+5466758723',
    		'DateSent' => TwilioParser.formatFilterDatetime(2012,1,1)
    	};
    for (TwilioSms message : client.getAccount().getSmsMessages(filters).getPageData()) {
    	System.debug(message.getBody());
    }


Short Codes
-----------
If you host a Short Code with Twilio, it works just like regular phone numbers with SMS resources.