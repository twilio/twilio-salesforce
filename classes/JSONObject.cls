public class JSONObject {
/*
Copyright (c) 2002 JSON.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

The Software shall be used for Good, not Evil.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

/*
 * A JSONObject is an unordered collection of name/value pairs. Its
 * external form is a string wrapped in curly braces with colons between the
 * names and values, and commas between the values and names. The internal form
 * is an object having <code>get</code> and <code>opt</code> methods for
 * accessing the values by name, and <code>put</code> methods for adding or
 * replacing values by name. The values can be any of these types:
 * <code>Boolean</code>, <code>JSONArray</code>, <code>JSONObject</code>,
 * <code>Number</code>, <code>String</code>, or the <code>JSONObject.NULL</code>
 * object. A JSONObject constructor can be used to convert an external form
 * JSON text into an internal form whose values can be retrieved with the
 * <code>get</code> and <code>opt</code> methods, or to convert values into a
 * JSON text using the <code>put</code> and <code>toString</code> methods.
 * A <code>get</code> method returns a value if one can be found, and throws an
 * exception if one cannot be found. An <code>opt</code> method returns a
 * default value instead of throwing an exception, and so is useful for
 * obtaining optional values.
 * <p>
 * The generic <code>get()</code> and <code>opt()</code> methods return an
 * object, which you can cast or query for type. There are also typed
 * <code>get</code> and <code>opt</code> methods that do type checking and type
 * coersion for you.
 * <p>
 * The <code>put</code> methods adds values to an object. For example, <pre>
 *     myString = new JSONObject().put('JSON', "Hello, World!").toString();</pre>
 * produces the string <code>{"JSON": "Hello, World"}</code>.
 * <p>
 * The texts produced by the <code>toString</code> methods strictly conform to
 * the JSON sysntax rules.
 * The constructors are more forgiving in the texts they will accept:
 * <ul>
 * <li>An extra <code>,</code>&nbsp;<small>(comma)</small> may appear just
 *     before the closing brace.</li>
 * <li>Strings may be quoted with <code>'</code>&nbsp;<small>(single
 *     quote)</small>.</li>
 * <li>Strings do not need to be quoted at all if they do not begin with a quote
 *     or single quote, and if they do not contain leading or trailing spaces,
 *     and if they do not contain any of these characters:
 *     <code>{ } [ ] / \ : , = ; #</code> and if they do not look like numbers
 *     and if they are not the reserved words <code>true</code>,
 *     <code>false</code>, or <code>null</code>.</li>
 * <li>Keys can be followed by <code>=</code> or <code>=></code> as well as
 *     by <code>:</code>.</li>
 * <li>Values can be followed by <code>;</code> <small>(semicolon)</small> as
 *     well as by <code>,</code> <small>(comma)</small>.</li>
 * <li>Numbers may have the <code>0-</code> <small>(octal)</small> or
 *     <code>0x-</code> <small>(hex)</small> prefix.</li>
 * <li>Comments written in the slashshlash, slashstar, and hash conventions
 *     will be ignored.</li>
 * </ul>
 * @author JSON.org
 * @version 3
 */ 
 
    /* 
     * Sept 2008, rhess
     * begin simple port of this code to Force.com Apex Code
     * currently this code is only building Apex objects from JSON, 
     * not outputing JSON from Apex
     * Oct add valueToString     
     */ 
    public class value { 
        /* apex object to store one of several different data types
         * see : http://www.json.org/
         */
        public value() { }
        public value(boolean bb) { bool  = bb;}
        public value(integer ii) {num=ii;} 
        public value(Decimal ii) {dnum= ii;} 
        public value(string st) {str=st;} 
        public value( jsonobject oo) { obj = oo; }
        public value( list<value> vary ) { values = vary; }
        
        public string str {get;set;}  
        public integer num {get;set;} 
        public double dnum {get;set;} 
        public JSONObject obj {get;set;}    
        public list<value> values {get;set;}  // array
        public boolean bool {get;set;}  
        // if all members are null, value == null
        // isNull()
        /* 
         * value to string is used to output JSON for Google Visualization API
         */
        public string valueToString() { 
            if ( this.bool != null ) return (this.bool?'true':'false');
            if ( this.str != null ) return '"'+this.str +'"';
            if ( this.num != null ) return String.valueof(this.num); 
            if ( this.dnum != null ) return String.valueof(this.dnum); 
            if ( this.values != null ) { 
                string ret = '['; 
                for ( value v:this.values) { 
                    //system.debug( v );
                    ret += v.valueToString() + ','; 
                }
                if ( this.values.size() > 0 )   {
                    // remove last comma
                    ret = ret.substring(0,ret.length()-1);
            } 
                return ret + ']'; 
            } 
            if ( this.obj != null ) {
                return this.obj.valueToString();    
            } 
            return 'null';  
        }
        
    } // end of class value
 
    /* **
     * The map where the JSONObject's properties are kept.
     */
    private map<string,value> data = new map<string,value>();
    
    public value getValue(string key) { return data.get(key); }

    /* **
     * Construct an empty JSONObject.
     */
    public JSONObject() {    }

    /*
     * Construct a JSONObject from a JSONTokener.
     * @param x A JSONTokener object containing the source string.
     * @ If there is a syntax error in the source string.
     */
    public JSONObject(JSONTokener x) {
        this();
        string c;
        String key;

        if (x.nextClean() != '{') {
            throw new jsonexception('A JSONObject text must begin with {');
        }
        for (;;) {
            c = x.nextClean();
            if ( c == null)  {
                throw new jsonexception('A JSONObject text must end with }');
            } else if ( c== '}' ) {  
                return;
            } else { 
                x.back();
                
                key = (string)x.nextValue().str; 
               // system.debug( 'key is :'+key); }
            }
    
            /*
             * The key is followed by ':'. We will also tolerate '=' or '=>'.
             */

            c = x.nextClean();
            if (c == '=') {
                if (x.next() != '>') {
                    x.back();
                }
            } else if (c != ':') {
                throw new jsonexception('Expected a : after a key');
            }
            
            putOpt(key, x.nextValue()); // load next value into data map 
            
            /*
             * Pairs are separated by ','. We will also tolerate ';'.
             */

            string nc = x.nextClean();
            if ( nc == ';' || nc ==  ',' ) { 
                if (x.nextClean() == '}') {
                    return;
                }
                x.back();
            } else if ( nc == '}' ) {
                return;
            } else { 
                throw new jsonexception('Expected a , or }');
            }
        }
    }

    
    /* **
     * Construct a JSONObject from a source JSON text string.
     * This is the most commonly used JSONObject constructor.
     * @param source    A string beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     * @exception JSONException If there is a syntax error in the source string.
     */
    public static JSONObject instance(String source) { 
        return new JSONObject( new JSONTokener(source) );    
    }
    public JSONObject (String source) { 
        this( new JSONTokener(source) );    
    }


    /* **
     * Produce a string from a double. The string 'null' will be returned if
     * the number is not finite.
     * @param  d A double.
     * @return A String.
    
     public static  String doubleToString(double d) {
        if (Double.isInfinite(d) || Double.isNaN(d)) {
            return 'null';
        }
        // Shave off trailing zeros and decimal point, if possible.
        String s = Double.toString(d);
        if (s.indexOf('.') > 0 && s.indexOf('e') < 0 && s.indexOf('E') < 0) {
            while (s.endsWith('0')) {
                s = s.substring(0, s.length() - 1);
            }
            if (s.endsWith('.')) {
                s = s.substring(0, s.length() - 1);
            }
        }
        return s;
    }
    */

    /* **
     * Get the value object associated with a key.
     *
     * @param key   A key string.
     * @return      The object associated with the key.
     * @throws   JSONException if the key is not found.
     */
    public object get(string key) { 
        value ret = this.data.get(key);
        if (ret == null) {
            throw new JSONException('JSONObject[' + key + '] not found.');
        }
        if ( ret.str != null ) return ret.str;
        if ( ret.num != null ) return ret.num;
        if ( ret.bool != null ) return ret.bool;
        system.assert( ret.obj == null , 'get cannot return nested json ojects'); 
        // array?
        return null;
    }


    /* **
     * Get the boolean value associated with a key.
     *
     * @param key   A key string.
     * @return      The truth.
     * @throws   JSONException
     *  if the value is not a Boolean or the String 'true' or 'false'.
     */
    public boolean getBoolean(String key)  {
        Object o = this.get(key);
        if ( o!=null) return (boolean) o;
        throw new JSONException('JSONObject[' + key + '] is not a Boolean.');
    }
 

    /* **
     * Get the double value associated with a key.
     * @param key   A key string.
     * @return      The numeric value.
     * @ if the key is not found or
     *  if the value is not a Number object and cannot be converted to a number.
     
    public double getDouble(String key)  {
        Object o = get(key);
        try {
            return o instanceof Number ?
                ((Number)o).doubleValue() :
                Double.valueOf((String)o).doubleValue();
        } catch (Exception e) {
            throw new JSONException('JSONObject[' + quote(key) +
                '] is not a number.');
        }
    }*/


    /* **
     * Get the int value associated with a key. If the number value is too
     * large for an int, it will be clipped.
     *
     * @param key   A key string.
     * @return      The integer value.
     * @throws   JSONException if the key is not found or if the value cannot
     *  be converted to an integer.
   
    public int getInt(String key)  {
        Object o = get(key);
        return o instanceof Number ?
                ((Number)o).intValue() : (int)getDouble(key);
    }  */


    /*
     * Get the JSONArray value associated with a key.
     *
     * @param key   A key string.
     * @return      A JSONArray which is the value.
     * @throws   JSONException if the key is not found or
     *  if the value is not a JSONArray.
     *
    public JSONArray getJSONArray(String key)  {
        Object o = get(key);
        if (o instanceof JSONArray) {
            return (JSONArray)o;
        }
        throw new JSONException('JSONObject[' + quote(key) +
                '] is not a JSONArray.');
    }*/


    /* **
     * Get the JSONObject value associated with a key.
     *
     * @param key   A key string.
     * @return      A JSONObject which is the value.
     * @throws   JSONException if the key is not found or
     *  if the value is not a JSONObject.

    public JSONObject getJSONObject(String key)  {
        Object o = get(key);
        if (o instanceof JSONObject) {
            return (JSONObject)o;
        }
        throw new JSONException('JSONObject[' + quote(key) +
                '] is not a JSONObject.');
    }
     */

    /* **
     * Get the long value associated with a key. If the number value is too
     * long for a long, it will be clipped.
     *
     * @param key   A key string.
     * @return      The long value.
     * @throws   JSONException if the key is not found or if the value cannot
     *  be converted to a long.
   
    public long getLong(String key)  {
        Object o = get(key);
        return o instanceof Number ?
                ((Number)o).longValue() : (long)getDouble(key);
    }
    */

    /* **
     * Get an array of field names from a JSONObject.
     *
     * @return An array of field names, or null if there are no names.
   
    public static String[] getNames(JSONObject jo) {
        int length = jo.length();
        if (length == 0) {
            return null;
        }
        Iterator i = jo.keys();
        String[] names = new String[length];
        int j = 0;
        while (i.hasNext()) {
            names[j] = (String)i.next();
            j += 1;
        }
        return names;
    }
    */

    /* **
     * Get an array of field names from an Object.
     *
     * @return An array of field names, or null if there are no names.
    
    public static String[] getNames(Object object) {
        if (object == null) {
            return null;
        }
        Class klass = object.getClass();
        Field[] fields = klass.getFields();
        int length = fields.length;
        if (length == 0) {
            return null;
        }
        String[] names = new String[length];
        for (int i = 0; i < length; i += 1) {
            names[i] = fields[i].getName();
        }
        return names;
    } */


    /* **
     * Get the string associated with a key.
     *
     * @param key   A key string.
     * @return      A string which is the value.
     * @throws   JSONException if the key is not found.
     */
    public String getString(String key)  {
        return this.data.get(key).str;
    }


    /* **
     * Determine if the JSONObject contains a specific key.
     * @param key   A key string.
     * @return      true if the key exists in the JSONObject.
     */
    public boolean has(String key) {
        return this.data.containsKey(key);
    }


    /* **
     * Determine if the value associated with the key is null or if there is
     *  no value.
     * @param key   A key string.
     * @return      true if there is no value associated with the key or if
     *  the value is the JSONObject.NULL object.
     
    public boolean isNull(String key) {
        return JSONObject.NULL.equals(opt(key));
    }
    */
    
    /* **
     * Get an enumeration of the keys of the JSONObject.
     *
     * @return A set of the keys.
     */
    public set<string> keys() {
        return this.data.keySet();
    }


    /* **
     * Get the number of keys stored in the JSONObject.
     *
     * @return The number of keys in the JSONObject.
     */
    public integer length() {
        return this.data.keySet().size();
    }


    /* **
     * Produce a JSONArray containing the names of the elements of this
     * JSONObject.
     * @return A JSONArray containing the key strings, or null if the JSONObject
     * is empty.
    
    public JSONArray names() {
        JSONArray ja = new JSONArray();
        Iterator  keys = keys();
        while (keys.hasNext()) {
            ja.put(keys.next());
        }
        return ja.length() == 0 ? null : ja;
    }

    /* **
     * Produce a string from a Number.
     * @param  n A Number
     * @return A String.
     * @ If n is a non-finite number.
    
     public static String numberToString(Number n)
             {
        if (n == null) {
            throw new JSONException('Null pointer');
        }
        testValidity(n);

// Shave off trailing zeros and decimal point, if possible.

        String s = n.toString();
        if (s.indexOf('.') > 0 && s.indexOf('e') < 0 && s.indexOf('E') < 0) {
            while (s.endsWith('0')) {
                s = s.substring(0, s.length() - 1);
            }
            if (s.endsWith('.')) {
                s = s.substring(0, s.length() - 1);
            }
        }
        return s;
    } */


    /* **
     * Get an optional value associated with a key.
     * @param key   A key string.
     * @return      An object which is the value, or null if there is no value.
     */
    public Object opt(String key) {
        return key == null ? null : this.get(key);
    }
    

    /* **
     * Get an optional boolean associated with a key.
     * It returns false if there is no such key, or if the value is not
     * true or the String 'true'.
     *
     * @param key   A key string.
     * @return      The truth.
     */
    public boolean optBoolean(String key) {
        return optBoolean(key, false);
    }


    /* **
     * Get an optional boolean associated with a key.
     * It returns the defaultValue if there is no such key, or if it is not
     * a Boolean or the String 'true' or 'false' (case insensitive).
     *
     * @param key              A key string.
     * @param defaultValue     The default.
     * @return      The truth.
     */
    public boolean optBoolean(String key, boolean defaultValue) {
        try {
            return getBoolean(key);
        } catch (Exception e) {
            return defaultValue;
        }
    } 


    /* **
     * Put a key/value pair in the JSONObject, where the value will be a
     * JSONArray which is produced from a Collection.
     * @param key   A key string.
     * @param value A Collection value.
     * @return      this.
     * @
     
    public JSONObject put(String key, Collection value)  {
        put(key, new JSONArray(value));
        return this;
    }*/


    /* **
     * Get an optional double associated with a key,
     * or NaN if there is no such key or if its value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A string which is the key.
     * @return      An object which is the value.
    
    public double optDouble(String key) {
        return optDouble(key, Double.NaN);
    } */


    /* **
     * Get an optional double associated with a key, or the
     * defaultValue if there is no such key or if its value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      An object which is the value.

    public double optDouble(String key, double defaultValue) {
        try {
            Object o = opt(key);
            return o instanceof Number ? ((Number)o).doubleValue() :
                new Double((String)o).doubleValue();
        } catch (Exception e) {
            return defaultValue;
        }
    }     */


    /* **
     * Get an optional int value associated with a key,
     * or zero if there is no such key or if the value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @return      An object which is the value.
    
    public int optInt(String key) {
        return optInt(key, 0);
    } */


    /* **
     * Get an optional int value associated with a key,
     * or the default if there is no such key or if the value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      An object which is the value.
     
    public int optInt(String key, int defaultValue) {
        try {
            return getInt(key);
        } catch (Exception e) {
            return defaultValue;
        }
    }*/


    /* **
     * Get an optional JSONArray associated with a key.
     * It returns null if there is no such key, or if its value is not a
     * JSONArray.
     *
     * @param key   A key string.
     * @return      A JSONArray which is the value.
     
    public JSONArray optJSONArray(String key) {
        Object o = opt(key);
        return o instanceof JSONArray ? (JSONArray)o : null;
    }*/


    /* **
     * Get an optional JSONObject associated with a key.
     * It returns null if there is no such key, or if its value is not a
     * JSONObject.
     *
     * @param key   A key string.
     * @return      A JSONObject which is the value.
  
    public JSONObject optJSONObject(String key) {
        Object o = opt(key);
        return o instanceof JSONObject ? (JSONObject)o : null;
    }
   */

    /* **
     * Get an optional long value associated with a key,
     * or zero if there is no such key or if the value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @return      An object which is the value.
  
    public long optLong(String key) {
        return optLong(key, 0);
    }
   */
   
    /* **
     * Get an optional long value associated with a key,
     * or the default if there is no such key or if the value is not a number.
     * If the value is a string, an attempt will be made to evaluate it as
     * a number.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      An object which is the value.
     
    public long optLong(String key, long defaultValue) {
        try {
            return getLong(key);
        } catch (Exception e) {
            return defaultValue;
        }
    }*/


    /* **
     * Get an optional string associated with a key.
     * It returns an empty string if there is no such key. If the value is not
     * a string and is not null, then it is coverted to a string.
     *
     * @param key   A key string.
     * @return      A string which is the value.
     
    public String optString(String key) {
        return optString(key, '');
    }
    */

    /* **
     * Get an optional string associated with a key.
     * It returns the defaultValue if there is no such key.
     *
     * @param key   A key string.
     * @param defaultValue     The default.
     * @return      A string which is the value.
 
    public String optString(String key, String defaultValue) {
        Object o = opt(key);
        return o != null ? o.toString() : defaultValue;
    }    */


    /* **
     * Put a key/boolean pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value A boolean which is the value.
     * @return this.
     * @ If the key is null.
  
    public JSONObject put(String key, boolean value)  {
        put(key, value ? true : FALSE);
        return this;
    }   */


    /* **
     * Put a key/double pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value A double which is the value.
     * @return this.
     * @ If the key is null or if the number is invalid.
   
    public JSONObject put(String key, double value)  {
        put(key, new Double(value));
        return this;
    }  */


    /* **
     * Put a key/int pair in the JSONObject.
     *
     * @param key   A key string.
     * @param value An int which is the value.
     * @return this.
     * @ If the key is null.
     
    public JSONObject put(String key, int value)  {
        put(key, new Integer(value));
        return this;
    }
   */

    /* **
     * Put a key/value pair in the JSONObject, but only if the
     * key and the value are both non-null.
     * @param key   A key string.
     * @param value An object which is the value. It should be of one of these
     *  types: Boolean, Double, Integer, JSONArray, JSONObject, Long, String,
     *  or the JSONObject.NULL object.
     * @return this.
     * @ If the value is a non-finite number.
     */
    public JSONObject putOpt(String key, value value)  {
        if (key != null && value != null) {
            data.put(key, value);
        }
        return this;
    }


    /*
     * Produce a string in double quotes with backslash sequences in all the
     * right places. A backslash will be inserted within </, allowing JSON
     * text to be delivered in HTML. In JSON text, a string cannot contain a
     * control character or an unescaped quote or backslash.
     * @param string A String
     * @return  A String correctly formatted for insertion in a JSON text.
     
    static   public  String quote(String string) {
        return '';
        
        if (string == null || string.length() == 0) {
            return '\'\'';
        }

        char         b;
        char         c = 0;
        int          i;
        int          len = string.length();
        StringBuffer sb = new StringBuffer(len + 4);
        String       t;

        sb.append('"');
        for (i = 0; i < len; i += 1) {
            b = c;
            c = string.charAt(i);
            switch (c) {
            case '\\':
            case '"':
                sb.append('\\');
                sb.append(c);
                break;
            case '/':
                if (b == '<') {
                    sb.append('\\');
                }
                sb.append(c);
                break;
            case '\b':
                sb.append("\\b");
                break;
            case '\t':
                sb.append("\\t");
                break;
            case '\n':
                sb.append("\\n");
                break;
            case '\f':
                sb.append("\\f");
                break;
            case '\r':
                sb.append("\\r");
                break;
            default:
                if (c < ' ' || (c >= '\u0080' && c < '\u00a0') ||
                               (c >= '\u2000' && c < '\u2100')) {
                    t = "000" + Integer.toHexString(c);
                    sb.append("\\u" + t.substring(t.length() - 4));
                } else {
                    sb.append(c);
                }
            }
        }
        sb.append('"');
        return sb.toString();
    }*/

    
    /* **
     * Make a JSON text of this JSONObject. For compactness, no whitespace
     * is added. If this would not result in a syntactically correct JSON text,
     * then null will be returned instead.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     *
     * @return a printable, displayable, portable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
  
    public String toString() {
        try {
            Iterator     keys = keys();
            StringBuffer sb = new StringBuffer('{');

            while (keys.hasNext()) {
                if (sb.length() > 1) {
                    sb.append(',');
                }
                Object o = keys.next();
                sb.append(quote(o.toString()));
                sb.append(':');
                sb.append(valueToString(this.map.get(o)));
            }
            sb.append('}');
            return sb.toString();
        } catch (Exception e) {
            return null;
        }
    }   */




    /* **
     * Make a prettyprinted JSON text of this JSONObject.
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param indentFactor The number of spaces to add to each level of
     *  indentation.
     * @param indent The indentation of the top level.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     * @ If the object contains an invalid number.
    
    String toString(int indentFactor, int indent)  {
        int j;
        int n = length();
        if (n == 0) {
            return '{}';
        }
        Iterator     keys = sortedKeys();
        StringBuffer sb = new StringBuffer('{');
        int          newindent = indent + indentFactor;
        Object       o;
        if (n == 1) {
            o = keys.next();
            sb.append(quote(o.toString()));
            sb.append(': ');
            sb.append(valueToString(this.map.get(o), indentFactor,
                    indent));
        } else {
            while (keys.hasNext()) {
                o = keys.next();
                if (sb.length() > 1) {
                    sb.append(',\n');
                } else {
                    sb.append('\n');
                }
                for (j = 0; j < newindent; j += 1) {
                    sb.append(' ');
                }
                sb.append(quote(o.toString()));
                sb.append(': ');
                sb.append(valueToString(this.map.get(o), indentFactor,
                        newindent));
            }
            if (sb.length() > 1) {
                sb.append('\n');
                for (j = 0; j < indent; j += 1) {
                    sb.append(' ');
                }
            }
        }
        sb.append('}');
        return sb.toString();
    }
 */
    
    /* **
     * valueToString 
     * Make a JSON text of an Object value. The method is required to produce a strictly
     * conforming text. If the object does not contain a toJSONString
     * method (which is the most common case), then a text will be
     * produced by other means.  the
     * value's toString method will be called, and the result will be quoted.
     *
     * <p>
     * Warning: This method assumes that the data structure is acyclical.
     * @param value The value to be serialized.
     * @return a printable, displayable, transmittable
     *  representation of the object, beginning
     *  with <code>{</code>&nbsp;<small>(left brace)</small> and ending
     *  with <code>}</code>&nbsp;<small>(right brace)</small>.
     * @ If the value is or contains an invalid number.
     */
    public String valueToString() {
        string ret = '{';
        for ( string key: this.keys() ) { 
            ret += '"' + key + '": ' + this.getvalue(key).valueToString() + ',';
        }
        return ret.substring(0,ret.length()-1) + '}';   
    }
   
           
           
public class JSONException extends Exception {}


public class JSONTokener {
    /*
     * A JSONTokener takes a source string and extracts characters and tokens from
     * it. It is used by the JSONObject and JSONArray constructors to parse
     * JSON source strings.
     * @author JSON.org
     * @version 3
     */

    private integer index;
    private string reader;
    private string lastChar;
    private boolean useLastChar;

    /*
     * Construct a JSONTokener from a string.
     *
     * @param s     A source string.
     */
    public JSONTokener(String s) {
        this.useLastChar = false;
        this.index = 0;
        this.reader = s;
    }

    /*
     * Back up one character. This provides a sort of lookahead capability,
     * so that you can test for a digit or letter before attempting to parse
     * the next number or identifier.
     */
    public void back()  {
        if (useLastChar || index <= 0) {
            throw new JSONException('Stepping back two steps is not supported');
        }
        index -= 1;
        useLastChar = true;
    }


    /*
     * Determine if the source string still contains characters that next()
     * can consume.
     * @return true if not yet at the end of the source.
     */
    public boolean more()  {
        String nextChar = next();
        if (nextChar == null) {
            return false;
        } 
        back();
        return true;
    }

    string read( string reader) { 
        if ( index+1 > reader.length() ) return null;
        return reader.substring(index,index+1); 
    }
    
    /*
     * Get the next character in the source string.
     *
     * @return The next character, or 0 if past the end of the source string.
     */
    public String next()  {
        if (this.useLastChar) {
            this.useLastChar = false;
            if (this.lastChar != null) {
                this.index += 1;
            }
            return this.lastChar;
        } 
        string c;
        try {
            c = read(reader);
        } catch (exception exc) {
            throw new JSONException(exc);
        }

        if (c == null) { // End of stream
            this.lastChar = null;
            return null;
        } 
        this.index += 1;
        this.lastChar = (String) c;
        return this.lastChar;
    }


    /*
     * Consume the next character, and check that it matches a specified
     * character.
     * @param c The character to match.
     * @return The character.
     * @throws JSONException if the character does not match.
     */
    public String next(String c)  {
        String n = next();
        if (n != c) {
            throw new JSONException('Expected ' + c + ' and instead saw ' + n );
        }
        return n;
    }


    /*
     * Get the next n characters.
     *
     * @param n     The number of characters to take.
     * @return      A string of n characters.
     * @throws JSONException
     *   Substring bounds error if there are not
     *   n characters remaining in the source string.
     */
     public String next(integer n)  {
         if (n == 0) {
             return '';
         }

         String buffer = '';
         integer pos = 0;

         if (this.useLastChar) {
             this.useLastChar = false;
             buffer = this.lastChar;
             pos = 1;
         }

         try {
             buffer = buffer + reader.substring(index, index+n);
             pos += n;
         } catch (Exception exc) {
             throw new JSONException(exc.getMessage());
         }
         this.index += pos;

         if (pos < n) {
             throw new JSONException('Substring bounds error');
         }

         this.lastChar = buffer.substring( buffer.length()-1 );
         return buffer;
     }


    /*
     * Get the next char in the string, skipping whitespace
     * and comments (slashslash, slashstar, and hash).
     * @throws JSONException
     * @return  A character, or 0 if there are no more characters.
     */
    public string nextClean()  {
        for (;;) {
            string c = next();
            //system.debug( 'next clean '+c);
            
            if (c == '/') {
                string n = next(); 
                //system.debug( 'next clean '+n);
                if ( n == '/' ) {
                    do {
                        c = next();
                    } while (c != '\n' && c != '\r' && c != null);
                    
                } 
                else 
                if (n ==  '*') {
                    for (;;) {
                        c = next();
                        if (c == null) {
                            throw new JSONException('Unclosed comment');
                        }
                        if (c == '*') {
                            if (next() == '/') {
                                break;
                            }
                            back();
                        }
                    }
                } else { 
                    back();
                    return '/';
                }
            } else if (c == '#') {
                do {
                    c = next();
                } while (c != '\n' && c != '\r' && c != null);
            }
            if (c == null || c > ' ') {
                //system.debug( 'nextClean returns :'+c);
                return c;
            }
        }
        return null;
    }

    /*
     * Return the characters up to the next close quote character.
     * Backslash processing is done. The formal JSON format does not
     * allow strings in single quotes, but an implementation is allowed to
     * accept them.
     * @param quote The quoting character, either
     *      <code>"</code>&nbsp;<small>(double quote)</small> or
     *      <code>'</code>&nbsp;<small>(single quote)</small>.
     * @return      A String.
     * @throws JSONException Unterminated string.
     */
    public String nextString(string quote)  {
        //system.debug( 'nextString ' +quote); 
        string c;
        string sb = '';
        for (;;) {
            c = next();  //system.debug(c);
            //switch (c) {
            if ( c == null || c == '\n' ||  c == '\r') { 
                throw new JSONException('Unterminated string');
            }
            /*
            if (  c == '/' ) {  
                c = next();
                if ( c == 'n')  { sb += '\n'; continue; }
            }
 
            if (  c == '/' ) { 
                c = next();
                switch (c) {
                case 'b':
                    sb.append('\b');
                    break;
                case 't':
                    sb.append('\t');
                    break;
                case 'n':
                    sb.append('\n');
                    break;
                case 'f':
                    sb.append('\f');
                    break;
                case 'r':
                    sb.append('\r');
                    break;
                case 'u':
                    sb.append((char)Integer.parseInt(next(4), 16));
                    break;
                case 'x' :
                    sb.append((char) Integer.parseInt(next(2), 16));
                    break;
                default:
                    sb.append(c);
                }
                break;
            */
    
            if (c == quote) {
                 // system.debug( 'nextString returns :'+sb); 
                return sb;
            }
            sb = sb + c;
            
        }
        return '';
    }


    /**
     * Get the text up but not including the specified character or the
     * end of line, whichever comes first.
     * @param  d A delimiter character.
     * @return   A string.
     */
    public String nextTo(string d)  {
        string sb = '';
        for (;;) {
            string c = next();
            if (c == d || c == null || c == '\n' || c == '\r') {
                if (c != null) {
                    back();
                }
                return sb.trim();
            }
            sb = sb + c;
        } 
        return '';
    }


    /**
     * Get the text up but not including one of the specified delimiter
     * characters or the end of line, whichever comes first.
     * @param delimiters A set of delimiter characters.
     * @return A string, trimmed.

    public String nextTod(String delimiters)  {
        string c;
        String sb = '';
        for (;;) {
            c = next();
            if (delimiters.indexOf(c) >= 0 || c == null ||
                    c == '\n' || c == '\r') {
                if (c != null) {
                    back();
                }
                return sb.trim();
            }
            sb = sb + c;
        }
        return '';
    }     */


    /*
     * Get the next value. The value can be a Boolean, Double, Integer,
     * JSONArray, JSONObject, Long, or String, or the JSONObject.NULL object.
     * @throws JSONException If syntax error.
     *
     * @return An object.
     */

   
    public value nextValue()  {
        
        string c = nextClean();
        // system.debug( 'nextValue ' +c);
        String s;

       if ( c ==   '"' || c == '\'' ) {
                return new value( nextString(c) );
       }
       if ( c == '{' )  {  
                back();
                return new value( new JSONObject(this) ); 
       } 
        if ( c == '[' || c ==  '(') {
                back();
                return new value( JSONArray(this) ); 
        }

        /*
         * Handle unquoted text. This could be the values true, false, or
         * null, or it can be a number. An implementation (such as this one)
         * is allowed to also accept non-standard forms.
         *
         * Accumulate characters until we reach the end of the text or a
         * formatting character.
         */

        String sb = '';
        string b = c;
        while (c >= ' ' && '),:]}/\\\"[{;=#'.indexOf(c) < 0) {
            sb = sb + c;
            //system.debug(sb);
            c = next();
            
        }
        back();

        /*
         * If it is true, false, or null, return the proper value.
         */

        s = sb.trim();
        if (s.equals('')) {
            throw new JSONException ('Missing value');
        }
        if (s.equalsIgnoreCase('true')) {
            
            return new value(true);
        }
        if (s.equalsIgnoreCase('false')) {
            return new value( false);
        }
        if (s.equalsIgnoreCase('null')) {
            return new value();
        }

        /*
         * If it might be a number, try converting it. We support the 0- and 0x-
         * conventions. If a number cannot be produced, then the value will just
         * be a string. Note that the 0-, 0x-, plus, and implied string
         * conventions are non-standard. A JSON parser is free to accept
         * non-JSON forms as long as it accepts all correct JSON forms.
         */

        if ((b >= '0' && b <= '9') || b == '.' || b == '-' || b == '+') {
            if (b == '0') {
                if (s.length() > 2 &&
                        (s.substring(1,2) == 'x' || s.substring(1,2) == 'X')) {
                    try {
                        return new value( Integer.valueof(s.substring(2)) );
                    } catch (Exception e) {
                        /* Ignore the error */
                    }
                } else {
                    try {
                        return new value( Integer.valueof(s) );
                    } catch (Exception e) {
                        /* Ignore the error */
                    }
                }
            }
            try {
                Integer si = Integer.valueof(s);
                return  new value( si );
            } catch (System.TypeException e) {
                    try {
                    return new value( Double.valueof(s) );
                }  catch (System.TypeException g) {
                    // fall thru
                }
            }
        }
        return new value( s );
    }


    /**
     * Skip characters until the next character is the requested character.
     * If the requested character is not found, no characters are skipped.
     * @param to A character to skip to.
     * @return The requested character, or zero if the requested character
     * is not found.
     */
    public string skipTo(string to)  {
        string c;
        try {
            integer startIndex = this.index;
            //reader.mark(Integer.MAX_VALUE);
            do {
                c = next();
                if (c == null) {
                   // reader.reset();
                    this.index = startIndex;
                    return c;
                }
            } while (c != to);
        } catch (Exception exc) {
            throw new JSONException(exc);
        }

        back();
        return c;
    }
 
    /*
     * Make a printable string of this JSONTokener.
     *
     * @return ' at character [this.index]'   
    public String toString() {
        return ' at character ' + index;
    }
    */
    
} // end of tokener (sub) class 

   /*
     * Construct a JSONArray from a JSONTokener.
     * @param x A JSONTokener
     * @throws JSONException If there is a syntax error.
     */
    public static list<value> JSONArray(JSONTokener x) {
        //this();
        list<value> myArrayList = new list<value>(); 
        string c = x.nextClean();
        string q;
        if (c == '[') {
            q = ']';
        } else if (c == '(') {
            q = ')';
        } else {
            throw new JSONException('A JSONArray text must start with [');
        }
        if (x.nextClean() == ']') {
            return myArrayList;
        }
        x.back();
        for (;;) {
            if (x.nextClean() == ',') {
                x.back();
                myArrayList.add(null);
            } else {
                x.back();
                myArrayList.add(x.nextValue());
            }
            c = x.nextClean();
            //switch (c) {
            if ( c == ';' || c == ',') {
                if (x.nextClean() == ']') {
                    return myArrayList;
                }
                x.back();
               
            } else if (    c == ']' || c == ')') {
                if (q != c) {
                    throw new JSONException('Expected a >' + q + '<');
                }
                return myArrayList;
            } else { 
                throw new JSONException('Expected a , or ]');
            }
        } 
        return null;// not reached
    }


    /* **************************
     * TEST Methods to achieve required code coverage
     *   many of these could be improved by using assert() instead of debug()
     */
    public static  testmethod void test_tokener_nl() {
        //add a new line by inserting /n 
        JsonObject.JsonTokener tkr = new  JsonTokener(
        'quoted string foo"');
        system.debug( 'next string is >'+tkr.nextString('"') );
    } 
    public static  testmethod void test_tokener() { 
        JsonObject.JsonTokener tkr = new  JsonTokener('//ff \n{}');
        tkr.nextClean();
        tkr = new  JsonTokener('/*fff*/\n{}');
        tkr.nextClean(); 
        tkr = new  JsonTokener('#ff*\n{}');
        tkr.nextClean(); 
        tkr = new  JsonTokener('/**ff \n{}');
        try { tkr.nextClean(); } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'Unclosed comment');
        } 
    }
    public static  testmethod void test_parsing() {     JSONObject jj; JsonObject.JsonTokener tkr;
        string simple = '{"translatedText":  "Ciao mondo"  }';
        string bool_simple = '{"responseBoolean"  :   true }';
        string nsimple = '{"responseData"  :   {"translatedText":  "Ciao mondo"  }, "responseDetails": null, "responseStatus": 200 }';
    
        // three methods of constructing an object
        system.debug( jsonobject.instance( bool_simple   ) );
        system.debug( new jsonobject(   bool_simple ) );    
        system.debug( new JSONObject( new  JsonTokener(simple) ) ); 
        
        tkr = new  JsonTokener(nsimple);
        system.debug( tkr.more() ); 
        system.debug( tkr.next(1) );    
        system.assert( tkr.next(0) == '' ); 
        
        try { tkr.next(10000);  } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'Ending position out of bounds: 10002');
        } 
        
        system.debug( tkr.next('r') );  
        
        try { tkr.next('z'); } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'Expected z and instead saw e');
        } 
            
        system.debug( tkr.nextTo('e') );
        system.debug( tkr.skipTo('p') );
        system.debug( tkr.skipTo('z') );
            
        tkr = new  JsonTokener(nsimple);
        jj = new JSONObject( tkr);
         
        system.debug( jj.data );
        system.debug( jj.data.keySet() );
        
        system.debug( 'response status ' + jj.data.get('responseStatus') );
        system.debug( 'response status ' + jj.get('responseStatus') );
        system.debug( 'response details ' + jj.get('responseDetails') );
        
        system.debug( jj.getString('responseDetails') );
        system.assert( jj.getString('responseDetails') == null ,'expected null ');
        
        system.debug('value '+ jj.getValue('responseData') );
        
        value v = jj.data.get('responseData');
        system.debug( jj.getString('responseDetails') );
        system.debug( 'response data is '+ v.obj);
         
        //system.assert( v.obj.valu != null);
        system.debug( jj.data.keySet() );
         
        
        nsimple = '{"responseString"  :   "foo" }';
        tkr = new  JsonTokener(nsimple);
        jj = new JSONObject( tkr);
        system.debug( jj.get('responseString') );
         
        nsimple = '{"responseBoolean"  :   true }';
        tkr = new  JsonTokener(nsimple);
        jj = new JSONObject( tkr);
        system.debug( jj.getValue('responseBoolean') );
        system.debug( jj.optBoolean('responseBoolean') );
        
        
        try { 
        system.debug ( new JSONObject ( new JSONTokener( 'sdfsdf' ) ) ); 
        } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'A JSONObject text must begin with {');
        } 
        
        try { 
        system.debug ( new JSONObject ( new JSONTokener( '{"sdfsdf": true' ) ) ); 
        } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'Expected a , or }');
        } 
        
        try { 
        system.debug ( new JSONObject ( new JSONTokener( '{"sdfsdf' ) ) ); 
        } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'Unterminated string');
        } 
    
        try { 
        system.debug ( new JSONObject ( new JSONTokener( '{"sdfsdf": 0x009.9 }' ) ) ); 
        } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'Invalid integer: 009.9');
        } 
    
        
        system.assert ( new JSONObject ( new JSONTokener( '{"sdfsdf": 009 }' ) ).getValue('sdfsdf').num == 9 ); 
         
        system.debug ( new JSONObject ( new JSONTokener( '{"foo": 009 }' ) ).get('foo') == 9 ); 
        
        // array testing
        system.debug ( JSONObject.jsonarray ( new JSONTokener( '[1,2,3]' ) )  );
        system.debug ( JSONObject.jsonarray ( new JSONTokener( '[1,2,3,]' ) )  );
        system.debug ( JSONObject.jsonarray ( new JSONTokener( '[]' ) )  );
        system.debug ( JSONObject.jsonarray ( new JSONTokener( '(1,2,3 )' ) )  );
        
        try { 
        system.debug ( JSONObject.jsonarray ( new JSONTokener( '(1,2,3 ]' ) )  );
        } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'Expected a >)<');
        } 
        
        try { 
        system.debug ( JSONObject.jsonarray ( new JSONTokener( '1,2,3 ]' ) )  );
        } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'A JSONArray text must start with [');
        } 
    
        try { 
            system.debug ( jj.get('notfound')  );
        } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'JSONObject[notfound] not found.');
        } 
        
        system.assert( jj.keys() != null );
        system.assert( jj.length() > 0 ); 
        system.assert( jj.opt('responseBoolean') != null );
        system.assert( jj.has( 'responseBoolean') );
        try { 
            system.debug ( jj.getBoolean('notfound')  );
        } catch(exception ex) {
            system.debug( ' expected >'+ex.getMessage() + '<' );
            system.assert( ex.getMessage() == 'JSONObject[notfound] not found.');
        } 
    }
    
    public static  testmethod void test_valueToString() {
        JsonObject json = new JsonObject();
        json.putOpt('foo', new JSONObject.value('bar'));
        /*
        Make sure that the JSON rendered by this class passes validation by parsers
        from http://json.org/json2.js and http://www.jsonlint.com.
        For example:    {foo: "bar"} is invalid
                        {"foo": "bar"} is valid
        */
        system.assertEquals( '{"foo": "bar"}', json.ValuetoString());
    }
    
    // test that we can parse json containing a dobule 
    public static  testmethod void test_geocode() {
        string simple = '{ "Point": { "coordinates": [ -122.0841430, 37.4219720, 0 ] } }';
        JSONObject jj =  new JSONObject( new  JsonTokener(simple) ) ;   
        value p = jj.getValue('Point');
        system.debug (p.obj.data.get('coordinates'));
        value[] vals = p.obj.data.get('coordinates').values;
        system.debug( vals[0].dnum);
        system.assertEquals(3,vals.size());
        system.assertEquals(-122.0841430,   vals[0].dnum);
        system.assertEquals(37.4219720,     vals[1].dnum);
        system.assertEquals('0',            vals[2].valueToString());
    } 
    public static  testmethod void test_g(){
        string googlejson = '{  "name": "1600 Amphitheatre Parkway, Mountain View, CA",  "Status": {    "code": 200,    "request": "geocode"  },  "Placemark": [ {    "id": "p1",    "address": "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",    "AddressDetails": {   "Accuracy" : 8,   "Country" : {      "AdministrativeArea" : {         "AdministrativeAreaName" : "CA",         "SubAdministrativeArea" : {            "Locality" : {               "LocalityName" : "Mountain View",               "PostalCode" : {                  "PostalCodeNumber" : "94043"               },               "Thoroughfare" : {                  "ThoroughfareName" : "1600 Amphitheatre Pkwy"               }            },         '+
        '   "SubAdministrativeAreaName" : "Santa Clara"         }      },      "CountryName" : "USA",      "CountryNameCode" : "US"   }},    "ExtendedData": {      "LatLonBox": {        "north": 37.4251466,        "south": 37.4188514,        "east": -122.0811574,        "west": -122.0874526      }    },    "Point": {      "coordinates": [ -122.0843700, 37.4217590, 0 ]    }  } ]}   ';
        JSONObject jj = new JSONObject( new  JsonTokener(googlejson)  );    
        system.assertNotEquals(null,jj);
    }
}