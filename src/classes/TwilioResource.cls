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
public abstract class TwilioResource
{
	
	/** The HTTP client. */
	private TwilioClient client;

	/** The request account sid. */
	private String requestAccountSid;

	/** The filters. */
	protected Map<String, String> filters;

	/**
	 * Instantiates a new resource.
	 *
	 * @param client the client
	 */
	public TwilioResource(TwilioClient client) {
		this.client = client;
	}
	
	/**
	 * Gets the client.
	 *
	 * @return the client
	 */
	protected TwilioClient getClient() {
		return this.client;
	}
	
	/**
	 * Gets the request account sid.
	 *
	 * @return the request account sid
	 */
	protected String getRequestAccountSid() {
		return this.requestAccountSid;
	}

	/**
	 * Sets the request account sid.
	 *
	 * @param sid the new request account sid
	 */
	public void setRequestAccountSid(String sid) {
		this.requestAccountSid = sid;
	}
	
	
	/**
	 * Load.
	 *
	 * @param params the params
	 * @throws TwilioRestException the twilio rest exception
	 */
	protected void load(Map<String, String> params) {
		String path = this.getResourceLocation();
		TwilioRestResponse response = this.getClient().safeRequest(path, 'GET', params);
		this.parseResponse(response);
		this.loaded = true;
	}
	
	// flags whether or not the HTTP request to popluate
	// this data has occured. We can construct resources
	// that are lazily loaded
	/** The loaded. */
	private Boolean loaded = false;

	/**
	 * Checks if is loaded.
	 *
	 * @return true, if is loaded
	 */
	protected boolean isLoaded() {
		return loaded;
	}
	
	/**
	 * Sets the loaded. 
	 *
	 * @param loaded the new loaded
	 */
	protected void setLoaded(boolean loaded) {
		this.loaded = loaded;
	}
	
	/**
	 * Gets the resource location.
	 *
	 * @return the resource location
	 */
	protected abstract String getResourceLocation();
	
	/**
	 * Parses the response.
	 *
	 * @param response the response
	 */
	protected abstract void parseResponse(TwilioRestResponse response);


	/**
	 * The Class InstanceResource.
	 */
	public abstract class InstanceResource extends TwilioResource {
		
		/** The properties. */
		private Map<String, Object> properties;
	
		/** The params. */
		private Map<String, String> params;

		/**
		 * Instantiates a new instance resource.
		 *
		 * @param client the client
		 */
		public InstanceResource(TwilioClient client) {
			super(client);
			this.properties = new Map<String, Object>();
			this.params = new Map<String, String>();
		}
	
		/**
		 * Instantiates a new instance resource.
		 *
		 * @param client the client
		 * @param properties the properties
		 */
		public InstanceResource(TwilioClient client,
				Map<String, Object> properties) {
			super(client);
			this.properties = new Map<String, Object>(properties);
			this.params = new Map<String, String>();
			this.setLoaded(true);
		}

		/**
		 * Instantiates a new instance resource.
		 *
		 * @param client the client
		 * @param params the parameters for the instance resource
		 */
		public InstanceResource(TwilioClient client, Map<String, String> params) {
			super(client);
			this.properties = new Map<String, Object>();
			this.params = new Map<String, String>(params);
		}

		/**
		 * Gets the property.
		 *
		 * @param name the name
		 * @return the property, 
		 * or null if it doesn't exist or is NULL in the response
		 */
		public String getProperty(String name) {
			Object prop = properties.get(name);
	
			if (prop == null && !this.isLoaded()) {
				this.load(params);
			}
	
			prop = properties.get(name);
	
			if (prop == null) {
				return null;
			}
	
			if (prop instanceof String) {
				return (String) prop;
			}
	
			throw new TwilioRestException('Property ' + name
					+ ' is an object.  Use getObject() instead.');
		}
		
		protected Decimal getPropertyDecimal(String name) {
			String prop = getProperty(name);
			if (prop==null) {
				return null;
			}
			return Decimal.valueOf(prop);
		}
		
		protected Integer getPropertyInteger(String name) {
			String prop = getProperty(name);
			if (prop==null) {
				return null;
			}
			return Integer.valueOf(prop);
		}
		
