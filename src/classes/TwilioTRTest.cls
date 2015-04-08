@isTest
private class TwilioTRTest {
	
    final static String authToken = '12345678901234567890123456789012';
    // TwilioTRTask -- BEGIN

    // Get an API client and request the Twilio Account
    private static TwilioTRRestClient client = new TwilioTRRestClient('AC00000000000000000000000000000000', authToken);
    private static String rootURL = 'https://taskrouter.twilio.com/v1/Workspaces';
  	private static String resourceLocation_Task =  rootURL + '/WS00000000000000000000000000000000/Tasks/WT00000000000000000000000000000000'; 
    private static String resourceLocation_TaskList =  rootURL + '/WS00000000000000000000000000000000/Tasks'; 
   	private static String resourceLocation_Worker = rootURL + '/WS00000000000000000000000000000000/Workers/WK00000000000000000000000000000000';
   	private static String resourceLocation_WorkerList = rootURL + '/WS00000000000000000000000000000000/Workers';
   	private static String resourceLocation_TaskQueue = rootURL + '/WS00000000000000000000000000000000/TaskQueues/WQ00000000000000000000000000000000';
   	private static String resourceLocation_TaskQueueList = rootURL + '/WS00000000000000000000000000000000/TaskQueues';
   	private static String resourceLocation_Reservation = rootURL + '/WS00000000000000000000000000000000/Tasks/WT00000000000000000000000000000000/Reservations/WR00000000000000000000000000000000';
   	private static String resourceLocation_ReservationList = rootURL + '/WS00000000000000000000000000000000/Tasks/WT00000000000000000000000000000000/Reservations';
   	private static String resourceLocation_Activities = rootURL + '/WS00000000000000000000000000000000/Activities/WA00000000000000000000000000000000';
   	private static String resourceLocation_ActivitiesList = rootURL + '/WS00000000000000000000000000000000/Activities';
   	private static String resourceLocation_Workflow = rootURL + '/WS00000000000000000000000000000000/Workflows/WW00000000000000000000000000000000';
   	private static String resourceLocation_WorkflowList = rootURL + '/WS00000000000000000000000000000000/Workflows';
   	private static String resourceLocation_Workspace = rootURL + '/WS00000000000000000000000000000000';
   	private static String resourceLocation_WorkspaceList = rootURL;

   
    static {
		// --- TRTask Test Response
      	String jsonResponse_Task ='{"sid": "WT00000000000000000000000000000000", "account_sid": "AC00000000000000000000000000000000", "assignment_status": "reserved", ' + 
    		'"attributes": "{}", "date_created": "2015-01-01T00:00:00Z", "date_updated": "2015-01-01T00:00:00Z", ' + 
    		'"priority": 1, "age": 36, "reason": null, "timeout": 86400, "workspace_sid": "WS00000000000000000000000000000000", "workflow_sid": "WW00000000000000000000000000000000",' + 
    		'"workflow_friendly_name": "Workflow Name", "task_queue_sid": "WQ00000000000000000000000000000000", "task_queue_friendly_name": "TaskQueue Name", ' +
    		'"url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Tasks/WT00000000000000000000000000000000", ' + 
    		'"links": {"task_queue": "hhttps://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/TaskQueues/WQ00000000000000000000000000000000", ' +
    		'"workflow": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workflows/WW00000000000000000000000000000000",' +
    		'"workspace": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000"}}';

    	// --- TRTaskList Test Response
    	String jsonResponse_TaskList = '{"tasks": [' + jsonResponse_Task + '],' + 
    		'"meta": {"page": 0, "page_size": 50, "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Tasks?PageSize=50&Page=0",'+
    		'"previous_page_url": null, "url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Tasks?PageSize=50&Page=0", "next_page_url": null, "key": "tasks"}}';       

        loadMockResponse(resourceLocation_Task, jsonResponse_Task);
        loadMockResponse(resourceLocation_TaskList, jsonResponse_TaskList);


        // -- TRWorker Test Response
		String jsonResponse_Worker = '{"sid": "WK00000000000000000000000000000000", "friendly_name": "friendly name", "account_sid": "AC00000000000000000000000000000000",' + 
			'"activity_sid": "WA00000000000000000000000000000000", "activity_name": "Idle", "workspace_sid": "WS00000000000000000000000000000000", ' + 
			'"attributes": "{}", "available": true, "date_created": "2015-01-01T00:00:00Z", "date_updated": "2015-01-01T00:00:00Z", ' + 
			'"date_status_changed": "2015-01-01T00:00:00Z", "url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workers/WK00000000000000000000000000000000",' + 
			'"links": {"activity": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Activities/WA00000000000000000000000000000000",' + 
			'"workspace": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000"}}';

    	// --- TRWorker Test Response
    	String jsonResponse_WorkerList = '{"workers": [' + jsonResponse_Worker + '],' + 
    		'"meta": {"page": 0, "page_size": 50, "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workers?PageSize=50&Page=0",'+
    		'"previous_page_url": null, "url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workers?PageSize=50&Page=0", "next_page_url": null, "key": "workers"}}';       

        loadMockResponse(resourceLocation_Worker, jsonResponse_Worker);
        loadMockResponse(resourceLocation_WorkerList, jsonResponse_WorkerList);

        // -- TRTaskQueue Test Response
		String jsonResponse_TaskQueue = '{"sid": "WQ00000000000000000000000000000000", "account_sid": "AC00000000000000000000000000000000", ' +
			'"workspace_sid": "WS00000000000000000000000000000000", "friendly_name": "friendly name", "target_workers": "1=1",' +
			'"reservation_activity_sid": "WA00000000000000000000000000000000", "reservation_activity_name": "Reserved", '+
			'"assignment_activity_sid": "WA00000000000000000000000000000000", "assignment_activity_name": "Busy", '+
			'"date_created": "2015-01-01T00:00:00Z", "date_updated": "2015-01-01T00:00:00Z", '+
			'"url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/TaskQueues/WQ00000000000000000000000000000000",'+
			'"links": {"assignment_activity": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Activities/WA00000000000000000000000000000000",' +
			'"reservation_activity": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Activities/WA00000000000000000000000000000000", '+
			'"workspace": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000"}}';

    	// --- TRTaskQueue Test Response
    	String jsonResponse_TaskQueueList = '{"task_queues": [' + jsonResponse_TaskQueue + '],' + 
    		'"meta": {"page": 0, "page_size": 50, "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/TaskQueues?PageSize=50&Page=0",'+
    		'"previous_page_url": null, "url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/TaskQueues?PageSize=50&Page=0", "next_page_url": null, "key": "task_queues"}}';       

        loadMockResponse(resourceLocation_TaskQueue, jsonResponse_TaskQueue);
        loadMockResponse(resourceLocation_TaskQueueList, jsonResponse_TaskQueueList);

        // -- TRReservation Test Response
        String jsonResponse_Reservation = '{"sid": "WR00000000000000000000000000000000", "account_sid": "AC00000000000000000000000000000000",' + 
        	'"workspace_sid": "WS00000000000000000000000000000000", "task_sid": "WT00000000000000000000000000000000", ' + 
        	'"worker_sid": "WK00000000000000000000000000000000", "worker_name": "worker name", "reservation_status": "timeout", ' + 
        	'"date_created": "2015-01-01T00:00:00Z", "date_updated": "2015-01-01T00:00:00Z",' +
        	'"url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Tasks/WT00000000000000000000000000000000/Reservations/WR00000000000000000000000000000000",'+
        	'"links": {"task": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Tasks/WT00000000000000000000000000000000",'+
        	'"worker": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workers/WK00000000000000000000000000000000", '+
        	'"workspace": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000"}}';

    	String jsonResponse_ReservationList = '{"reservations": [' + jsonResponse_Reservation + '],' + 
    		'"meta": {"page": 0, "page_size": 50, "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Tasks/WT00000000000000000000000000000000/Reservations?PageSize=50&Page=0",'+
    		'"previous_page_url": null, "url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Tasks/WT00000000000000000000000000000000/Reservations?PageSize=50&Page=0", "next_page_url": null, "key": "reservations"}}';       

        loadMockResponse(resourceLocation_Reservation, jsonResponse_Reservation);
        loadMockResponse(resourceLocation_ReservationList, jsonResponse_ReservationList);

		// -- TRActivities
        String jsonResponse_Activities = '{"sid": "WA00000000000000000000000000000000", "account_sid": "AC00000000000000000000000000000000",'+
        	'"workspace_sid": "WS00000000000000000000000000000000", "friendly_name": "Offline", "available": false, ' +
        	'"date_created": "2015-01-01T00:00:00Z", "date_updated": "2015-01-01T00:00:00Z", '+
        	'"url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Activities/WA00000000000000000000000000000000",'+
        	'"links": {"workspace": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000"}}';

   		// --- TRActivities List  Test Response
    	String jsonResponse_ActivitiesList = '{"activities": [' + jsonResponse_Activities + '],' + 
    		'"meta": {"page": 0, "page_size": 50, "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Activities?PageSize=50&Page=0",'+
    		'"previous_page_url": null, "url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Activities?PageSize=50&Page=0", "next_page_url": null, "key": "activities"}}';       

 		loadMockResponse(resourceLocation_Activities, jsonResponse_Activities);
 		loadMockResponse(resourceLocation_ActivitiesList, jsonResponse_ActivitiesList);

 		// --- TRWorkflows

 		String jsonResponse_Workflow = '{"sid": "WW00000000000000000000000000000000", "friendly_name": "Workflow Name", ' +
 			'"account_sid": "AC00000000000000000000000000000000", "workspace_sid": "WS00000000000000000000000000000000", ' + 
 			'"assignment_callback_url": "https://taskrouter/twilio/workspace/workflow", ' + 
 			'"fallback_assignment_callback_url": "https://taskrouter/twilio/fallback/workspace/workflow", "document_content_type": null, "configuration": "{}", ' + 
 			'"task_reservation_timeout": 60, "date_created": "2015-01-01T00:00:00Z", "date_updated": "2015-01-01T00:00:00Z", ' +
 			'"url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workflows/WW00000000000000000000000000000000", '+
 			'"links": {"workspace": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000"}}';

    	String jsonResponse_WorkflowList = '{"workflows": [' + jsonResponse_Workflow + '],' + 
    		'"meta": {"page": 0, "page_size": 50, "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workflows?PageSize=50&Page=0",'+
    		'"previous_page_url": null, "url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workflows?PageSize=50&Page=0", "next_page_url": null, "key": "workflows"}}';       

 		loadMockResponse(resourceLocation_Workflow, jsonResponse_Workflow);
 		loadMockResponse(resourceLocation_WorkflowList, jsonResponse_WorkflowList);

        // --- TRWorkspaces

        String jsonResponse_Workspace = '{"sid": "WS00000000000000000000000000000000", "account_sid": "AC00000000000000000000000000000000",'+
            '"friendly_name": "Friendly Name", "event_callback_url": "https://taskrouter/twilio/workspace", '+
            '"default_activity_sid": "WA00000000000000000000000000000000", "date_created": "2015-01-01T00:00:00Z", ' +
            '"date_updated": "2015-01-01T00:00:00Z", "default_activity_name": "Offline", "timeout_activity_sid": "WA00000000000000000000000000000000",'+
            '"timeout_activity_name": "Idle", "url": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000", ' +
            '"links": {"activities": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Activities", '+
            '"task_queues": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/TaskQueues", ' +
            '"statistics": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Statistics", ' +
            '"tasks": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Tasks", '+
            '"workers": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workers",' +
            '"workflows": "https://taskrouter.twilio.com/v1/Workspaces/WS00000000000000000000000000000000/Workflows"}}';

        String jsonResponse_WorkspaceList = '{"workspaces": [' + jsonResponse_Workspace + '],' + 
            '"meta": {"page": 0, "page_size": 50, "first_page_url": "https://taskrouter.twilio.com/v1/Workspaces?PageSize=50&Page=0",'+
            '"previous_page_url": null, "url": "https://taskrouter.twilio.com/v1/Workspaces?PageSize=50&Page=0", "next_page_url": null, "key": "workspaces"}}';       

        loadMockResponse(resourceLocation_Workspace, jsonResponse_Workspace);
        loadMockResponse(resourceLocation_WorkspaceList, jsonResponse_WorkspaceList);
    }

