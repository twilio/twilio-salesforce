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
public class TwilioParser {

	/**
	 * Helper method to convert JSON to a canonical object map.
	 * 
	 * @return a normalized Map of objects. Repeated elements are List values,
	 *         sub-objects are Map values. All other types are String values.
	 */
	public static Map<String,Object> jsonToMap(String jsonContent) {
		
		return jsonToMap(JSON.createParser(jsonContent));
	}
	
	public static List<Object> jsonToList(String jsonContent) {
		return jsonToList(JSON.createParser(jsonContent));
	}

	/**
	 * Helper method to convert JSON to a canonical object map.
	 * 
	 * @return a normalized Map of objects. Repeated elements are List values,
	 *         sub-objects are Map values. All other types are String values.
	 */
	private static Map<String,Object> jsonToMap(JSONParser parser) {
		Map<String,Object> mapped = new Map<String,Object>();
		
		System.debug('BEGIN jsonToMap(JSONParser) : currentToken='+parser.getCurrentToken()+', currentName='+parser.getCurrentName()+', text='+parser.getText());
		
		if (parser.getCurrentToken()==null) {
			parser.nextToken(); // Advance to the start object marker.
		}
		if (parser.getCurrentToken() != JSONToken.START_OBJECT) {
			throw new TwilioParseException('A JSON Object must start with \'{\'');
		}
		System.debug('PREWHILE jsonToMap(JSONParser) : currentToken='+parser.getCurrentToken()+', currentName='+parser.getCurrentName()+', text='+parser.getText());
		
		while (parser.nextToken() != null) {
			JSONToken curr = parser.getCurrentToken();
			
			System.debug('WHILE jsonToMap(JSONParser) : currentToken='+parser.getCurrentToken()+', currentName='+parser.getCurrentName()+', text='+parser.getText());

			
			if (curr == JSONToken.END_OBJECT) {
				// reached end of object
				break;
			} else if (curr == JSONToken.FIELD_NAME) {
				System.debug('FIELD_NAME jsonToMap(JSONParser) : currentToken='+parser.getCurrentToken()+', currentName='+parser.getCurrentName()+', text='+parser.getText());
					
				String fieldName = parser.getText();
				curr = parser.nextToken();
				
				if (curr == JSONToken.START_OBJECT) {
					// value is a JSON object
					System.debug('START_OBJECT jsonToMap(JSONParser) : currentToken='+parser.getCurrentToken()+', currentName='+parser.getCurrentName()+', text='+parser.getText());
					mapped.put(fieldName, jsonToMap(parser));
				} else if (curr == JSONToken.START_ARRAY) {
					// value is a JSON array
					mapped.put(fieldName, jsonToList(parser));
				} else if (curr == JSONToken.VALUE_NULL) {
					mapped.put(fieldName, null);
				} else {
					// value is a JSON primitive
					mapped.put(fieldName, parser.getText());
				}
			} else {
				throw new TwilioParseException('Unexpected JSON value: '+parser.getText());
			}
		}
		System.debug('RETURN: '+mapped);
		return mapped;
	}
	
	private static List<Object> jsonToList(JSONParser parser) {
		List<Object> jsonArray = new List<Object>();
		
		if (parser.getCurrentToken()==null) {
			parser.nextToken(); // Advance to the start object marker.
		}
		if (parser.getCurrentToken() != JSONToken.START_ARRAY) {
			throw new TwilioParseException('A JSON Array must start with \'[\'');
		}
		
		while (parser.nextValue() != null) {
        	JSONToken curr = parser.getCurrentToken();
            if (curr == JSONToken.END_ARRAY) {
            	break;
            } else if (curr == JSONToken.START_ARRAY) {
                jsonArray.add(jsonToList(parser));
            } else if (curr == JSONToken.START_OBJECT){
                jsonArray.add(jsonToMap(parser));
            } else {
            	jsonArray.add(parser.getText());
            }
        }
        return jsonArray;
	}
	
