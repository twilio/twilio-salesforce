public class TwilioCapabilityPolicy {
    public static final Map<string, boolean> required = new Map<string, boolean>{'required' => true };
    public static final Map<string, boolean> optional = new Map<string, boolean>{'required' => false };

	private String url;
	private String method;
	public Map<String, Map<String, Boolean>> queryFilter {get;set;}
	public Map<String, Map<String, Boolean>> postFilter {get;set;}
	private Boolean allowed;

	public TwilioCapabilityPolicy(String url, String method, Map<String, Map<String, Boolean>> queryFilter, Map<String, Map<String, Boolean>> postFilter, Boolean allowed) {
		this.url = url;
		this.method = method;
		this.queryFilter = queryFilter;
		this.postFilter = postFilter;
		this.allowed = allowed;
	}

	public TwilioCapabilityPolicy(String url, String method) {
		this(url, method, true);
	}

	public TwilioCapabilityPolicy(String url, String method, Boolean allowed) {
      	this(url, method, new Map<String, Map<String, Boolean>>(), new Map<String, Map<String, Boolean>>(), allowed);
	}

    public Map<string, Object> toMap()
    {
        return new Map<String, Object> {
            'url' => this.url,
            'method' => this.method,
            'query_filter' => this.queryFilter,
            'post_filter' => this.postFilter,
            'allow' => this.allowed 
        };
    }
}