    static void loadMockResponse(String resourceLocation, String jsonResponse) {
    	Twilio_TestHTTPMock.getInstance().putResponse('GET',resourceLocation,new Twilio_TestHTTPMock.Response(jsonResponse,200));
    	Twilio_TestHTTPMock.getInstance().putResponse('POST',resourceLocation,new Twilio_TestHTTPMock.Response(jsonResponse,200));
    	Twilio_TestHTTPMock.getInstance().putResponse('DELETE',resourceLocation,new Twilio_TestHTTPMock.Response(jsonResponse,200));
    }


    static testMethod void testTwilioTRTask() {    

        TwilioTRRestClient cli = TwilioAPI.getDefaultTRClient();

		TwilioTRTaskList trTaskList = new TwilioTRTaskList(client);
		trTaskList = new TwilioTRTaskList(client, 'WS00000000000000000000000000000000', new Map<String, String>());
		trTaskList = client.getWorkspace('WS00000000000000000000000000000000').getTasks();
        TwilioTRTask trTask = client.getWorkspace('WS00000000000000000000000000000000').getTask('WT00000000000000000000000000000000');
        List<TwilioTRTask> trTasks = trTaskList.getPageData();
       
        Iterator<TwilioTRTask> it = trTaskList.iterator();
        System.assertEquals(true, it.hasNext());
        trTask=it.next();  
        
     	system.assertEquals('WT00000000000000000000000000000000', trTask.getSid());
     	system.assertEquals('AC00000000000000000000000000000000', trTask.getAccountSid());
     	system.assertEquals('WS00000000000000000000000000000000', trTask.getWorkspaceSid());
     	system.assertEquals('WW00000000000000000000000000000000', trTask.getWorkflowSid());
 	    system.assertEquals('WQ00000000000000000000000000000000', trTask.getTaskQueueSid());
     	system.assertEquals(86400, trTask.getTimeout());
     	system.assertEquals('{}', trTask.getAttributes());
     	system.assertEquals(36, trTask.getAge());
     	system.assertEquals('TaskQueue Name', trTask.getTaskQueueFriendlyName());
     	system.assertEquals('Workflow Name', trTask.getWorkflowFriendlyName());
     	system.assertEquals('reserved', trTask.getAssignmentStatus());     	
     	system.assertEquals(null, trTask.getReason());
     	system.assertEquals(1, trTask.getPriority());
     	system.assertEquals(Datetime.newInstanceGmt(2015,01,01,00,00,00), trTask.getDateCreated());
     	system.assertEquals(Datetime.newInstanceGmt(2015,01,01,00,00,00), trTask.getDateUpdated());
     	system.assertEquals(resourceLocation_Task, 'https://taskrouter.twilio.com' + trTask.getResourceLocation());
     	system.assertEquals(resourceLocation_TaskList, 'https://taskrouter.twilio.com' + trTaskList.getResourceLocation());
        system.assertEquals('tasks',trTaskList.getListKey());
        trTask.cancel('This task is now canceled'); 
     	trTask.deleteTask();
        trTask.getSubresourceUris();
    }