	private static final Map<String,Integer> monthToInteger = 
		new Map<String,Integer> {
			'Jan' =>  1,
			'Feb' =>  2,
			'Mar' =>  3,
			'Apr' =>  4,
			'May' =>  5,
			'Jun' =>  6,
			'Jul' =>  7,
			'Aug' =>  8,
			'Sep' =>  9,
			'Oct' => 10,
			'Nov' => 11,
			'Dec' => 12
		};
	
	
	public static Datetime parseDatetime(String dateStr) {
		if (dateStr==null)
			return null;
    	
    	// split the original string
    	String[] tokens = dateStr.split(' ', 0);
    	//String dayOfWeek = tokens[0];
    	Integer day = Integer.valueOf(tokens[1]);
    	Integer month = monthToInteger.get(tokens[2]);
    	Integer year = Integer.valueOf(tokens[3]);
    	String[] timeOfDay = tokens[4].split(':');
    	String offset = tokens[5];
    	
    	
    	// split the time substring
    	Integer hour = Integer.valueOf( timeOfDay[0] );
    	Integer minute = Integer.valueOf( timeOfDay[1] );
    	Integer second = Integer.valueOf( timeOfDay[2] );
    	
    	Datetime dt = Datetime.newInstanceGmt(
    			year,
    			month,
    			day,
    			hour,
    			minute,
    			second
    			);
    			
    	System.debug('DateString = \"'+dateStr+'\", Datetime = '+dt.formatLong());
    	return dt;
    }
    
    public static String formatDatetime(Datetime dt) {
    	return dt.format('yyyy-dd-MM');
    }
    
    public static String formatFilterDatetime(Integer year, Integer month, Integer dayOfMonth) {
    	return year+'-'+month+'-'+dayOfMonth;
    }
    
    private class TwilioParseException extends Exception {}
	
	@isTest
	static void test_jsonToList() {
		String body = '[ 100, 200, 300, 400 ]';
		List<Object> list1 = jsonToList(body);
		
		System.assertNotEquals(null, list1);
		System.assertEquals(4, list1.size());
		System.assertEquals('100', list1[0]);
		System.assertEquals('200', list1[1]);
		System.assertEquals('300', list1[2]);
		System.assertEquals('400', list1[3]);
		
		TwilioParseException e = null;
		JSONParser p = JSON.createParser('{"foo":"bar"}');
		p.nextToken(); // '{'
		p.nextToken(); // '"foo"'
		try {
			jsonToList(p);
		} catch (TwilioParseException tpe) {
			e = tpe;
		}
		System.assertNotEquals(null,e);
		System.assertEquals('A JSON Array must start with \'[\'', e.getMessage());
	}
	
	@isTest
	static void test_jonToList_NestedList() {
		String body = '[ [ "1.1", "1.2" ], [ "2.1", "2.2", "2.3" ] ]';
		List<Object> result = jsonToList(body);
		
		System.assertNotEquals(null, result);
		System.assertEquals(2, result.size());
		
		System.assert(result[0] instanceof List<Object>);
		List<Object> list1 = (List<Object>)result[0];
		System.assertEquals(2, list1.size());
		System.assertEquals('1.1', list1[0]);
		System.assertEquals('1.2', list1[1]);
		
		System.assert(result[1] instanceof List<Object>);
		List<Object> list2 = (List<Object>)result[1];
		System.assertEquals('2.1', list2[0]);
		System.assertEquals('2.2', list2[1]);
		System.assertEquals('2.3', list2[2]);
	}
	
	@isTest
	static void test_jsonToMap_Simple() {
		String body = '{ "one":100, "two":"200", "three":300 }';
		Map<String,Object> map1 = jsonToMap(body);
		
		System.assertNotEquals(null, map1);
		System.assertEquals(3, map1.size());
		System.assertEquals(true, map1.containsKey('one'));
		System.assertEquals('100', map1.get('one'));
		System.assertEquals(true, map1.containsKey('two'));
		System.assertEquals('200', map1.get('two'));
		System.assertEquals(true, map1.containsKey('three'));
		System.assertEquals('300', map1.get('three'));
		
		TwilioParseException e = null;
		JSONParser p = JSON.createParser('{"foo":"bar"}');
		p.nextToken(); // '{'
		p.nextToken(); // '"foo"'
		try {
			jsonToMap(p);
		} catch (TwilioParseException tpe) {
			e = tpe;
		}
		System.assertNotEquals(null,e);
		System.assertEquals('A JSON Object must start with \'{\'', e.getMessage());
	}
	
