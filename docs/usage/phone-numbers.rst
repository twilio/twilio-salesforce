=================
Phone Numbers
=================

With Twilio you can search and buy real phone numbers, just using the API.

For more information, see the `IncomingPhoneNumbers REST Resource <http://www.twilio.com/docs/api/rest/incoming-phone-numbers>`_ documentation.


Searching and Buying a Number
--------------------------------

Finding numbers to buy couldn't be easier. We first search for a number in area code 530. Once we find one, we'll purchase it for our account.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    List<TwilioAvailablePhoneNumbers> numbers;
    Map<String,String> filters = new Map<String,String> {
    		'AreaCode' => '530'
    	};
    numbers = client.getAccount().getAvailablePhoneNumbers(filters).getPageData();

    if (numbers.isEmpty()) {
    	System.debug('No numbers in 530 available');
    } else {
        numbers[0].purchase();
    }

Toll Free Numbers
^^^^^^^^^^^^^^^^^^^^^^^^

By default, the phone number search looks for local phone numbers. Set :data:`Type` to ``tollfree`` to search toll-free numbers instead.

.. code-block:: javascript

    TwilioAvailablePhoneNumberList numbers;
    Map<String,String> filters = new Map<String,String> {'Type' => 'tollfree'};
    numbers = client.getAccount().getAvailablePhoneNumbers(filters);


Numbers Containing Words
^^^^^^^^^^^^^^^^^^^^^^^^^^

Phone number search also supports looking for words inside phone numbers. The following example will find any phone number with "FOO" in it.

.. code-block:: javascript

    TwilioAvailablePhoneNumberList numbers;
    Map<String,String> filters = new Map<String,String> {'Contains' => 'FOO'};
    numbers = client.getAccount().getAvailablePhoneNumbers(filters);

You can use the ''*'' wildcard to match any character. The following example finds any phone number that matches the pattern ''D*D''.

.. code-block:: javascript

    TwilioAvailablePhoneNumberList numbers;
    Map<String,String> filters = new Map<String,String> {'Type' => 'D*D'};
    numbers = client.getAccount().getAvailablePhoneNumbers(filters);

The Twilio API has plenty of other options to augment your phone number search. The `AvailablePhoneNumbers REST Resource <http://www.twilio.com/docs/api/rest/available-phone-numbers>`_ documentation describes all the  search options at your disposal.


Buying a Number
---------------

If you've found a phone number you want, you can purchase the number.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    TwilioIncomingPhoneNumber incoming;
    Map<String,String> properties =
    		new Map<String,String>{'PhoneNumber' => '+15305431234'};
    incoming = client.getAccount().getIncomingPhoneNumbers().create(properties);

However, it's easier to purchase numbers after finding them using search (as shown in the first example).


Changing Applications
----------------------

An *Application* encapsulates all necessary URLs for use with phone numbers. Update an application on a phone number using :meth:`updateResource`.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    String phone_sid = 'PN123';
    TwilioIncomingPhoneNumber incoming =
    		client.getAccount().getIncomingPhoneNumber(phone_sid);
    
    Map<String,String> properties =
    		new Map<String,String>{'SmsApplicationSid' => 'AP456'};
    incoming.updateResource(properties);

See :doc:`/usage/applications` for instructions on updating and maintaining Applications.

Validate Caller Id
-----------------------
Adding a new phone number to your validated numbers is quick and easy:

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    TwilioCallerIdValidation val =
    	client.getAccount().getAvailableCallerIds().validate('+9876543212');
    System.debug(val.getValidationCode());

Display the validation code to your user. Twilio will call the provided number and wait for the validation code to be entered.