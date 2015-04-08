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
global class TwilioTRWorkspace extends TwilioResource.InstanceResource {

	/**
	 * Instantiates a new workspace.
	 *
	 * @param client the client
	 */
	public TwilioTRWorkspace(TwilioTRRestClient client) {
    	super(client);
    }
    
    /**
	 * Instantiates a new workspace.
	 *
	 * @param client the client
	 * @param sid the sid
	 */
	public TwilioTRWorkspace(TwilioTRRestClient client, String sid) {
		super(client);
		this.setProperty('sid', sid);
	}

	/**
	 * Instantiates a new workspace.
	 *
	 * @param client  the client
	 * @param properties  properties to set on the new call as key/value pairs
	 */
	public TwilioTRWorkspace(TwilioTRRestClient client, Map<String, Object> properties) {
		super(client, properties);
	}

	/**
	 * Returns the URI of this resource, relative to the API endpoint.
	 */
	public override String getResourceLocation() {
		return '/' + TwilioTRRestClient.DEFAULT_VERSION + '/Workspaces/' + this.getSid();
	}
	
	/** 
	 * Returns the unique ID of this resource.
	 */
	public String getSid() {
		return this.getProperty('sid');
	}
	
	/**
	 * Returns the friendly name.
	 */
	public String getFriendlyName() {
		return this.getProperty('friendly_name');
	}

	/**
	 * Returns the account sid.
	 */
	public String getAccountSid() {
		return this.getProperty('account_sid');
	}

	/**
	 * Returns the default activity sid.
	 */
	public String getDefaultActivitySid() {
		return this.getProperty('default_activity_sid');
	}

	/**
	 * Returns the default activity name.
	 */
	public String getDefaultActivityName() {
		return this.getProperty('default_activity_name');
	}

	/**
	 * Returns the timeout activity sid.
	 */
	public String getTimeoutActivitySid() {
		return this.getProperty('timeout_activity_sid');
	}

	/**
	 * Returns the timeout activity name.
	 */
	public String getTimeoutActivityName() {
		return this.getProperty('timeout_activity_name');
	}

	/**
	 * Returns the event callback url.
	 */
	public String getEventCallbackUrl() {
		return this.getProperty('event_callback_url');
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

	/**
	 * Get the task list
	 * 
	 * @return
	 */
	public TwilioTRTaskList getTasks() {
		TwilioTRTaskList twlist = new TwilioTRTaskList((TwilioTRRestClient)this.getClient(), this.getSid());
		return twlist;
	}	

    /**
     * Returns the task list with the given filters.
     */
    public TwilioTRTaskList getTasks(Map<String, String> filters) {
        TwilioTRTaskList twlist = new TwilioTRTaskList((TwilioTRRestClient)this.getClient(), this.getSid(), filters);
        return twlist;
    }

    /**
     * Returns a given task instance by sid
     */
    public TwilioTRTask getTask(String sid) {
        TwilioTRTask task = new TwilioTRTask((TwilioTRRestClient)this.getClient(), this.getSid(), sid);
        return task;
    }

	/**
	 * Get the taskqueue list
	 * 
	 * @return
	 */
	public TwilioTRTaskQueueList getTaskQueues() {
		TwilioTRTaskQueueList twlist = new TwilioTRTaskQueueList((TwilioTRRestClient)this.getClient(), this.getSid());
		return twlist;
	}	

    /**
     * Returns the taskqueue list with the given filters.
     */
    public TwilioTRTaskQueueList getTaskQueues(Map<String, String> filters) {
        TwilioTRTaskQueueList twlist = new TwilioTRTaskQueueList((TwilioTRRestClient)this.getClient(), this.getSid(), filters);
        return twlist;
    }

    /**
     * Returns a given taskqueue instance by sid
     */
    public TwilioTRTaskQueue getTaskQueue(String sid) {
        TwilioTRTaskQueue queue = new TwilioTRTaskQueue((TwilioTRRestClient)this.getClient(), this.getSid(), sid);
        return queue;
    }


	/**
	 * Get the workflow list
	 * 
	 * @return
	 */
	public TwilioTRWorkflowList getWorkflows() {
		TwilioTRWorkflowList twlist = new TwilioTRWorkflowList((TwilioTRRestClient)this.getClient(), this.getSid());
		return twlist;
	}

    /**
     * Returns the workflow list with the given filters.
     */
    public TwilioTRWorkflowList getWorkflows(Map<String, String> filters) {
        TwilioTRWorkflowList twlist = new TwilioTRWorkflowList((TwilioTRRestClient)this.getClient(), this.getSid(), filters);
        return twlist;
    }

    /**
     * Returns a given workflow instance by sid
     */
    public TwilioTRWorkflow getWorkflow(String sid) {
        TwilioTRWorkflow workflow = new TwilioTRWorkflow((TwilioTRRestClient)this.getClient(), this.getSid(), sid);
        return workflow;
    }

	/**
	 * Get the worker list
	 * 
	 * @return
	 */
	public TwilioTRWorkerList getWorkers() {
		TwilioTRWorkerList twlist = new TwilioTRWorkerList((TwilioTRRestClient)this.getClient(), this.getSid());
		return twlist;
	}			

    /**
     * Returns the worker list with the given filters.
     */
    public TwilioTRWorkerList getWorkers(Map<String, String> filters) {
        TwilioTRWorkerList twlist = new TwilioTRWorkerList((TwilioTRRestClient)this.getClient(), this.getSid(), filters);
        return twlist;
    }


    /**
     * Returns a given worker instance by sid
     */
    public TwilioTRWorker getWorker(String sid) {
        TwilioTRWorker worker = new TwilioTRWorker((TwilioTRRestClient)this.getClient(), this.getSid(), sid);
        return worker;
    }

	/**
	 * Get the activities list
	 * 
	 * @return
	 */
	public TwilioTRActivitiesList getActivities() {
		TwilioTRActivitiesList twlist = new TwilioTRActivitiesList((TwilioTRRestClient)this.getClient(), this.getSid());
		return twlist;
	}

    /**
     * Returns the worker list with the given filters.
     */
    public TwilioTRActivitiesList getActivities(Map<String, String> filters) {
        TwilioTRActivitiesList twlist = new TwilioTRActivitiesList((TwilioTRRestClient)this.getClient(), this.getSid(), filters);
        return twlist;
    }
    
	/**
	 * Get the activiy
	 * 
	 * @return
	 */
	public TwilioTRActivities getActivity(String sid) {
		TwilioTRActivities activity = new TwilioTRActivities((TwilioTRRestClient)this.getClient(), this.getSid(), sid);
		return activity;
	}	
			
}