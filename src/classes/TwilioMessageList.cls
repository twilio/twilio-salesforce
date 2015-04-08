/**
 * The class TwilioMessageList.
 * 
 * For more information see http://www.twilio.com/docs/api/rest/message
 */
global class TwilioMessageList extends TwilioResource.ListResource implements Iterable<TwilioMessage> { 
  
  /**
   * Instantiates a new sms list.
   *
   * @param client the client
   */
  public TwilioMessageList(TwilioRestClient client) {
    super(client);
  }

  /**
   * Instantiates a new sms list.
   *
   * @param client the client
   * @param filters the filters
   */
  public TwilioMessageList(TwilioRestClient client, Map<String, String> filters) {
    super(client, filters);
  }

  /* implements method from TwilioResource */
  public override String getResourceLocation() {
    return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
        + this.getRequestAccountSid() + '/Messages.json';
  }

  /* implements method from TwilioResource.ListResource */
  public override Object makeNew(TwilioClient client, Map<String, Object> params) {
    TwilioMessage msg = new TwilioMessage((TwilioRestClient)client, params);
    msg.setRequestAccountSid(this.getRequestAccountSid());
    return msg;
  }

  /* implements method from TwilioResource.ListResource */
  public override String getListKey() {
    return 'messages';
  }
  
  /**
   * Send a new message using the supplied parameters
   *
   * See http://www.twilio.com/docs/api/rest/sending-messages
   *   for a list of parameters
   */
  public TwilioMessage create(Map<String, String> params) {
    return (TwilioMessage)this.createInstance(params);
  }
    
    public TwilioMessage create(List<TwilioNameValuePair> params) {
    	return (TwilioMessage) this.createInstance(params);    
    }
  
  public List<TwilioMessage> getPageData() {
    List<TwilioMessage> returnList = new List<TwilioMessage>();
    
    for (Object o : this.getObjectPageData()) {
      if (o instanceof TwilioMessage) {
        returnList.add((TwilioMessage) o);
      }
    }
    return returnList;
  }
  
  global Iterator<TwilioMessage> iterator() {
    return new TwilioIterator.MessageIterator(this);
  }

}