global class JSONEncoder {
	
	global static String toJSONString(Object value) {
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
	
	private static String toJSONObjectString(Map<String, Object>value) {
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
	
	private static String toJSONArrayString(List<String> value) {
		if (value==null)
            return 'null';
            
        if (value.isEmpty())
            return '{}';
            
        String json = '[';
        for (String o : value) {
            if (json.length() > 1)
                json += ',';
            
            json += toJSONString(o);
        }
        json += ']';
        
        return json;
	}
	
	public static String escape(String s) {
		if(s==null)
            return null;
        
        String sb = '';
        
        for(Integer i=0;i<s.length();i++){
            String ch=s.substring(i,i+1); 
           
            if (ch=='\"') {
                    sb += '\\\"';
            } else if (ch=='\\') {
                    sb += '\\\\';
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
            } else if (ch=='/') {
                    sb += '\\/';
            } else {
                    sb += ch;
            }
        }
        
        return sb;
	}
}