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
global class TwilioTRTask extends TwilioResource.InstanceResource {

	/**
	 * Instantiates a new task.
	 *
	 * @param client the client
	 */
	public TwilioTRTask(TwilioRestClient client) {
    	super(client);
    }
    
    /**
	 * Instantiates a new task.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioTRTask(TwilioRestClient client, String workspaceSid, String sid) {
		super(client);
		this.setProperty('workspace_sid', workspaceSid);
		this.setProperty('sid', sid);
	}

	/**
	 * Instantiates a new task.
	 *
	 * @param client  the client
	 * @param properties  properties to set on the new call as key/value pairs
	 */
	public TwilioTRTask(TwilioRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/**
	 * Returns the URI of this resource, relative to the API endpoint.
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/Workspaces/' 
				+ this.getWorkspaceSid() +  '/Tasks/' 
				+ this.getSid() + '.json';
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
	 * Gets the workflow sid.
	 *
	 * @return the workflow sid
	 */
	public String getWorkflowSid() {
		return this.getProperty('workflow_sid');
	}

	/**
	 * Gets the workflow friendly name.
	 *
	 * @return the workflow friendly name
	 */
	public String getWorkflowFriendlyName() {
		return this.getProperty('workflow_friendly_name');
	}

	/**
	 * Gets the task queue sid.
	 *
	 * @return the taskqueue sid
	 */
	public String getTaskQueueSid() {
		return this.getProperty('task_queue_sid');
	}

	/**
	 * Gets the task queue friendly name.
	 *
	 * @return the taskqueue friendly name
	 */
	public String getTaskQueueFriendlyName() {
		return this.getProperty('task_queue_friendly_name');
	}


	/** 
	 * Returns the unique ID of this resource.
	 */
	public String getSid() {
		return this.getProperty('sid');
	}
	
	/**
	 * Returns the age.
	 */
	public Decimal getAge() {
		return this.getPropertyDecimal('age');
	}

    /**
	 * Returns the priority. this should work.
	 */
	public Decimal getPriority() {
		return this.getPropertyDecimal('priority');
	}
    
	/**
	 * Returns the reason.
	 */
	public String getReason() {
		return this.getProperty('reason');
	}

	/**
	 * Returns the timeout.
	 */
	public Decimal getTimeout() {
		return this.getPropertyDecimal('timeout');
	}

	/**
	 * Returns the attributes.
	 */
	public String getAttributes() {
		return this.getProperty('attributes');
	}

	/**
	 * Returns the assignment status.
	 */
	public String getAssignmentStatus() {
		return this.getProperty('assignment_status');
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

	/**
	 * Get the reservation list
	 * 
	 * @return
	 */
	public TwilioTRReservationList getReservations() {
		System.debug('Get Reservations: ' + this.getSid());
		TwilioTRReservationList twlist = new TwilioTRReservationList(this.getClient(), this.getWorkspaceSid(), this.getSid());
		twlist.setRequestAccountSid(this.getRequestAccountSid());
		return twlist;
	}	

	/**
	 * Get the reservation instance by sid
	 * 
	 * @return
	 */
	public TwilioTRReservation getReservation(String sid) {
		TwilioTRReservation reservation = new TwilioTRReservation(this.getClient(), this.getWorkspaceSid(), this.getSid(), sid);
		reservation.setRequestAccountSid(this.getRequestAccountSid());
		return reservation;
	}	


	/**
	 * Cancel.
	 *
	 * @return the task
	 * @throws TwilioRestException the twilio rest exception
	 */
	public TwilioTRTask cancel(String reason) {
		Map<String, String> vars = new Map<String, String>();
		vars.put('AssignmentStatus', 'canceled');
		vars.put('Reason', reason);


		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'POST', vars);

		TwilioTRTask t = new TwilioTRTask(this.getClient(), response.toMap());
		t.setRequestAccountSid(this.getRequestAccountSid());
		return t;
	}

	/**
	 * Delete.
	 *
	 * @return the task
	 * @throws TwilioRestException the twilio rest exception
	 */
	public TwilioTRTask deleteTask() {
		TwilioRestResponse response = this.getClient().safeRequest(
				this.getResourceLocation(), 'DELETE', null);

		TwilioTRTask t = new TwilioTRTask(this.getClient(), response.toMap());
		t.setRequestAccountSid(this.getRequestAccountSid());
		return t;
	}
}