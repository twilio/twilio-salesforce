===========
Accounts
===========

Managing Twilio accounts is straightforward. Update your own account information or create and manage multiple subaccounts.

For more information, see the `Account REST Resource <http://www.twilio.com/docs/api/rest/account>`_ documentation.


Updating Account Information
----------------------------

Use :meth:`TwilioAccount.updateResource` to modify one of your accounts. Right now the only valid attribute is `FriendlyName`.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    TwilioAccount twaccount = client.getAccount();
    Map<String,String> properties = new Map<String,String> {
    		'FriendlyName' => 'My Awesome SubAccount'
    	};
    twaccount.updateResource(properties);

Creating Subaccounts
--------------------

Subaccounts are easy to make.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    Map<String,String> properties = new Map<String,String> {
    		'FriendlyName' => 'My Awesome SubAccount'
    	};
    TwilioAccount subaccount = client.getAccounts().create(properties);

Managing Subaccounts
--------------------

Say you have a subaccount for Client X with an account sid `AC123` 

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    # Client X's subaccount
    TwilioAccount subaccount = client.getAccount('AC123');

Client X hasn't paid you recently, so let's suspend their account.

.. code-block:: javascript

    subaccount.suspend()

If it was just a misunderstanding, reenable their account.

.. code-block:: javascript

    subaccount.activate()

Otherwise, close their account permanently.

.. warning::
    This action can't be undone. 

.. code-block:: javascript

    subaccount.close()