		protected Datetime getPropertyDatetime(String name) {
			string gmtDT = getProperty(name);
			return TwilioParser.parseDatetime(getProperty(name));
		}

		protected Datetime getPropertyISODatetime(String name) {
			DateTime dt = (DateTime) JSON.deserialize('"' + getProperty(name) + '"', DateTime.class);
			return DateTime.newInstance( dt.getTime());
		}

		protected Boolean getPropertyBoolean(String name) {
			String prop = getProperty(name);
			if (prop==null) {
				return null;
			}
			return Boolean.valueOf(prop);
		}
	
		protected Object getObject(String name) {
			Object prop = properties.get(name);
			if (prop == null && !this.isLoaded()) {
				this.load(params);
			}

			prop = properties.get(name);
			
			if (prop == null) {
				throw new TwilioRestException('Property ' + name
						+ ' does not exist');
			}
			return prop;
		}
		
		protected List<String> getStringList(String name) {
			List<String> s = new List<String>();
			for(Object o : (List<Object>)this.getObject(name)) {
				s.add(string.valueof(o));
			} 
			return s;
		}
		
		/**
		 * Sets the property.
		 *
		 * @param name the name
		 * @param value the value
		 */
		protected void setProperty(String name, String value) {
			properties.put(name, value);
		}
		
		protected String uri {
			get {
				return this.getProperty('uri');
			}
		}
		
		/**
		 * Update.
		 *
		 * @param params the params
		 * @throws TwilioRestException the twilio rest exception
		 */
		public void updateResource(Map<String, String> params) {
			this.getClient().safeRequest(this.getResourceLocation(), 'POST', params);
		}
		
        public void updateResource(List<TwilioNameValuePair> params)
        {
        	this.getClient().safeRequestPair(this.getResourceLocation(), 'POST',params);   
        }
		protected override void parseResponse(TwilioRestResponse response) {
			Map<String, Object> properties = response.toMap();
			this.properties = new Map<String, Object>(properties);
		}
	}
	

	public abstract class TwilioListResource extends TwilioResource {
		/** The page data. */
		public List<Object> pageData;

		/**
		 * Instantiates a new list resource.
		 *
		 * @param client the client
		 */
		public TwilioListResource(TwilioClient client) {
			this(client, new Map<String, String>());
		}
	
		/**
		 * Instantiates a new list resource.
		 *
		 * @param client the client
		 * @param filters the filters
		 */
		public TwilioListResource(TwilioClient client, Map<String, String> filters) {
			super(client);
			this.filters = filters;
		}
		

		/**
		 * Gets the page.
		 *
		 * @return the page
		 */
		public abstract Integer getPage();
	
		/**
		 * Checks for next page.
		 *
		 * @return true, if successful
		 */
		public abstract boolean hasNextPage();
	
		/**
		 * Fetch next page.
		 *
		 * @throws TwilioRestException the twilio rest exception
		 */
		public abstract void fetchNextPage();
		
		/**
		 * Checks for prev page.
		 *
		 * @return true, if successful
		 */
		public abstract boolean hasPrevPage();
	
		/**
		 * Fetch prev page.
		 *
		 * @throws TwilioRestException the twilio rest exception
		 */
		public abstract void fetchPrevPage();


		/**
		 * Gets the Integer value.
		 *
		 * @param data the data
		 * @return the Integer value
		 */
		private Integer getIntValue(Object data) {
			if (data instanceof Integer) {
				return (Integer) data;
			}
			if (data instanceof String) {
				return Integer.valueOf((String) data);
			}
	
			return -1;
		}
		
		/**
		 * To list.
		 *
		 * @param response the response
		 * @return the list
		 */
		protected List<Object> toList(TwilioRestResponse response) {
			List<Object> returnList = new List<Object>();
	
			// Right now only json responses are used
			Map<String, Object> m = response.toMap();
	
			if (m.get(this.getListKey()) instanceof List<Object>) {
				List<Object> objs = (List<Object>) m.get(this.getListKey());
	system.debug(m+'----------------------------'+this.getListKey());
				for (Object o : objs) {
					if (o instanceof Map<String,Object>) {
						Object instance = this.makeNew(this.getClient(),
								(Map<String, Object>) o);
						returnList.add(instance);
					}
				}
			}
			return returnList;
		}
		
