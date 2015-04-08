/*
Copyright (c) 2012 Twilio, Inc.

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/
global class TwilioTRWorker extends TwilioResource.InstanceResource {

	/**
	 * Instantiates a new task.
	 *
	 * @param client the client
	 */
	public TwilioTRWorker(TwilioTRRestClient client) {
    	super(client);
    }
    
    /**
	 * Instantiates a new task.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioTRWorker(TwilioTRRestClient client, String workspacesid, String sid) {
		super(client);
		this.setProperty('workspace_sid', workspacesid);
		this.setProperty('sid', sid);
	}

	/**
	 * Instantiates a new task.
	 *
	 * @param client  the client
	 * @param properties  properties to set on the new call as key/value pairs
	 */
	public TwilioTRWorker(TwilioTRRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/**
	 * Returns the URI of this resource, relative to the API endpoint.
	 */
	public override String getResourceLocation() {
		return '/' + TwilioTRRestClient.DEFAULT_VERSION + '/Workspaces/' 
				+ this.getWorkspaceSid() +  '/Workers/' 
				+ this.getSid();
	}
	

	/*
	 * Property getters
	 */

	/**
	 * Gets the workspace sid.
	 *
	 * @return the workspace sid
	 */
	public String getWorkspaceSid() {
		return this.getProperty('workspace_sid');
	}

	/**
	 * Gets the account sid.
	 *
	 * @return the account sid
	 */
	public String getAccountSid() {
		return this.getProperty('account_sid');
	}


	/**
	 * Gets the activity sid.
	 *
	 * @return the activity sid
	 */
	public String getActivitySid() {
		return this.getProperty('activity_sid');
	}



	/**
	 * Gets the activity name.
	 *
	 * @return the activity name
	 */
	public String getActivityName() {
		return this.getProperty('activity_name');
	}


	/**
	 * Gets the friendly name.
	 *
	 * @return the friendly name
	 */
	public String getFriendlyName() {
		return this.getProperty('friendly_name');
	}

	/**
	 * Gets the task attriutes.
	 *
	 * @return the attributes
	 */
	public String getAttributes() {
		return this.getProperty('attributes');
	}

	/**
	 * Gets the avaialble.
	 *
	 * @return the worker available
	 */
	public Boolean getAvailable() {
		return this.getPropertyBoolean('available');
	}


	/** 
	 * Returns the unique ID of this resource.
	 */
	public String getSid() {
		return this.getProperty('sid');
	}

	/**
	 * Returns the date status changed.
	 */
	public Datetime getDateStatusChanged() {
		return this.getPropertyISODatetime('date_status_changed');
	}

	
	/**
	 * Returns the date created.
	 */
	public Datetime getDateCreated() {
		return this.getPropertyISODatetime('date_created');
	}

	/**
	 * Returns the date updated.
	 */
	public Datetime getDateUpdated() {
		return this.getPropertyISODatetime('date_updated');
	}

	/** Returns the SubresourceUris */
	public Map<String,Object> getSubresourceUris() {
		return (Map<String,Object>)this.getObject('links');
	}
	
	/** Returns the resource's URL */
	public String getUrl() {
		return getProperty('url');
	}
}