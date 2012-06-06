====================================
Twilio Helper Library for Salesforce
====================================

Get ready to unleash the power of the Twilio cloud communications platform in Salesforce and Force.com!  Soon you'll be building powerful voice and text messaging apps in Apex and Visualforce.

With this toolkit you'll be able to:

* Make requests to Twilio's `REST API <http://www.twilio.com/docs/api>`_
* Control phone calls and respond to text messages in real time with `TwiML <http://www.twilio.com/docs/api/twiml>`_
* Embed `Twilio Client <http://www.twilio.com/docs/client>`_ in-browser calling in your Salesforce and Force.com apps


.. _installation:

Installation
============

We've made it easy to get started. Just grab the code from GitHub and deploy it to your Salesforce org with the included Ant script.

#. Checkout or download the `twilio-salesforce <https://github.com/twilio/twilio-salesforce>`_ library from GitHub.

   .. code-block:: bash

     $ git clone git@github.com:twilio/twilio-salesforce.git

#. Install the `Force.com Migration Tool <http://www.salesforce.com/us/developer/docs/daas/Content/forcemigrationtool_install.htm>`_ plugin for Ant, if you don't already have it.

#. Edit :file:`install/build.properties` to insert your Salesforce username and password.  Since you will be using the API to access Salesforce, remember to `append your Security Token <http://www.salesforce.com/us/developer/docs/api/Content/sforce_api_concepts_security.htm#topic-title_login_token>`_ to your password.

#. Open your command line to the :file:`install` folder, then deploy using Ant:

   .. code-block:: bash

     $ ant deployTwilio

Now all the library code is in your org and you're ready to start coding!


Getting Started
===============

The quickstart will get you up and running in a few quick minutes.

.. toctree::
    :maxdepth: 1

    quickstart

This guide assumes you understand the core concepts of Twilio. If you've never used Twilio before, don't fret! Just read about `how Twilio works <http://www.twilio.com/api/>`_ and then jump in.


.. _user-guide:

User Guide
==========

Functionality is split over three different sub-packages within **twilio-salesforce**. Below are in-depth guides to specific portions of the library.


REST API
--------

Query the Twilio REST API to create phone calls, send SMS messages and so much more

.. toctree::
    :maxdepth: 1

    usage/basics
    usage/phone-calls
    usage/phone-numbers
    usage/messages
    usage/accounts
    usage/conferences
    usage/applications
    usage/notifications
    usage/recordings
    usage/transcriptions

TwiML
-----

Generates Twilio Markup Language (TwiML) instructions for controlling and manipulating live phone calls and responding to text messages.

.. toctree::
    :maxdepth: 1

    usage/twiml

Client
------

Small functions useful for validating requests are coming from Twilio

.. toctree::
    :maxdepth: 1

    usage/client


Support and Development
=======================

All project development occurs on `GitHub <https://github.com/twilio/twilio-salesforce>`_. To checkout the source, use:

.. code-block:: bash

    $ git clone git@github.com:twilio/twilio-salesforce.git


Report bugs using the Github `issue tracker <https://github.com/twilio/twilio-salesforce/issues>`_.

If you have questions that aren't answered by this documentation, ask the `#twilio IRC channel <irc://irc.freenode.net/#twilio>`_
