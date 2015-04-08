global class TwilioMember extends TwilioResource.InstanceResource
{
    // Constants
    private final static String URL = 'Url';
    private final static String METHOD = 'Method';
    private final static String QUEUE_SID = 'queue_sid';
    private final static String CALL_SID = 'call_sid';
    private final static String DATE_ENQUEUED = 'date_enqueued';
    private final static String WAIT_TIME = 'wait_time';
    private final static String POSITION = 'position';
    
    public final static String QUEUE_FRONT = 'Front';
    
    //constructor
    public TwilioMember(TwilioRestClient client, String queueSid, String callSid) 
    {
        super(client);
        this.setProperty(QUEUE_SID, queueSid);
        this.setProperty(CALL_SID,callSid);
    }
    
    public TwilioMember(TwilioRestClient client,String queueSid) 
    {
        this(client,queueSid,QUEUE_FRONT);
    }

    public TwilioMember(TwilioRestClient client,Map<String, Object> properties,String queueSid) {
        super(client, properties);
        this.setProperty(QUEUE_SID, queueSid);
    }

    public String getQueueSid() {
        return this.getProperty(QUEUE_SID);
    }

    public String getCallSid() {
        return this.getProperty(CALL_SID);
    }

    public Datetime getDateEnqueued() 
    {
        return this.getPropertyDateTime(DATE_ENQUEUED);    
    }

    public String getWaitTime() {
        return this.getProperty(WAIT_TIME);
    }

    public String getPosition() {
        return this.getProperty(POSITION);
    }

    public override String getResourceLocation() {
        return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
                + this.getRequestAccountSid() + '/Queues/' + this.getQueueSid()
                + '/Members/' + this.getCallSid() + '.json';
    }

    public Datetime getDateCreated() 
    {
        return this.getPropertyDatetime('date_created');
    }
    
    public TwilioMember dequeue(String urlInfo, String methodInfo) 
    {
         Map<String, String> vars = new Map<String, String>();
        vars.put(URL, urlInfo);
        vars.put(METHOD, methodInfo);
        TwilioRestResponse response = this.getClient().safeRequest(this.getResourceLocation(), 'POST', vars);

        TwilioMember member = new TwilioMember((TwilioRestClient)this.getClient(), response.toMap(), getQueueSid());
        member.setRequestAccountSid(this.getRequestAccountSid());
        return member;
    }
}