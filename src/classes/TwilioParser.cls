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
        
        return (Map<String, Object>) JSON.deserializeUntyped(jsonContent);
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