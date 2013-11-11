global class TwilioMedia extends TwilioResource.InstanceResource 
{
    /** The Constant SID_PROPERTY. */
    private static final String SID_PROPERTY = 'sid';
    private static String requestMessageSid;
    
    /**
     * Instantiates a new Media.
     *
     * @param client the client
     */
    public TwilioMedia(TwilioRestClient client) {
        super(client);
    }

    /**
     * Instantiates a new Media.
     *
     * @param client the client
     * @param sid the sid
     */
    public TwilioMedia(TwilioRestClient client, String sid) {
        super(client);
        this.setProperty(SID_PROPERTY, sid);
    }

     /**
         * Instantiates a new media instance.
         *
         * @param client the client
         * @param messageSid the sid of the parent message
         * @param mediaSid the sid
     */
     
     public TwilioMedia(TwilioRestClient client, String messageSid, String mediaSid) {
         super(client);
         requestMessageSid = messageSid;
         this.setProperty(SID_PROPERTY, mediaSid);
     }
        
    /**
     * Instantiates a new Media.
     *
     * @param client the client
     * @param properties the properties
     */
    public TwilioMedia(TwilioRestClient client, Map<String, Object> properties) {
        super(client, properties);
    }
    
    public override String getResourceLocation() 
    {
        if (this.getRequestMessageSid() != null) 
        {
            return '/' + TwilioRestClient.DEFAULT_VERSION
                + '/Accounts/' + this.getRequestAccountSid()
                + '/Messages/' + this.getRequestMessageSid()
                + '/Media/' + this.getSid() + '.json';
        } 
        else 
        {
            return '/' + TwilioRestClient.DEFAULT_VERSION
                + '/Accounts/' + this.getRequestAccountSid()
                + '/Media/' + this.getSid() + '.json';
        }
    }
    
    /**
    * Gets the sid.
    *
    * @return the sid
    */
    
    public String getSid() {
        return this.getProperty(SID_PROPERTY);
    }

        /**
         * Gets the sid of the requesting message
         *
         * @return the sid of the requesting message
         */
        public String getRequestMessageSid() {
                return this.getProperty(requestMessageSid);
        }

        /**
         * Gets the date created.
         *
         * @return the date created
         */
        public Datetime getDateCreated() {
                return this.getPropertyDatetime('date_created');
        }

        /**
         * Gets the date updated.
         *
         * @return the date updated
         */
        public Datetime getDateUpdated() {
                return this.getPropertyDatetime('date_updated');
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
         * Gets the parent sid.
         *
         * @return the account sid
         */
        public String getParentSid() {
                return this.getProperty('parent_sid');
        }

        /**
         * Gets the content type
         *
         * @return the content type
         */
        public String getContentType() {
                return this.getProperty('content_type');
        }
        
        /**
         * Gets the api version.
         *
         * @return the api version
         */
        public String getApiVersion() {
                return this.getProperty('api_version');
        }

        /**
         * Gets the uri of this media
         *
         * @return the uri
         */
        public String getUri() {
                return this.getProperty('uri');
        }

        /**
         * Delete this Media
         *
         * @return true, if successful
         * @throws TwilioRestException the twilio rest exception
         */
         public Boolean deleteMedia()
         {
             TwilioRestResponse response = this.getClient().safeRequest(this.getResourceLocation(),'DELETE',null);
             return !response.isError();
         }
}