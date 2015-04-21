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
    @TestVisible private Integer errorCode;
    
    /** The message. */
    @TestVisible private String message;
    
    /** The more info. */
    @TestVisible private String moreInfo;
    
    @TestVisible private Integer status;

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
}