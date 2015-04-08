global class TwilioQueueList extends TwilioResource.ListResource implements Iterable<TwilioQueue>
{

    public TwilioQueueList(final TwilioRestClient client) {
        super(client);
    }
    
    public TwilioQueueList(TwilioRestClient client,Map<String, String> filters) {
        super(client, filters);
    }
    
    public TwilioQueue create(Map<String, String> params) {
    return (TwilioQueue)this.createInstance(params);
  }
    
    public TwilioQueue create(List<TwilioNameValuePair> params) {
      return (TwilioQueue) this.createInstance(params);    
    }
    
    public override Object makeNew(TwilioClient client, Map<String, Object> params) {
      TwilioQueue q = new TwilioQueue((TwilioRestClient)client, params);
      q.setRequestAccountSid(this.getRequestAccountSid());
      return q;
   }
   
     /* implements method from TwilioResource.ListResource */
  public override String getListKey() {
    return 'queues';
  }
  
   /* implements method from TwilioResource */
  public override String getResourceLocation() {
    return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
        + this.getRequestAccountSid() + '/Queues.json';
  }

  public List<TwilioQueue> getPageData() {
    List<TwilioQueue> returnList = new List<TwilioQueue>();
    
    for (Object o : this.getObjectPageData()) {
      if (o instanceof TwilioQueue) {
        returnList.add((TwilioQueue) o);
      }
    }
    return returnList;
  }
  
  global Iterator<TwilioQueue> iterator() {
    return new TwilioIterator.QueueIterator(this);
  }
}