		/* implements method from TwilioResource.ListResource */
		public Object createInstance(Map<String, String> params) {
			TwilioRestResponse response = this.getClient().safeRequest(
					this.getResourceLocation(), 'POST', params);
			return makeNew(this.getClient(), response.toMap());
		}
		
        /* implements method from TwilioResource.ListResource */
                public Object createInstance(List<TwilioNameValuePair> params) {
                        TwilioRestResponse response = this.getClient().safeRequestPair(
                                        this.getResourceLocation(), 'POST', params);
                        return makeNew(this.getClient(), response.toMap());
                }
		
		/**
		 * Gets the page data.
		 *
		 * @return the page data
		 */
		public List<Object> getObjectPageData() {
			if (!this.isLoaded()) {
				this.load(this.filters);
			}
			
			return this.pageData;
		}
		
		/**
		 * Returns the string key for finding this list of objects in the response.
		 * For example:
		 * 
		 * <TwilioResponse> <Accounts> <Account> </Account> <Account> </Account>
		 * </Accounts> </TwilioResponse>
		 * 
		 * this should return "Accounts"
		 * 
		 * @return the string key for finding this list objects in the response
		 */
		protected abstract String getListKey();
		
		/**
		 * Create a new object of type Object.
		 *
		 * @param client the client
		 * @param params the params
		 * @return a fully constructed object of type Object
		 */
		protected abstract Object makeNew(TwilioClient client,
				Map<String, Object> params);
	}


	public abstract class ListResource extends TwilioListResource {
		private final String PREV_PAGE_URI_KEY_JSON = 'previous_page_uri';		
		private final String NEXT_PAGE_URI_KEY_JSON = 'next_page_uri';
		private final String START_KEY_JSON = 'start';
		private final String END_KEY_JSON = 'end';
		private final String PAGE_KEY_JSON = 'page';
		
		/** The prev uri. */
		private String prevUri = null;

		/** The next uri. */
		private String nextUri = null;
		
		/** The start. */
		private Integer startIx = 0;
		
		/** The end. */
		private Integer endIx = 0;
		
		/** The page. */
		private Integer page = 0;
	
		/** The num pages. */
		private Integer numPages = 0;
		
		/** The total. */
		private Integer total = 0;
		
		/**
		 * Instantiates a new list resource.
		 *
		 * @param client the client
		 */
		public ListResource(TwilioClient client) {
			this(client, new Map<String, String>());
		}
	
		/**
		 * Instantiates a new list resource.
		 *
		 * @param client the client
		 * @param filters the filters
		 */
		public ListResource(TwilioClient client, Map<String, String> filters) {
			super(client);
			this.filters = filters;
		}
		
		/**
		 * Gets the next uri.
		 *
		 * @return the next uri
		 */
		public String getNextUri() {
			return nextUri;
		}
	
		/**
		 * Gets the start.
		 *
		 * @return the start
		 */
		public Integer getStart() {
			return startIx;
		}
	
		/**
		 * Gets the end.
		 *
		 * @return the end
		 */
		public Integer getEnd() {
			return endIx;
		}
		
		/**
		 * Gets the page.
		 *
		 * @return the page
		 */
		public override Integer getPage() {
			return page;
		}
	
		/**
		 * Checks for next page.
		 *
		 * @return true, if successful
		 */
		public override boolean hasNextPage() {
			return nextUri != null && this.nextUri.length() > 0;
		}

		/**
		 * Checks for prev page.
		 *
		 * @return true, if successful
		 */
		public override boolean hasPrevPage() {
			return prevUri != null && this.prevUri.length() > 0;
		}

		/**
		 * Fetch next page.
		 *
		 * @throws TwilioRestException the twilio rest exception
		 */
		public override void fetchNextPage() {
			// Fetch the next page and reset accounts
			TwilioRestResponse response = this.getClient().get(nextUri);
			this.parseResponse(response);
		}

		/**
		 * Fetch prev page.
		 *
		 * @throws TwilioRestException the twilio rest exception
		 */
		public override void fetchPrevPage() {
			// Fetch the next page and reset accounts
			TwilioRestResponse response = this.getClient().get(prevUri);
			this.parseResponse(response);
		}

