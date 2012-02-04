/**
 * The class TwilioAvailablePhoneNumberList
 * 
 *  For more information see see http://www.twilio.com/docs/api/rest/available-phone-numbers
 */
global class TwilioAvailablePhoneNumberList extends TwilioResource.ListResource
	implements Iterable<TwilioAvailablePhoneNumber> {

	public static final String TYPE_LOCAL = 'Local';
	public static final String TYPE_TOLLFREE = 'TollFree';
	
	/** The iso country. */
	private String isoCountry = 'US';
	
	/** The type. */
	private String type = TYPE_LOCAL;

	/**
	 * Instantiates a new available phone number list.
	 *
	 * @param client the client
	 */
	public TwilioAvailablePhoneNumberList(TwilioRestClient client) {
		super(client);
	}

	/**
	 * Instantiates a new available phone number list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioAvailablePhoneNumberList(TwilioRestClient client,
			Map<String, String> filters) {
		super(client, filters);
	}

	/**
	 * Instantiates a new available phone number list.
	 *
	 * @param client the client
	 * @param isoCountryCode the iso country code
	 * @param type the type
	 */
	public TwilioAvailablePhoneNumberList(TwilioRestClient client,
			String isoCountryCode, String type) {
		super(client);
		this.isoCountry = isoCountryCode;
		this.type = type;
	}
	
	public TwilioAvailablePhoneNumberList(TwilioRestClient client,
			Map<String, String> filters, String isoCountryCode, String type) {
		super(client, filters);
		this.isoCountry = isoCountryCode;
		this.type = type;
	}
	

	/* (non-Javadoc)
	 * @see com.twilio.sdk.resource.Resource#getResourceLocation()
	 */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts/'
				+ this.getRequestAccountSid() + '/AvailablePhoneNumbers/'
				+ this.isoCountry + '/' + this.type + '.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioAvailablePhoneNumber(client, params);
	}
	
	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'available_phone_numbers';
	}

	/* returns the current response results page */
	public List<TwilioAvailablePhoneNumber> getPageData() {
		List<TwilioAvailablePhoneNumber> returnList = new List<TwilioAvailablePhoneNumber>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioAvailablePhoneNumber) {
				returnList.add((TwilioAvailablePhoneNumber) o);
			}
		}
		return returnList;
	}
	
	/* returns an iterator spanning all response result pages */
	global Iterator<TwilioAvailablePhoneNumber> iterator() {
		return new TwilioIterator.AvailablePhoneNumberIterator(this);
	}

	
}