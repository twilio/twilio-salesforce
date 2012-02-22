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
public class TwilioRestException extends Exception {

	/** The error code. */
	private Integer errorCode;
	
	/** The message. */
	private String message;
	
	/** The more info. */
	private String moreInfo;
	
	private Integer status;

	/**
	 * Instantiates a new twilio rest exception.
	 *
	 * @param message the message
	 * @param errorCode the error code
	 */
	public TwilioRestException(String message, Integer errorCode) {
		this(message, errorCode, null);
	}

	/**
	 * Instantiates a new twilio rest exception.
	 *
	 * param message the message
	 * param errorCode the error code
	 * param moreInfo the more info
	 */
	public TwilioRestException(String message, Integer errorCode, String moreInfo) {
		this.message = message;
		this.errorCode = errorCode;
		this.moreInfo = moreInfo;
	}

	/**
	 * Parses the response.
	 *
	 * @param response the response
	 * @return the twilio rest exception
	 */
	public TwilioRestException(TwilioRestResponse response) {
		Map<String, Object> data = response.toMap();
		String message = '';
		String moreInfo = null;
		Integer errorCode = null;
		if (response.isJson()) {
			message = (String) data.get('message');
			
			if (data.get('code') != null) {
				errorCode = Integer.valueOf(data.get('code'));
			}
			if (data.get('more_info') != null) {
				moreInfo = (String) data.get('more_info');
			}
			if (data.get('status') != null) {
				status = Integer.valueOf(data.get('status'));
			}
		}
		else if (response.isXML()) {
			// TODO add XML support some day
		}
		
		this.message = message;
		this.errorCode = errorCode;
		this.moreInfo = moreInfo;
	}
	
	@isTest
	static void test() {
		TwilioRestException tre1 = new TwilioRestException('message',1);
		System.assertEquals('message', tre1.message);
		System.assertEquals(1, tre1.errorCode);
		System.assertEquals(null, tre1.moreInfo);
		System.assertEquals(null, tre1.status);
		
		TwilioRestException tre2 = new TwilioRestException('message',1,'moreInfo');
		System.assertEquals('message', tre2.message);
		System.assertEquals(1, tre2.errorCode);
		System.assertEquals('moreInfo', tre2.moreInfo);
		System.assertEquals(null, tre2.status);
		
		TwilioRestResponse response = new TwilioRestResponse('{"status": 404, "message": "The requested resource was not found"}',404);
		response.setContentType('application/json');
		TwilioRestException tre3 = new TwilioRestException(response);
		System.assertEquals('The requested resource was not found', tre3.message);
		System.assertEquals(null, tre3.errorCode);
		System.assertEquals(null, tre3.moreInfo);
		System.assertEquals(404, tre3.status);
		
		response = new TwilioRestResponse('{"status": 400, "message": "No to number is specified", "code": 21201, "more_info": "http://www.twilio.com/docs/errors/21201"}',400);
		response.setContentType('application/json');
		TwilioRestException tre4 = new TwilioRestException(response);
		System.assertEquals('No to number is specified', tre4.message);
		System.assertEquals(21201, tre4.errorCode);
		System.assertEquals('http://www.twilio.com/docs/errors/21201', tre4.moreInfo);
		System.assertEquals(400, tre4.status);
	}

}