    static testMethod void testTwilioTRWorker() {
		TwilioTRWorkerList trWorkerList = new TwilioTRWorkerList(client);
		trWorkerList = new TwilioTRWorkerList(client, 'WS00000000000000000000000000000000', new Map<String, String>());
		trWorkerList = client.getWorkspace('WS00000000000000000000000000000000').getWorkers();
        TwilioTRWorker trWorker = client.getWorkspace('WS00000000000000000000000000000000').getWorker('WK00000000000000000000000000000000');

        List<TwilioTRWorker> trWorkers = trWorkerList.getPageData();
        
        Iterator<TwilioTRWorker> it = trWorkerList.iterator();
        System.assertEquals(true, it.hasNext());
        trWorker=it.next();  

    	system.assertEquals(trWorker.getSid(), 'WK00000000000000000000000000000000');
     	system.assertEquals(trWorker.getAccountSid(), 'AC00000000000000000000000000000000');
     	system.assertEquals(trWorker.getWorkspaceSid(), 'WS00000000000000000000000000000000');
     	system.assertEquals(trWorker.getActivitySid(), 'WA00000000000000000000000000000000');
 	    system.assertEquals(trWorker.getFriendlyName(), 'friendly name');
 	    system.assertEquals(trWorker.getActivityName(), 'Idle');
 	    system.assertEquals(trWorker.getAvailable(), true);
 	    system.assertEquals(trWorker.getAttributes(),'{}');
     	system.assertEquals(trWorker.getDateStatusChanged(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals(trWorker.getDateCreated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals(trWorker.getDateUpdated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals('https://taskrouter.twilio.com' + trWorker.getResourceLocation(), resourceLocation_Worker);
     	system.assertEquals(resourceLocation_WorkerList, 'https://taskrouter.twilio.com' + trWorkerList.getResourceLocation());   
        system.assertEquals('workers',trWorkerList.getListKey());
        trWorker.getSubresourceUris();
    }

    static testMethod void testTwilioTRTaskQueue() {
		TwilioTRTaskQueueList trTaskQueueList = new TwilioTRTaskQueueList(client);
		trTaskQueueList = new TwilioTRTaskQueueList(client, 'WS00000000000000000000000000000000', new Map<String, String>());
		trTaskQueueList = client.getWorkspace('WS00000000000000000000000000000000').getTaskQueues();
        TwilioTRTaskQueue trTaskQueue = client.getWorkspace('WS00000000000000000000000000000000').getTaskQueue('WQ00000000000000000000000000000000');

        List<TwilioTRTaskQueue> trTaskQueues = trTaskQueueList.getPageData();
        Iterator<TwilioTRTaskQueue> it = trTaskQueueList.iterator();
        System.assertEquals(true, it.hasNext());
        trTaskQueue=it.next();  

    	system.assertEquals(trTaskQueue.getSid(), 'WQ00000000000000000000000000000000');
     	system.assertEquals(trTaskQueue.getAccountSid(), 'AC00000000000000000000000000000000');
     	system.assertEquals(trTaskQueue.getWorkspaceSid(), 'WS00000000000000000000000000000000');
     	system.assertEquals(trTaskQueue.getTargetWorkers(), '1=1');
     	system.assertEquals(trTaskQueue.getFriendlyName(), 'friendly name');
     	system.assertEquals(trTaskQueue.getReservationActivitySid(), 'WA00000000000000000000000000000000');
    	system.assertEquals(trTaskQueue.getReservationActivityName(), 'Reserved');
     	system.assertEquals(trTaskQueue.getAssignmentActivitySid(), 'WA00000000000000000000000000000000');
    	system.assertEquals(trTaskQueue.getAssignmentActivityName(), 'Busy');
     	system.assertEquals(trTaskQueue.getDateCreated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals(trTaskQueue.getDateUpdated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals('https://taskrouter.twilio.com' + trTaskQueue.getResourceLocation(), resourceLocation_TaskQueue);
     	system.assertEquals(resourceLocation_TaskQueueList, 'https://taskrouter.twilio.com' + trTaskQueueList.getResourceLocation());    
        system.assertEquals('task_queues',trTaskQueueList.getListKey());
        trTaskQueue.getSubresourceUris();              	
    }

	static testMethod void testTwilioTRReservation() {
		TwilioTRReservationList trReservationList = new TwilioTRReservationList(client);
		trReservationList = new TwilioTRReservationList(client, 'WS00000000000000000000000000000000', new Map<String, String>());
		trReservationList = client.getWorkspace('WS00000000000000000000000000000000').getTask('WT00000000000000000000000000000000').getReservations();
        TwilioTRReservation trReservation = client.getWorkspace('WS00000000000000000000000000000000').getTask('WT00000000000000000000000000000000').getReservation('WR00000000000000000000000000000000');
        List<TwilioTRReservation> trReservations = trReservationList.getPageData();
   
        Iterator<TwilioTRReservation> it = trReservationList.iterator();
        System.assertEquals(true, it.hasNext());
        trReservation=it.next(); 

    	system.assertEquals(trReservation.getSid(), 'WR00000000000000000000000000000000');
     	system.assertEquals(trReservation.getAccountSid(), 'AC00000000000000000000000000000000');
     	system.assertEquals(trReservation.getWorkspaceSid(), 'WS00000000000000000000000000000000');
     	system.assertEquals(trReservation.getTaskSid(), 'WT00000000000000000000000000000000');     		
     	system.assertEquals(trReservation.getReservationStatus(), 'timeout');
     	system.assertEquals(trReservation.getWorkerName(), 'worker name');
     	system.assertEquals(trReservation.getWorkerSid(), 'WK00000000000000000000000000000000');
     	system.assertEquals(trReservation.getDateCreated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals(trReservation.getDateUpdated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals('https://taskrouter.twilio.com' + trReservation.getResourceLocation(), resourceLocation_Reservation);
     	system.assertEquals(resourceLocation_ReservationList, 'https://taskrouter.twilio.com' + trReservationList.getResourceLocation());            	
     	trReservation.accept();
     	trReservation.reject();
        system.assertEquals('reservations',trReservationList.getListKey());
        trReservation.getSubresourceUris();       
	}

	static testMethod void testTwilioTRActivities() {
		TwilioTRActivitiesList trActivitiesList = new TwilioTRActivitiesList(client);
		trActivitiesList = new TwilioTRActivitiesList(client, 'WS00000000000000000000000000000000', new Map<String, String>());
		trActivitiesList = client.getWorkspace('WS00000000000000000000000000000000').getActivities();
        TwilioTRActivities trActivities = client.getWorkspace('WS00000000000000000000000000000000').getActivity('WA00000000000000000000000000000000');
        List<TwilioTRActivities> trActivitiesL = trActivitiesList.getPageData();

        Iterator<TwilioTRActivities> it = trActivitiesList.iterator();
        System.assertEquals(true, it.hasNext());
        trActivities=it.next(); 

    	system.assertEquals(trActivities.getSid(), 'WA00000000000000000000000000000000');
     	system.assertEquals(trActivities.getAccountSid(), 'AC00000000000000000000000000000000');
     	system.assertEquals(trActivities.getFriendlyName(), 'Offline');
     	system.assertEquals(trActivities.getAvailable(), false);
		system.assertEquals(trActivities.getWorkspaceSid(), 'WS00000000000000000000000000000000');
     	system.assertEquals(trActivities.getDateCreated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals(trActivities.getDateUpdated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals('https://taskrouter.twilio.com' + trActivities.getResourceLocation(), resourceLocation_Activities);
     	system.assertEquals(resourceLocation_ActivitiesList, 'https://taskrouter.twilio.com' + trActivitiesList.getResourceLocation());   
        system.assertEquals('activities',trActivitiesList.getListKey());
        trActivities.getSubresourceUris();             	
	}

	static testMethod void testTwilioTRWorkflow() {
		TwilioTRWorkflowList trWorkflowList = new TwilioTRWorkflowList(client);
		trWorkflowList = new TwilioTRWorkflowList(client, 'WS00000000000000000000000000000000', new Map<String, String>());
		trWorkflowList = client.getWorkspace('WS00000000000000000000000000000000').getWorkflows();
        TwilioTRWorkflow trWorkflow = client.getWorkspace('WS00000000000000000000000000000000').getWorkflow('WW00000000000000000000000000000000');
        List<TwilioTRWorkflow> trWorkflows = trWorkflowList.getPageData();

        Iterator<TwilioTRWorkflow> it = trWorkflowList.iterator();
        System.assertEquals(true, it.hasNext());
        trWorkflow=it.next(); 

    	system.assertEquals(trWorkflow.getSid(), 'WW00000000000000000000000000000000');
     	system.assertEquals(trWorkflow.getAccountSid(), 'AC00000000000000000000000000000000');
     	system.assertEquals(trWorkflow.getFriendlyName(), 'Workflow Name');
     	system.assertEquals(trWorkflow.getConfiguration(), '{}');
     	system.assertEquals(trWorkflow.getFallbackAssignmentCallbackUrl(), 'https://taskrouter/twilio/fallback/workspace/workflow');
     	system.assertEquals(trWorkflow.getAssignmentCallbackUrl(), 'https://taskrouter/twilio/workspace/workflow');
     	system.assertEquals(trWorkflow.getTaskReservationTimeout(), 60);
     	system.assertEquals(trWorkflow.getDocumentContentType(), null);
		system.assertEquals(trWorkflow.getWorkspaceSid(), 'WS00000000000000000000000000000000');
     	system.assertEquals(trWorkflow.getDateCreated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals(trWorkflow.getDateUpdated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
     	system.assertEquals('https://taskrouter.twilio.com' + trWorkflow.getResourceLocation(), resourceLocation_Workflow);
     	system.assertEquals(resourceLocation_WorkflowList, 'https://taskrouter.twilio.com' + trWorkflowList.getResourceLocation());       	
        system.assertEquals('workflows',trWorkflowList.getListKey());
        trWorkflow.getSubresourceUris(); 
	}

    static testMethod void testTwilioTRWorkspace() {
        TwilioTRWorkspaceList trWorkspaceList = new TwilioTRWorkspaceList(client);
        trWorkspaceList = new TwilioTRWorkspaceList(client, new Map<String, String>());
        trWorkspaceList = client.getWorkspaces();
        TwilioTRWorkspace trWorkspace= client.getWorkspace('WS00000000000000000000000000000000');
        List<TwilioTRWorkspace> trWorkspaces = trWorkspaceList.getPageData();

        Iterator<TwilioTRWorkspace> it = trWorkspaceList.iterator();
        System.assertEquals(true, it.hasNext());
        trWorkspace=it.next(); 
        
        system.assertEquals(trWorkspace.getSid(), 'WS00000000000000000000000000000000');
        system.assertEquals(trWorkspace.getAccountSid(), 'AC00000000000000000000000000000000');
        system.assertEquals(trWorkspace.getFriendlyName(), 'Friendly Name');
        system.assertEquals(trWorkspace.getTimeoutActivityName(), 'Idle');
        system.assertEquals(trWorkspace.getTimeoutActivitySid(), 'WA00000000000000000000000000000000');
        system.assertEquals(trWorkspace.getDefaultActivityName(), 'Offline');
        system.assertEquals(trWorkspace.getDefaultActivitySid(), 'WA00000000000000000000000000000000');
        system.assertEquals(trWorkspace.getEventCallbackUrl(), 'https://taskrouter/twilio/workspace');
        system.assertEquals(trWorkspace.getDateCreated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
        system.assertEquals(trWorkspace.getDateUpdated(), Datetime.newInstanceGmt(2015,01,01,00,00,00));
        system.assertEquals('https://taskrouter.twilio.com' + trWorkspace.getResourceLocation(), resourceLocation_Workspace);
        system.assertEquals(resourceLocation_WorkspaceList, 'https://taskrouter.twilio.com' + trWorkspaceList.getResourceLocation());        
        system.assertEquals('workspaces',trWorkspaceList.getListKey());
        trWorkspace.getSubresourceUris(); 
    }  

    static testMethod void testTwilioTRCapability() {
        
        TwilioTRCapability trCapability = TwilioAPI.createTRCapability('WS00000000000000000000000000000000', 'WK00000000000000000000000000000000');
        trCapability.allowTaskReservationUpdates();
        trCapability.allowWorkerActivityUpdates();
        trCapability.allowWorkerFetchAttributes();
        String capabilityToken = trCapability.generateToken();
    }
}