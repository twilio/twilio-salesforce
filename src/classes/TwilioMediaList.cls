global class TwilioMediaList extends TwilioResource.ListResource implements Iterable<TwilioMedia> 
{ 

    private String requestMessageSid;

        /**
         * Instantiates a new media list.
         *
         * @param client the client
         */
        public TwilioMediaList(TwilioRestClient client) {
                super(client);
        }

        /**
         * Instantiates a new media list.
         *
         * @param client the client
         * @param messageSid the sid of the parent message requesting media
         */
        public TwilioMediaList(TwilioRestClient client, String messageSid) {
                super(client);
                this.requestMessageSid = messageSid;
        }

    /**
         * Instantiates a new media list.
         *
         * @param client the client
         * @param properties the properties
    */
    public TwilioMediaList(TwilioRestClient client, Map<String, String> properties) {
                super(client, properties);
    }
        

  /* implements method from TwilioResource.ListResource */
  public override Object makeNew(TwilioRestClient client, Map<String, Object> params) {
    return new TwilioMedia(client, params);
  }
  
  /* implements method from TwilioResource.ListResource */
  public override String getListKey() {
    return 'media_list';
  }
  
    /* implements method from TwilioResource */
    public override String getResourceLocation() 
    {
        if (this.requestMessageSid != null) 
        {
                                return '/' + TwilioRestClient.DEFAULT_VERSION
                                        + '/Accounts/' + this.getRequestAccountSid()
                                        + '/Messages/' + this.getRequestMessageSid()
                                        + '/Media.json';

                        } else {
                                return '/' + TwilioRestClient.DEFAULT_VERSION
                                        + '/Accounts/' + this.getRequestAccountSid()
                                        + '/Media.json';
        }
    }
  
    public String getRequestMessageSid() {
        return this.requestMessageSid;
    }
    
    public List<TwilioMedia> getPageData() {
        List<TwilioMedia> returnList = new List<TwilioMedia>();
    
        for (Object o : this.getObjectPageData()) {
            if (o instanceof TwilioMedia) {
                returnList.add((TwilioMedia) o);
            }
        }
        return returnList;
    }
    global Iterator<TwilioMedia> iterator() 
    {
        return new TwilioIterator.MediaIterator(this);
    }
    
}