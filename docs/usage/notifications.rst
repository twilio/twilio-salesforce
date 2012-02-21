====================
Notifications
====================

For more information, see the `Notifications REST Resource <http://www.twilio.com/docs/api/rest/notification>`_ documentation.

Listing Your Notifications
----------------------------

The following code will print out additional information about each of your current :class:`TwilioNotification` resources.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    for (TwilioNotification n : client.getAccount().getNotifications().getPageData()) {
    	System.debug(n.getMoreInfo());
    }

You can filter transcriptions by :attr:`Log` and :attr:`MessageDate`. The :attr:`Log` value is 0 for `ERROR` and 1 for `WARNING`.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    String ERROR = '0';
    
    Map<String,String> filters = new Map<String,String> {
    		'Log' => ERROR;
    }
    
    for (TwilioNotification n : client.getAcount().getNotifications().getPageData()) {
    	System.debug(n.getErrorCode());
    }
    
.. note:: Due to the potentially voluminous amount of data in a notification, the full HTTP request and response data is only returned in the *Notification* instance resource representation.

Deleting Notifications
------------------------

Your account can sometimes generate an inordinate amount of *Notification* resources. The :class:`TwilioNotificationList` resource allows you to delete unnecessary notifications.

.. code-block:: javascript

    String ACCOUNT_SID = 'AXXXXXXXXXXXXXXXXX';
    String AUTH_TOKEN = 'YYYYYYYYYYYYYYYYYY';
    TwilioRestClient client = new TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN);
    
    client.getAccount().getNotifications().deleteResource("NO123")

