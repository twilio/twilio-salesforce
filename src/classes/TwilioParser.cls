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
    @TestVisible
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
    
    @TestVisible
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
    
    @TestVisible
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
    
    @TestVisible
    private class TwilioParseException extends Exception {}
    
}