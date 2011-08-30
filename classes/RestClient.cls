/*
Copyright (C) 2012 by Kyle Roche

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/

public class RestClient {
	public static String DEFAULT_ENDPOINT = 'https://api.twilio.com/2010-04-01';
	
	public String endpoint { get; set; }
	public String username { get; set; }
	public String password { get; set; }
	public TwilioAccount account { get; set; }
	
	
	public RestClient() {
		// This would require that all defaults have already been set above.	
	}
	
	public RestClient(String username, String password) {
		this.username = username;
		this.password = password;	
		this.endpoint = DEFAULT_ENDPOINT;
	}
	
	public RestClient(String username, String password, String endpoint) {
		this.username = username;
		this.password = password;
		this.endpoint = endpoint;
	}
	
	public RestResponse request(String path, String method, Map<String, String> params) {
		String encoded = '';
		String url = this.endpoint + path;
		
		// check for params
		if (params != null) {
			for (String key : params.keySet()) {
				try {
					encoded += '&' + key + '=' + EncodingUtil.urlEncode(params.get(key), 'UTF-8');
				} catch (Exception e) {
					system.debug('ERROR: ' + e);
				}
			}
			encoded = encoded.substring(1); // remove extra chars
		}
		
		// add parameter string prefix for certain methods
		if (method.toUpperCase().equals('GET') || method.toUpperCase().equals('DELETE')) {
			url += ((path.indexOf('?') == -1)?'?':'&') + encoded;	
		}
		
		try {
			HttpRequest request = new HttpRequest();
			request.setEndPoint(url);
			
			String authorizationHeader = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(this.username + ':' + this.password));
			request.setHeader('Authorization', authorizationHeader);
			
			if (method.toUpperCase().equals('GET')) {
				request.setMethod('GET');
			}else if(method.toUpperCase().equals('POST')) {
				request.setMethod('POST');
				request.setBody(encoded);
			}
			
			Http http = new Http();
			HttpResponse response;
			
			if (!Test.isRunningTest()) {
				response = http.send(request);
			} else {
				response = new HttpResponse();
			}
			
			String decodedString = response.getBody();
			system.debug(decodedString);
			if (decodedString == null) {
				system.debug('ERROR: Response not available');
				return null;
			}
			integer httpStatus = response.getStatusCode();
			
			return new RestResponse(decodedString, httpStatus);
		} catch (Exception e) {
			system.debug('ERROR: ' + e); 
			return null;	
		}
		
		return null;
	}
}