	@isTest
	static void test_jsonToMap_NestedObject() {
		String body = '{ "one":100, "two":"200", "three":{ "a":1, "b":2, "c":3 }, "four":400 }';
		Map<String,Object> map1 = jsonToMap(body);
		
		System.assertNotEquals(null, map1);
		System.assertEquals(4, map1.size());
		System.assertEquals(true, map1.containsKey('one'));
		System.assertEquals(true, map1.containsKey('two'));
		System.assertEquals(true, map1.containsKey('three'));
		System.assertEquals(true, map1.containsKey('four'));
		System.assertEquals('100', map1.get('one'));
		System.assertEquals('200', map1.get('two'));
		System.assert(map1.get('three') instanceof Map<String,Object>);
		
		Map<String,Object> map2 = (Map<String,Object>)map1.get('three');
		System.assertEquals(3, map2.size());
		System.assertEquals(true, map2.containsKey('a'));
		System.assertEquals(true, map2.containsKey('b'));
		System.assertEquals(true, map2.containsKey('c'));
		System.assertEquals('1', map2.get('a'));
		System.assertEquals('2', map2.get('b'));
		System.assertEquals('3', map2.get('c'));
	}
	
	@isTest
	static void test_jsonToMap_NestedArray() {
		String body = '{ "one":{ "a":1, "b":2, "c":3 }, "two":[{"a":1,"b":2}, {"foo":1,"bar":2,"cat":3}]  }';
		
		Map<String,Object> map1 = jsonToMap(body);
		System.assertEquals(2, map1.size());
		System.assertEquals(true, map1.containsKey('one'));
		System.assertEquals(true, map1.containsKey('two'));
		
		Map<String,Object> map2 = (Map<String,Object>)map1.get('one');
		System.assertEquals(3, map2.size());
		System.assertEquals(true, map2.containsKey('a'));
		System.assertEquals(true, map2.containsKey('b'));
		System.assertEquals(true, map2.containsKey('c'));
		System.assertEquals('1', map2.get('a'));
		System.assertEquals('2', map2.get('b'));
		System.assertEquals('3', map2.get('c'));
		
		List<Object> list1 = (List<Object>)map1.get('two');
		System.assertEquals(2, list1.size());
		
		Map<String,Object> list1map1 = (Map<String,Object>)list1[0];
		System.assertEquals(2, list1map1.size());
		System.assertEquals(true, list1map1.containsKey('a'));
		System.assertEquals(true, list1map1.containsKey('b'));
		System.assertEquals('1', list1map1.get('a'));
		System.assertEquals('2', list1map1.get('b'));
		
		Map<String,Object> list1map2 = (Map<String,Object>)list1[1];
		System.assertEquals(3, list1map2.size());
		System.assertEquals(true, list1map2.containsKey('foo'));
		System.assertEquals(true, list1map2.containsKey('bar'));
		System.assertEquals(true, list1map2.containsKey('cat'));
		System.assertEquals('1', list1map2.get('foo'));
		System.assertEquals('2', list1map2.get('bar'));
		System.assertEquals('3', list1map2.get('cat'));
		
	}
	
	@isTest
    static void test_parseDateTime()
    {
    	System.assertEquals(null, parseDateTime(null));
    	System.assertEquals(Datetime.newInstanceGmt(2001, 01, 14, 18, 19, 20),
							parseDatetime('Mon, 14 Jan 2001 18:19:20 +0000'));
		System.assertEquals(Datetime.newInstanceGmt(2005, 8, 1, 3, 45, 53),
							parseDatetime('Tue, 01 Aug 2005 03:45:53 +0000'));
		System.assertEquals(Datetime.newInstanceGmt(2022, 12, 29, 12, 1, 1),
							parseDatetime('Wed, 29 Dec 2022 12:01:01 +0000'));
		
    }
}