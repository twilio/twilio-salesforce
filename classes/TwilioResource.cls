public abstract class TwilioResource
{
	/** The client. */
	private RestClient client;

	/** The request account sid. */
	private String requestAccountSid;

	/** The filters. */
	protected Map<String, String> filters;

	/**
	 * Instantiates a new resource.
	 *
	 * @param client the client
	 */
	public TwilioResource(RestClient client) {
		this.client = client;
	}
	
	public TwilioResource() {} // remove this

	/**
	 * Gets the client.
	 *
	 * @return the client
	 */
	protected RestClient getClient() {
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
}