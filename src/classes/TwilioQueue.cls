global class TwilioQueue extends TwilioResource.InstanceResource
{

    // Constants
    private static final String SID_PROPERTY = 'sid';
    private static final String FRIENDLY_NAME = 'friendly_name';
    private static final String CURRENT_SIZE = 'current_size';
    private static final String MAX_SIZE = 'max_size';
    private static final String AVERAGE_WAIT_TIME = 'average_wait_time';
    
    public TwilioQueue(TwilioRestClient client, String sid) 
    {
        super(client);
        this.setProperty(SID_PROPERTY, sid);
    }
    
    public TwilioQueue(TwilioRestClient client, Map<String, Object> params) {
        super(client, params);
    }
    
    /* implements method from TwilioResource */
    public override String getResourceLocation() 
    {
        return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
                + this.getRequestAccountSid() + '/Queues/' + this.getSid();
        return null;
    }
    
    public String getSid() {
        return this.getProperty(SID_PROPERTY);
    }
    
    public String getFriendlyName() {
        return this.getProperty(FRIENDLY_NAME);
    }
    
    public Integer getCurrentSize() {
        Integer prop = this.getPropertyInteger(CURRENT_SIZE);
        if (prop != null) {
            return prop;
        } else {
            throw new TwilioRestException('The Queue instance doesn\'t have the current size property set');
        }
    }
    
    public Integer getMaxSize() {
        Integer prop = this.getPropertyInteger(MAX_SIZE);
        if (prop != null) {
            return prop;
        } else {
            throw new TwilioRestException('The Queue instance doesn\'t have the max size property set');
        }
    }

    public Integer getAverageWaitTime() {
        Integer prop = (Integer) this.getPropertyInteger(AVERAGE_WAIT_TIME);
        if (prop != null) {
            return prop;
        } else {
            throw new TwilioRestException('The Queue instance doesn\'t have the average wait time property set');
        }
    }

    public TwilioMemberList getMembers() 
    {
        TwilioMemberList memberlist = new TwilioMemberList(this.getClient(), this.getSid());
        memberlist.setRequestAccountSid(this.getRequestAccountSid());
        return memberlist;
    }

    public TwilioMember getMember(String callSid) {
        TwilioMember member = new TwilioMember(this.getClient(), this.getSid(), callSid);
        member.setRequestAccountSid(this.getRequestAccountSid());
        return member;
    }
    
    public TwilioMember dequeueHeadOfQueue(String url, String method){
        TwilioMember m = new TwilioMember(this.getClient(), this.getSid());
        m.setRequestAccountSid(this.getRequestAccountSid());
        return m.dequeue(url, method);
    }

    public void setFriendlyName(String friendlyName){
        Map<String, String> vars = new Map<String, String>();
        vars.put(FRIENDLY_NAME, friendlyName);
        TwilioRestResponse response = this.getClient().safeRequest(this.getResourceLocation(), 'POST', vars);
        if (response.isError()) {
            throw new TwilioRestException('Response indicated error:' + response.getResponseText());
        }
        this.setProperty(FRIENDLY_NAME, friendlyName);
    }

    public void setMaxSize(Integer maxSize){
        Map<String, String> vars = new Map<String, String>();
        String maxSizeString = String.valueof(maxSize);
        vars.put(MAX_SIZE, maxSizeString);
        TwilioRestResponse response = this.getClient().safeRequest(this.getResourceLocation(), 'POST', vars);
        if (response.isError()) {
            throw new TwilioRestException('Response indicated error:' + response.getResponseText());
        }
       this.setProperty(MAX_SIZE, maxSizeString);
    }
}