		protected override void parseResponse(TwilioRestResponse response) {
			this.nextUri = null;
			// Setup paging
			Map<String, Object> data = response.toMap();
			this.nextUri = (String) data.get(NEXT_PAGE_URI_KEY_JSON);
			this.prevUri = (String) data.get(PREV_PAGE_URI_KEY_JSON);		
			this.startIx = this.getIntValue(data.get(START_KEY_JSON));
			this.endIx = this.getIntValue(data.get(END_KEY_JSON));
			this.page = this.getIntValue(data.get(PAGE_KEY_JSON));
	
			// Setup data
			this.pageData = this.toList(response);
		}
	}

	public abstract class NextGenListResource extends TwilioListResource {		
		private final String FIRST_PAGE_URL_JSON = 'first_page_url';
		private final String NEXT_PAGE_URL_JSON = 'next_page_url';
		private final String PREV_PAGE_URL_JSON = 'previous_page_url';
		private final String PAGE_JSON = 'page';
		private final String PAGE_SIZE_JSON = 'page_size';
		private final String URL_JSON = 'url';
		private final String KEY_JSON = 'key';


		/** The first url. */
		private String firstUrl = null;

		/** The next url. */
		private String nextUrl = null;

		/** The prev url. */
		private String prevUrl = null;
		
		/** The page. */
		private Integer page = 0;
		
		/** The page size. */
		private Integer pageSize = 0;
		
		/** The url. */
		private String pageUrl = null;

		/** The key */
		private String key = null;
		
		/**
		 * Instantiates a new list resource.
		 *
		 * @param client the client
		 */
		public NextGenListResource(TwilioClient client) {
			this(client, new Map<String, String>());
		}
	
		/**
		 * Instantiates a new list resource.
		 *
		 * @param client the client
		 * @param filters the filters
		 */
		public NextGenListResource(TwilioClient client, Map<String, String> filters) {
			super(client);
			this.filters = filters;
		}
		
		/**
		 * Gets the next uri.
		 *
		 * @return the next uri
		 */
		public String getNextUrl() {
			return nextUrl;
		}
	
		/**
		 * Gets the page.
		 *
		 * @return the page
		 */
		public override Integer getPage() {
			return page;
		}
	
	

		/**
		 * Checks for next page.
		 *
		 * @return true, if successful
		 */
		public override boolean hasNextPage() {
			return nextUrl != null && this.nextUrl.length() > 0;
		}
	
		/**
		 * Fetch next page.
		 *
		 * @throws TwilioRestException the twilio rest exception
		 */
		public override void fetchNextPage() {
			// Fetch the next page and reset accounts
			TwilioRestResponse response = this.getClient().get(nextUrl);
			this.parseResponse(response);
		}

		/**
		 * Checks for next page.
		 *
		 * @return true, if successful
		 */
		public override boolean hasPrevPage() {
			return prevUrl != null && this.prevUrl.length() > 0;
		}
	
		/**
		 * Fetch next page.
		 *
		 * @throws TwilioRestException the twilio rest exception
		 */
		public override void fetchPrevPage() {
			// Fetch the next page and reset accounts
			TwilioRestResponse response = this.getClient().get(prevUrl);
			this.parseResponse(response);
		}

		protected override void parseResponse(TwilioRestResponse response) {
			this.nextUrl = null;

			// Setup paging
			Map<String, Object> data = response.toMap();
			Map<String, Object>  meta = (Map<String, Object>) data.get('meta');				
			this.firstUrl = (String) meta.get(FIRST_PAGE_URL_JSON);			
			this.nextUrl = (String) meta.get(NEXT_PAGE_URL_JSON);
			this.prevUrl = (String) meta.get(PREV_PAGE_URL_JSON);
			this.page = this.getIntValue(meta.get(PAGE_JSON));
			this.pageSize = this.getIntValue(meta.get(PAGE_SIZE_JSON));
			this.pageUrl = (String) meta.get(URL_JSON);
			this.key = (String) meta.get(KEY_JSON);
			// Setup data
			this.pageData = this.toList(response);
		}
	}
}
