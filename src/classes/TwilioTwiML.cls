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
/**
 * Generates Twilio Markup XML (TwiML) documents to instruct Twilio how
 * to handle calls and SMS messages in real time.
 *
 * When an SMS or incoming call is received, Twilio looks up the URL of the
 * web application associated with the phone number called and makes a request
 * to that URL. The web service that responds to the request decides how the
 * call should proceed by returning a Twilio Markup XML (TwiML) document telling
 * Twilio to say text to the caller, send an SMS message, play audio files, get
 * input from the keypad, record audio, connect the call to another phone and more.
 * 
 * TwiML is similar to HTML. Just as HTML is rendered in a browser to display a
 * webpage, TwiML is 'rendered' by Twilio to the caller. Only one TwiML document
 * is rendered to the caller at once but many documents can be linked together
 * to build complex interactive voice applications.
 *
 * Outgoing calls are controlled in the same manner as incoming calls using TwiML.
 * The initial URL for the call is provided as a parameter to the Twilio REST API
 * request you make to initiate the call. See the making calls section of the
 * REST documentation for more information on initiating outgoing calls. See the
 * sending SMS messages section of the REST documentation for more information on
 * sending SMS messages.
 *
 * For more information see http://www.twilio.com/docs/api/twiml
 */
global class TwilioTwiML {

	/** The Constant V_SAY. */
    public static final String V_SAY = 'Say';
    
    /** The Constant V_PLAY. */
    public static final String V_PLAY = 'Play';
    
    /** The Constant V_GATHER. */
    public static final String V_GATHER = 'Gather';
    
    /** The Constant V_RECORD. */
    public static final String V_RECORD = 'Record';
    
    /** The Constant V_PAUSE. */
    public static final String V_PAUSE = 'Pause';
    
    /** The Constant V_HANGUP. */
    public static final String V_HANGUP = 'Hangup';
    
    /** The Constant V_DIAL. */
    public static final String V_DIAL = 'Dial';
    
    /** The Constant V_NUMBER. */
    public static final String V_NUMBER = 'Number';
    
    /** The Constant V_REDIRECT. */
    public static final String V_REDIRECT = 'Redirect';
    
    /** The Constant V_REJECT. */
    public static final String V_REJECT = 'Reject';
    
    /** The Constant V_RESPONSE. */
    public static final String V_RESPONSE = 'Response';
    
    /** The Constant V_CONFERENCE. */
    public static final String V_CONFERENCE = 'Conference';
    
    /** The Constant V_CONFERENCE. */
    public static final String V_CLIENT = 'Client';
    
    /** The Constant V_SMS. */
    public static final String V_SMS = 'Sms';

    /** The Constant V_ENQUEUE. */
    public static final String V_ENQUEUE = 'Enqueue';

    /** The Constant V_TASKATTRIBUTES. */
    public static final String V_TASKATTRIBUTES = 'TaskAttributes';

    /** The Constant V_QUEUE. */
    public static final String V_QUEUE = 'Queue';


    public class TwiMLException extends Exception {}


	/**
	 * The class TwiMLResponse.
	 */
	global class Response extends Verb {
	    
	    /**
	     * Instantiates a new twi ml response.
	     */
	    public Response() {
	        super(V_RESPONSE, null);
	        this.allowedVerbs = new Set<String>();
	        this.allowedVerbs.add(V_GATHER);
	        this.allowedVerbs.add(V_RECORD);
	        this.allowedVerbs.add(V_DIAL);
	        this.allowedVerbs.add(V_SAY);
	        this.allowedVerbs.add(V_PLAY);
	        this.allowedVerbs.add(V_REDIRECT);
	        this.allowedVerbs.add(V_HANGUP);
	        this.allowedVerbs.add(V_SMS);
	        this.allowedVerbs.add(V_ENQUEUE);
		    this.allowedVerbs.add(V_QUEUE);        
	    } 
	}
	
	/**
	 * The class Client.
	 */
	public class Client extends Verb {
	    
	    /**
	     * Instantiates a new number.
	     *
	     * @param number the number
	     */
	    public Client(String name) {
	        super(V_CLIENT, name);
	        this.allowedVerbs = null;
	    }
	}

	/**
	 * The class Conference.
	 */
	public class Conference extends Verb {
	    
	    /**
	     * Instantiates a new conference.
	     *
	     * @param name the name
	     */
	    public Conference(String name) {
	        super(V_CONFERENCE , name);
	        this.allowedVerbs = null;
	    }
	        
	    /**
	     * Sets the muted.
	     *
	     * @param bool the new muted
	     */
	    public void setMuted(Boolean bool){
	        this.setAttribute('muted',bool);
	    }
	    
	    /**
	     * Sets the beep.
	     *
	     * @param bool the new beep
	     */
	    public void setBeep(Boolean bool){
	        this.setAttribute('beep',bool);
	    }
	    
	    /**
	     * Sets the start conference on enter.
	     *
	     * @param bool the new start conference on enter
	     */
	    public void setStartConferenceOnEnter(Boolean bool){
	        this.setAttribute('startConferenceOnEnter',bool);
	    }
	    
	    /**
	     * Sets the end conference on exit.
	     *
	     * @param bool the new end conference on exit
	     */
	    public void setEndConferenceOnExit(Boolean bool){
	        this.setAttribute('endConferenceOnExit',bool);
	    }
	        
	    /**
	     * Sets the wait method.
	     *
	     * @param method the new wait method
	     */
	    public void setWaitMethod(String method){
	        this.setAttribute('waitMethod', method);   
	    }
	    
	    /**
	     * Sets the wait url.
	     *
	     * @param url the new wait url
	     */
	    public void setWaitUrl(String url){
	        this.setAttribute('waitUrl',url);
	    }
	
	}
	
	/**
	 * The class Dial.
	 */
	public class Dial extends Verb {
	    
	    /**
	     * Instantiates a new dial.
	     */
	    public Dial() {
	        super(V_DIAL, null);
	        this.allowedVerbs = new Set<String>();
	        this.allowedVerbs.add(V_NUMBER);
	        this.allowedVerbs.add(V_CONFERENCE);
	        this.allowedVerbs.add(V_CLIENT);
	        this.allowedVerbs.add(V_QUEUE);
	    }
	    
	    /**
	     * Instantiates a new dial.
	     *
	     * @param number the number
	     */
	    public Dial(String num) {
	        super(V_DIAL, num);
	        this.allowedVerbs = new Set<String>();
	        this.allowedVerbs.add(V_NUMBER);
	        this.allowedVerbs.add(V_CONFERENCE);
	        this.allowedVerbs.add(V_CLIENT);
	        this.allowedVerbs.add(V_QUEUE);
	    }
	
	    /**
	     * Sets the action.
	     *
	     * @param url the new action
	     */
	    public void setAction(String url){
	       this.setAttribute('action', url);   
	    }
	    
	    /**
	     * Sets the method.
	     *
	     * @param method the new method
	     */
	    public void setMethod(String method){
	       this.setAttribute('method', method);   
	    }
	    
	    /**
	     * Sets the timeout.
	     *
	     * @param i the new timeout
	     */
	    public void setTimeout(Integer i){
	       this.setAttribute('timeout', i);
	    }
	    
	    /**
	     * Sets the hangup on star.
	     *
	     * @param f the new hangup on star
	     */
	    public void setHangupOnStar(boolean f){
	        this.setAttribute('hangupOnStar', f);            
	    }
	    
	    /**
	     * Sets the time limit.
	     *
	     * @param i the new time limit
	     */
	    public void setTimeLimit(Integer i){
	        this.setAttribute('timeLimit', i);   
	    }
	    
	    /**
	     * Sets the caller id.
	     *
	     * @param callerId the new caller id
	     */
	    public void setCallerId(String callerId){
	       this.setAttribute('callerId', callerId);   
	    }
	
	}
	
	/**
	 * The class Gather.
	 */
	public class Gather extends Verb {
	    
	    /**
	     * Instantiates a new gather.
	     */
	    public Gather() {
	        super(V_GATHER, null);
	        this.allowedVerbs = new Set<String>();
	        this.allowedVerbs.add(V_SAY);
	        this.allowedVerbs.add(V_PLAY);
	        this.allowedVerbs.add(V_PAUSE);
	    }
	
	    /**
	     * Sets the action.
	     *
	     * @param url the new action
	     */
	    public void setAction(String url){
	       this.setAttribute('action', url);   
	    }
	    
	    /**
	     * Sets the method.
	     *
	     * @param method the new method
	     */
	    public void setMethod(String method){
	       this.setAttribute('method', method);   
	    }
	    
	    /**
	     * Sets the timeout.
	     *
	     * @param i the new timeout
	     */
	    public void setTimeout(Integer i){
	       this.setAttribute('timeout', i);   
	    }
	    
	    /**
	     * Sets the finish on key.
	     *
	     * @param key the new finish on key
	     */
	    public void setFinishOnKey(String key){
	       this.setAttribute('finishOnKey', key);   
	    }
	    
	    /**
	     * Sets the num digits.
	     *
	     * @param i the new num digits
	     */
	    public void setNumDigits(Integer i){
	       this.setAttribute('numDigits', i);   
	    }
	
	}


	/**
	 * The class Hangup.
	 */
	public class Hangup extends Verb {
	    
	    /**
	     * Instantiates a new hangup.
	     */
	    public Hangup() {
	        super(V_HANGUP, null);
	        this.allowedVerbs = null;
	    }
	
	}
	
	/**
	 * The class PhoneNumber.
	 */
	public class PhoneNumber extends Verb {
	    
	    /**
	     * Instantiates a new number.
	     *
	     * @param number the number
	     */
	    public PhoneNumber(String num) {
	        super(V_NUMBER, num);
	        this.allowedVerbs = null;
	    }
	
	    /**
	     * Sets the send digits.
	     *
	     * @param digits the new send digits
	     */
	    public void setSendDigits(String digits){
	       this.setAttribute('sendDigits', digits);   
	    }
	    
	    /**
	     * Sets the url.
	     *
	     * @param url the new url
	     */
	    public void setUrl(String url){
	       this.setAttribute('url', url);   
	    }
	}
	
	/**
	 * The class Pause.
	 */
	public class Pause extends Verb {
	    
	    /**
	     * Instantiates a new pause.
	     */
	    public Pause() {
	        super(V_PAUSE, null);
	        this.allowedVerbs = null;
	    }
	
	    /**
	     * Sets the length.
	     *
	     * @param i the new length
	     */
	    public void setLength(Integer i){
	        this.setAttribute('length', i);   
	     }
	}
	
	/**
	 * The class Play.
	 */
	public class Play extends Verb {
	    
	    /**
	     * Instantiates a new play.
	     *
	     * @param body the body
	     */
	    public Play(String body) {
	        super('Play', body);
	        this.allowedVerbs = null;
	    }
	
	    /**
	     * Sets the loop.
	     *
	     * @param i the new loop
	     */
	    public void setLoop(Integer i){
	       this.setAttribute('loop', i);   
	    }
	
	}
	
	/**
	 * The class Record.
	 */
	public class Record extends Verb {
	    
	    /**
	     * Instantiates a new record.
	     */
	    public Record() {
	        super(V_RECORD, null);
	        this.allowedVerbs = null;
	    }
	
	    /**
	     * Sets the action.
	     *
	     * @param url the new action
	     */
	    public void setAction(String url){
	       this.setAttribute('action', url);   
	    }
	    
	    /**
	     * Sets the method.
	     *
	     * @param method the new method
	     */
	    public void setMethod(String method){
	       this.setAttribute('method', method);   
	    }
	    
	    /**
	     * Sets the timeout.
	     *
	     * @param i the new timeout
	     */
	    public void setTimeout(Integer i){
	       this.setAttribute('timeout', i);   
	    }
	    
	    /**
	     * Sets the finish on key.
	     *
	     * @param key the new finish on key
	     */
	    public void setFinishOnKey(String key){
	       this.setAttribute('finishOnKey', key);   
	    }
	    
	    /**
	     * Sets the max length.
	     *
	     * @param i the new max length
	     */
	    public void setMaxLength(Integer i){
	       this.setAttribute('maxLength', i);   
	    }
	    
	    /**
	     * Sets the transcribe.
	     *
	     * @param f the new transcribe
	     */
	    public void setTranscribe(boolean f){
	       this.setAttribute('transcribe', f);
	    }
	    
	    /**
	     * Sets the transcribe callback.
	     *
	     * @param url the new transcribe callback
	     */
	    public void setTranscribeCallback(String url){
	       this.setAttribute('transcribeCallback', url);    
	    }    
	}
	
	/**
	 * The class Redirect.
	 */
	public class Redirect extends Verb {
	    
	    /**
	     * Instantiates a new redirect.
	     *
	     * @param url the url
	     */
	    public Redirect(String url) {
	        super(V_REDIRECT, url);
	        this.allowedVerbs = null;
	    }
	    
	    /**
	     * Sets the method.
	     *
	     * @param method the new method
	     */
	    public void setMethod(String method){
	       this.setAttribute('method', method);   
	    }
	}
	
	/**
	 * The class Reject.
	 */
	public class Reject extends Verb {
	    
	    /**
	     * Instantiates a new pause.
	     */
	    public Reject() {
	        super(V_REJECT, null);
	        this.allowedVerbs = null;
	    }
	
	    /**
	     * Sets the reason.
	     *
	     * @param reason the reason
	     */
	    public void setReason(String reason){
	        this.setAttribute('reason', reason);   
	     }
	}
	
	/**
	 * The class Say.
	 */
	public class Say extends Verb {
	    
	    /**
	     * Instantiates a new say.
	     *
	     * @param body the body
	     */
	    public Say(String body) {
	        super(V_SAY, body);
	        this.allowedVerbs = null;
	    }
	
	    /**
	     * Sets the loop.
	     *
	     * @param i the new loop
	     */
	    public void setLoop(Integer i){
	        this.setAttribute('loop', i);   
	    }
	    
	    /**
	     * Sets the language.
	     *
	     * @param str the new language
	     */
	    public void setLanguage(String str){
	        this.setAttribute('language', str);   
	    }
	    
	    /**
	     * Sets the voice.
	     *
	     * @param str the new voice
	     */
	    public void setVoice(String str){
	        this.setAttribute('voice', str);   
	    }
	}

	/**
	 * The class Sms.
	 */
	public class Sms extends Verb {
	    
	    /**
	     * Instantiates a new sms.
	     *
	     * @param message the message
	     */
	    public Sms(String message) {
	        super(V_SMS, message);
	        this.allowedVerbs = null;
	    }
	
	    /**
	     * Sets the to.
	     *
	     * @param str the new to
	     */
	    public void setTo(String str){
	        this.setAttribute('to', str);
	    }
	    
	    /**
	     * Sets the from.
	     *
	     * @param str the new from
	     */
	    public void setFrom(String str){
	        this.setAttribute('from', str);   
	    }
	    
	    /**
	     * Sets the method.
	     *
	     * @param method the new method
	     */
	    public void setMethod(String method){
	       this.setAttribute('method', method);   
	    }
	    
	    /**
	     * Sets the action.
	     *
	     * @param url the new action
	     */
	    public void setAction(String url){
	       this.setAttribute('action', url);
	    }
	    
	    /**
	     * Sets the status callback.
	     *
	     * @param url the new status callback
	     */
	    public void setStatusCallback(String url){
	       this.setAttribute('statusCallback', url);   
	    }
	}
	

	/**
	 * The class Enqueue.
	 */
	public class Enqueue extends Verb {
	    
	    /**
	     * Instantiates a new enqueue.
	     */
	    public Enqueue() {
	        super(V_ENQUEUE, null);
	        this.allowedVerbs = new Set<String>();
	        this.allowedVerbs.add(V_TASKATTRIBUTES);
	    }
	    	
	    /**
	     * Sets the action.
	     *
	     * @param url the new action
	     */
	    public void setAction(String url){
	       this.setAttribute('action', url);   
	    }

	    
	    /**
	     * Sets the method.
	     *
	     * @param method the new method
	     */
	    public void setMethod(String method){
	       this.setAttribute('method', method);   
	    }

	    /**
	     * Sets the wait url.
	     *
	     * @param url the new wait url
	     */
	    public void setWaitUrl(String url){
	        this.setAttribute('waitUrl',url);
	    }

	    /**
	     * Sets the waitUrlMethod.
	     *
	     * @param method the new waitUrlMethod
	     */
	    public void setWaitUrlMethod(String waiturlmethod){
	       this.setAttribute('waitUrlMethod', waiturlmethod);   
	    }


	    /**
	     * Sets the workflowsid url.
	     *
	     * @param workflowsid the workflowsid
	     */
	    public void setWorkflowSid(String workflowsid){
	        this.setAttribute('workflowSid',workflowsid);
	    }

	}

	/**
	 * The class TaskAttributes.
	 */
	public class TaskAttributes extends Verb {
	    
	    /**
	     * Instantiates a new enqueue.
	     */
	    public TaskAttributes(String JSONattrbutes) {
	        super(V_TASKATTRIBUTES, JSONattrbutes);
	        this.allowedVerbs = null;
	    }
	}


	/**
	 * The class Queue.
	 */
	public class Queue extends Verb {
	    
	    /**
	     * Instantiates a new Queue.
	     */
	    public Queue() {
	        super(V_QUEUE, null);
	        this.allowedVerbs = null;
	    }
	    	
	    /**
	     * Sets the action.
	     *
	     * @param url the new action
	     */
	    public void setUrl(String url){
	       this.setAttribute('url', url);   
	    }

	    
	    /**
	     * Sets the method.
	     *
	     * @param method the new method
	     */
	    public void setMethod(String method){
	       this.setAttribute('method', method);   
	    }

	    /**
	     * Sets the wait reservationSid.
	     *
	     * @param url the new reservationSid
	     */
	    public void setReservationSid(String reservationSid){
	        this.setAttribute('reservationSid',reservationSid);
	    }

	    /**
	     * Sets the postWorkActivitySid.
	     *
	     * @param method the new waitUrlMethod
	     */
	    public void setPostWorkActivitySid(String postWorkActivitySid){
	       this.setAttribute('postWorkActivitySid', postWorkActivitySid);   
	    }
	}

	public virtual class Verb {
	    
	    /** The tag. */
	    protected String tag;
	    
	    /** The body. */
	    protected String body;
	    
	    /** The attributes. */
	    protected Map<String, String> attributes;
	    
	    /** The children. */
	    protected List<Verb> children;
	    
	    /** The allowed verbs. */
	    protected Set<String> allowedVerbs;
	    
	    /**
	     * Constructor.
	     *
	     * @param tag the tag
	     * @param body the body
	     */
	    protected Verb(String tag, String body) {
	        this.tag = tag;
	        this.body = body;
	        this.attributes = new Map<String, String>();
	        this.children = new List<Verb>();
	    }
	    
	    /**
	     * Append the verb as a child of this verb.
	     *
	     * @param verb the verb
	     * @return the verb
	     */
	    public Verb append(Verb verb) {
	       if(this.allowedVerbs != null && this.allowedVerbs.contains(verb.getTag())) {
	           this.children.add(verb);
	           return verb;  
	       } else {
	           throw new TwiMLException('This is not a supported verb');    
	       }
	    }
	    
	    /**
	     * To xml.
	     *
	     * @return the string
	     */
	    public String toXML(){
	        String xml = '<' + this.tag;
	        
	        // alpha sort the keys for predictable ordering in unit tests
	        List<String> keys = new List<String>();
	        keys.addAll(attributes.keySet());
	        keys.sort();
	        
	        for (String key : keys) {
	            xml += ' ' + key + '="' + attributes.get(key) + '"';
	        }
	        
	        if (this.body==null && this.children.isEmpty()) {
	        	xml += '/>';
	        } else {
		        xml += '>';
		        if(this.body != null) {
		            xml += this.body;
		        }
		        for (Verb child : children){
		            xml += child.toXML();
		        }
	        	xml += '</' + this.tag + '>';
	        }
	        return xml;
	    }
	    
	    /**
	     * As url.
	     *
	     * @return the string
	     */
	    public String asURL(){
	        return EncodingUtil.urlEncode(this.toXML(), 'UTF-8');
	    }
	    
	    /**
	     * Sets a string attribute.
	     *
	     * @param key the key
	     * @param value the value
	     */
	    protected void setAttribute(String key, String value){
	       attributes.put(key,value);
	    }
	    
	    /**
	     * Sets a boolean attribute.
	     *
	     * @param attr the attr
	     * @param bool the bool
	     */
	    protected void setAttribute(String attr, Boolean bool){
	        if (bool)
	            this.setAttribute(attr,'true');
	        else
	            this.setAttribute(attr,'false');
	    }
	    
	    /**
	     * Sets an integer attribute.
	     *
	     * @param attr the attr
	     * @param bool the bool
	     */
	    protected void setAttribute(String attr, Integer num){
	        this.setAttribute(attr, String.valueOf(num));
	    }
	    
	    /**
	     * Gets the body.
	     *
	     * @return the body
	     */
	    public String getBody() {
	       return this.body;    
	    }
	    
	    /**
	     * Gets the tag.
	     *
	     * @return the tag
	     */
	    public String getTag() {
	       return this.tag;    
	    }
	    
	    /**
	     * Gets the children.
	     *
	     * @return the children
	     */
	    public List<Verb> getChildren() {
	       return this.children;     
	    }
	    
	    /**
	     * Gets the attributes.
	     *
	     * @return the attributes
	     */
	    public Map<String, String> getAttributes() {
	       return this.attributes;     
	    }
	}

}