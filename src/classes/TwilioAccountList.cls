global class TwilioAccountList extends TwilioResource.ListResource
	implements Iterable<TwilioAccount> {  
	
	/**
	 * Instantiates a new account list.
	 *
	 * @param client the client
	 */
	public TwilioAccountList(TwilioRestClient client) {
		super(client);
	}
	
	/**
	 * Instantiates a new call list.
	 *
	 * @param client the client
	 * @param filters the filters
	 */
	public TwilioAccountList(TwilioRestClient client, Map<String, String> filters) {
		super(client, filters);
	}

	/* implements method from TwilioResource */
	public override String getResourceLocation() {
		return '/' + TwilioRestClient.DEFAULT_VERSION + '/Accounts.json';
	}

	/* implements method from TwilioResource.ListResource */
	public override Object makeNew(TwilioRestClient client,
			Map<String, Object> params) {
		return new TwilioAccount(client, params);
	}

	/* implements method from TwilioResource.ListResource */
	public override String getListKey() {
		return 'accounts';
	}
	
	public TwilioAccount createAccount(Map<String, String> params) {
		return (TwilioAccount)this.create(params);
	}
	
	public List<TwilioAccount> getPageData() {
		List<TwilioAccount> returnList = new List<TwilioAccount>();
		
		for (Object o : this.getObjectPageData()) {
			if (o instanceof TwilioAccount) {
				returnList.add((TwilioAccount) o);
			}
		}
		return returnList;
	}
	
	global Iterator<TwilioAccount> iterator() {
		return new TwilioIterator.AccountIterator(this);
	}
}