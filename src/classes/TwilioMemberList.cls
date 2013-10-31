global class TwilioMemberList extends TwilioResource.ListResource implements Iterable<TwilioMember>
{

    private String queueSid;

    public TwilioMemberList(TwilioRestClient client) 
    {
        super(client);
    }
    
    public TwilioMemberList(TwilioRestClient client,Map<String, String> filters) {
        super(client, filters);
    }
    
    public TwilioMemberList(TwilioRestClient client,String queueSid) {
        super(client);
        this.queueSid = queueSid;
    }
    
    /* implements method from TwilioResource.ListResource */
    public override Object makeNew(TwilioRestClient client, Map<String, Object> params) {
        return new TwilioMember(client, params, queueSid);
    }
    
    /* implements method from TwilioResource.ListResource */
    public override String getListKey() {
        return 'queue_members';
    }
    
    /* implements method from TwilioResource */
    public override String getResourceLocation() {
        return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
                + this.getRequestAccountSid() + '/Queues/'
                + this.queueSid + '/Members.json';
    }
    
    /* implement method from Iterable<TwilioMember> interface */
    global Iterator<TwilioMember> iterator() 
    {
        return new TwilioIterator.MemberIterator(this);
    }
}