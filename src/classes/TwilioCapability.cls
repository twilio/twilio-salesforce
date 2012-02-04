global class TwilioCapability {

	public class DomainException extends Exception {}
	public class IllegalStateException extends Exception {}


	private String accountSid;
	private String authToken;
	private List<String> scopes;

	// Default Data
	// private String defaultClientName = null;

	// Incoming Parameter holding until generate token time
	private boolean buildIncomingScope = false;
	private String incomingClientName = null;

	// Outgoing Paramater holding until generate token time
	private boolean buildOutgoingScope = false;
	private String appSid = null;
	private String outgoingClientName = null;
	private Map<String, String> outgoingParams = null;

	/**
	 * Create a new TwilioCapability with zero permissions. Next steps are to
	 * grant access to resources by configuring this token through the functions
	 * allowXXXX.
	 * 
	 * @param accountSid
	 *            the account sid to which this token is granted access
	 * @param authToken
	 *            the secret key used to sign the token. Note, this auth token
	 *            is not visible to the user of the token.
	 */
	public TwilioCapability(String accountSid, String authToken) {
		this.accountSid = accountSid;
		this.authToken = authToken;
		this.scopes = new List<String>();

	}

	private String buildScopeString(String service, String privilege,
			Map<String, String> params) {

		String scope = 'scope:';
		scope += service;
		scope += ':';
		scope += privilege;

		if (params != null && params.size() > 0) {
			String paramsJoined = generateParamString(params);

			scope += '?';
			scope += paramsJoined;
		}

		return scope;
	}

	/**
	 * Allow the user of this token to make outgoing connections.
	 * 
	 * @param applicationSid
	 *            the application to which this token grants access
	 */
	public void allowClientOutgoing(String appSid) {
		allowClientOutgoing(appSid, null);
	}

	/**
	 * Allow the user of this token to make outgoing connections.
	 * 
	 * @param applicationSid
	 *            the application to which this token grants access
	 * @param params
	 *            signed parameters that the user of this token cannot
	 *            overwrite.
	 */
	public void allowClientOutgoing(String appSid, Map<String, String> params) {
		this.buildOutgoingScope = true;
		this.outgoingParams = params;
		this.appSid = appSid;
	}

	//
	// /**
	// * Allow the user of this token to make outgoing connections.
	// *
	// * @param applicationSid
	// * the application to which this token grants access
	// * @param clientName
	// * the name for this client
	// * @param params
	// * signed parameters that the user of this token cannot
	// * overwrite.
	// */
	// public void allowClientOutgoing(String appSid, String clientName,
	// Map<String, String> params) {
	//
	// Map<String, String> values = new Map<String, String>();
	//
	// this.outgoingClientName = clientName;
	// this.buildOutgoingScope = true;
	// this.outgoingParams = params;
	// this.appSid = appSid;
	//
	// }

	private String generateParamString(Map<String, String> params) {
		//List<String> keyValues = new List<String>();
		//for (String key : params.keySet()) {
		//	String value = params.get(key);
		//
		//	key = EncodingUtil.urlEncode(key, 'UTF-8');
		//	value = EncodingUtil.urlEncode(value, 'UTF-8');
		//	
		//
		//	keyValues.add(key + '=' + value);
		//}
		//String paramsJoined = StringUtils.join(keyValues, '&');
		//return paramsJoined;
		
		String queryString = '';
        
        Set<String> keySet = params.keySet();
        for (String key : keySet) {
            if (queryString.length() > 0) {
                queryString += '&';
            }
            queryString += EncodingUtil.urlEncode(key, 'UTF-8');
            queryString += '=';
            queryString += EncodingUtil.urlEncode(params.get(key), 'UTF-8');
        }
        return queryString;
	}

	/**
	 * If the user of this token should be allowed to accept incoming
	 * connections then configure the TwilioCapability through this method and
	 * specify the client name.
	 * 
	 * @param clientName
	 */
	public void allowClientIncoming(String clientName) {
		// Save the default client name
		this.incomingClientName = clientName;
		this.buildIncomingScope = true;
	}

	/**
	 * Allow the user of this token to access their event stream.
	 * 
	 * @param filters
	 *            key/value filters to apply to the event stream
	 */
	public void allowEventStream(Map<String, String> filters) {
		Map<String, String> value = new Map<String, String>();
		value.put('path', '/2010-04-01/Events');
		if (filters != null) {
			String filterString = '';
			String paramsJoined = generateParamString(filters);

			filterString = (EncodingUtil.urlEncode(paramsJoined, 'UTF-8'));
			value.put('params', filterString);
		}

		this.scopes.add(this.buildScopeString('stream', 'subscribe', value));
	}

	/**
	 * Generates a new token based on the credentials and permissions that
	 * previously has been granted to this token.
	 * 
	 * @return the newly generated token that is valid for 3600 seconds
	 * @throws DomainException
	 */
	public String generateToken() {
		return generateToken(System.currentTimeMillis() + 3600);
	}

	/**
	 * Generates a new token based on the credentials and permissions that
	 * previously has been granted to this token.
	 * 
	 * @param expiresAt
	 *            the expiration instance of the token.
	 * @return the newly generated token that is valid for ttl seconds
	 * @throws DomainException
	 */
	public String generateToken(long ttl) {

		// Build these scopes lazily when we generate tokens so we know
		// if we have a default or incoming client name to use
		buildIncomingScope();
		buildOutgoingScope();

		try {
			Map<String, Object> payload = new Map<String, Object>();
			payload.put('iss', this.accountSid);
			payload.put('exp', String.valueOf(System.currentTimeMillis() + ttl));
			payload.put('scope', join(this.scopes, ' '));

			return jwtEncode(payload, this.authToken);
		} catch (Exception e) {
			throw new DomainException(e);
		}
	}

	private void buildOutgoingScope() {
		if (this.buildOutgoingScope) {
			Map<String, String> values = new Map<String, String>();

			values.put('appSid', appSid);

			// Outgoing takes precedence over any incoming name which
			// takes precedence over the default client name. however,
			// we do accept a null clientName
			if (this.outgoingClientName != null) {
				values.put('clientName', this.outgoingClientName);
			} else if (this.incomingClientName != null) {
				values.put('clientName', this.incomingClientName);
			}

			// Build outgoing scopes
			if (this.outgoingParams != null) {
				String appParamString = '';
				String paramsJoined = generateParamString(this.outgoingParams);

				appParamString = (EncodingUtil.urlEncode(paramsJoined, 'UTF-8'));
				values.put('appParams', appParamString);
			}

			this.scopes
					.add(this.buildScopeString('client', 'outgoing', values));
		}
	}

	private void buildIncomingScope() {
		if (this.buildIncomingScope) {
			Map<String, String> value = new Map<String, String>();

			// incoming name which takes precedence over the default client
			// name. however, we do NOT accept a null clientName here
			if (this.incomingClientName != null) {
				value.put('clientName', this.incomingClientName);
			} else {
				throw new IllegalStateException('No client name set');
			}

			this.scopes.add(this.buildScopeString('client', 'incoming', value));
		}
	}

	private static String jwtEncode(Map<String, Object> payload, String key)
	{

		Map<String, Object> header = new Map<String, Object>();
		header.put('typ', 'JWT');
		header.put('alg', 'HS256');

		List<String> segments = new List<String>();
		segments.add(encodeBase64(jsonEncode(header)));
		segments.add(encodeBase64(jsonEncode(payload)));

		String signingInput = join(segments, '.');
		String signature = sign(signingInput, key);
		segments.add(signature);

		return join(segments, '.');
	}

	private static String jsonEncode(Object o) {
		String json = toJSONString(o);
        json = json.replace('\\/', '/'); // is this necessary?
        System.debug(json);
        return json;
	}

	private static String encodeBase64(String data) {
        return encodeBase64(Blob.valueOf(data));
    }

	private static String encodeBase64(Blob data) {
        String encodedString = EncodingUtil.base64Encode(data);
        String safeString = encodedString.replace('+','-').replace('/','_').replace('=', '');
        return safeString;
    }

	// see
	// http://discussion.forum.nokia.com/forum/showthread.php?130974-Help-required-How-to-generate-a-MAC-(HMAC-SHA1)-with-Java
	private static String sign(String data, String key)
	{
		Blob mac = Crypto.generateMac('hmacSHA256', Blob.valueOf(data), Blob.valueOf(key));
        String result = encodeBase64(mac);
		return result;
	}
	
	private static String join(List<String> vals, String sep) {
        String sb = '';
        for (Iterator<String> it=vals.iterator(); it.hasNext(); ) {
            String value = it.next();
            if (sb.length() != 0)
                sb += sep;
            sb += value;
        }
        return sb;
    }
    
    /* JSON CONVERSION METHODS */
    // TODO convert to Force.com JSON library
    
    private static String toJSONString(Object value) 
	{
        String json;        
        if (value == null) {
            json = 'null';
        } else if (value instanceof String) {
            json = '"' + escape((String)value) + '"';
        } else if (value instanceof Map<String, Object>) {
            json = toJSONObjectString((Map<String, Object>)value);
        } else if (value instanceof List<String>) {
            json = toJSONArrayString((List<String>)value);
        } else {
            json = String.valueOf(value);
        }
        return json;
    }

	/* If the input format is map then the json parsing is done in this method*/    
    private static String toJSONObjectString(Map<String, Object>value) 
    {
    	if (value==null)
            return 'null';
                
        if (value.isEmpty())
            return '{}';
            
        String json = '{';
        for (String o : value.keySet()) {
            if (json.length() > 1)
                json += ',';
            
            json += toJSONString(o) + ':' + toJSONString(value.get(o));
        }
        json += '}';
        
        System.debug('JSONObject = '+json);
        return json;
    }

	/* If the input format is List then the json parsing is done in this method*/    
    private static String toJSONArrayString(List<String> value) {
    	if (value==null)
            return 'null';
            
        if (value.isEmpty())
            return '[]';
            
        String json = '[';
        for (String o : value) {
            if (json.length() > 1)
                json += ',';
            
            json += toJSONString(o);
        }
        json += ']';
        
        return json;
    }

	/* If the input format is string then the json parsing is done in this method*/    
    public static String escape(String s) {
    	if(s==null)
    		return null;
    	
		String sb = '';
        for (Integer i=0;i<s.length();i++){
            String ch=s.substring(i,i+1);
            if (ch=='"') {
                    sb += '\\"';
            } else if (ch=='\\') {
                    sb += '\\\\';
            } else if (ch=='/') {
                    sb += '\\/';
            } else if (ch=='\b') {
                    sb += '\\b';
            } else if (ch=='\f') {
                    sb += '\\f';
            } else if (ch=='\n') {
                    sb += '\\n';
            } else if (ch=='\r') {
                    sb += '\\r';
            } else if (ch=='\t') {
                    sb += '\\t';
            } else {
                    sb += ch;
            }
        }
        return sb;
    }
    
	public static testmethod void test_jsonEscape() {
		System.assertEquals('\\"', escape('"'));
        System.assertEquals('\\\\', escape('\\'));
        System.assertEquals('\\/', escape('/'));
        System.assertEquals('\\b', escape('\b'));
        System.assertEquals('\\f', escape('\f'));
        System.assertEquals('\\n', escape('\n'));
        System.assertEquals('\\r', escape('\r'));
        System.assertEquals('\\t', escape('\t'));
        System.assertEquals('a', escape('a'));
        System.assertEquals(null, escape(null));
	}
	
    public static testmethod void test_jsonString() {       
        System.assertEquals('""', toJSONString(''));
        System.assertEquals('null', toJSONString(null));
		System.assertEquals('123', toJSONString(123));
        
        System.assertEquals('"Hi \\"\'Th\\fi\\n s \\\\ i\\rs\\t \\b test \\/ encoder"',
        		toJSONString('Hi "\'Th\fi\n s \\ i\rs\t \b test / encoder'));
    }
    
    public static testmethod void test_jsonArray() {
        System.assertEquals('null', toJSONArrayString(null));

    	List<String> ls = new List<String>();
    	System.assertEquals('[]', toJSONArrayString(ls));
    	System.assertEquals('[]', toJSONString(ls));
    	
        ls.add('one');
        System.assertEquals('["one"]', toJSONArrayString(ls));
        System.assertEquals('["one"]', toJSONString(ls));
        
        ls.add('two');
        System.assertEquals('["one","two"]', toJSONArrayString(ls));
        System.assertEquals('["one","two"]', toJSONString(ls));
        		
        ls.add(null);
        System.assertEquals('["one","two",null]', toJSONArrayString(ls));
        System.assertEquals('["one","two",null]', toJSONString(ls));
        
    }
    
	public static testmethod void test_jsonMap() {
		System.assertEquals('null', toJSONObjectString(null));
		
        Map<String, String> xmp = new Map<String, String>();
        System.assertEquals('{}', toJSONObjectString(xmp));
        System.assertEquals('{}', toJSONString(xmp));
        
        xmp.put('test1','value1');
        System.assertEquals('{"test1":"value1"}', toJSONObjectString(xmp));
        System.assertEquals('{"test1":"value1"}', toJSONString(xmp));
        
        xmp.put('test2','value2');
        System.assertEquals('{"test1":"value1","test2":"value2"}', toJSONObjectString(xmp));       
        System.assertEquals('{"test1":"value1","test2":"value2"}', toJSONString(xmp));       
    }
    


}