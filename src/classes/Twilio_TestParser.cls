@isTest
private class Twilio_TestParser {
    
    @isTest
    static void test_jsonToList() {
        String body = '[ 100, 200, 300, 400 ]';
        List<Object> list1 = TwilioParser.jsonToList(body);
        
        System.assertNotEquals(null, list1);
        System.assertEquals(4, list1.size());
        System.assertEquals('100', list1[0]);
        System.assertEquals('200', list1[1]);
        System.assertEquals('300', list1[2]);
        System.assertEquals('400', list1[3]);
        
        TwilioParser.TwilioParseException e = null;
        JSONParser p = JSON.createParser('{"foo":"bar"}');
        p.nextToken(); // '{'
        p.nextToken(); // '"foo"'
        try {
            TwilioParser.jsonToList(p);
        } catch (TwilioParser.TwilioParseException tpe) {
            e = tpe;
        }
        System.assertNotEquals(null,e);
        System.assertEquals('A JSON Array must start with \'[\'', e.getMessage());
    }
    
    @isTest
    static void test_jonToList_NestedList() {
        String body = '[ [ "1.1", "1.2" ], [ "2.1", "2.2", "2.3" ] ]';
        List<Object> result = TwilioParser.jsonToList(body);
        
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
        Map<String,Object> map1 = TwilioParser.jsonToMap(body);
        
        System.assertNotEquals(null, map1);
        System.assertEquals(3, map1.size());
        System.assertEquals(true, map1.containsKey('one'));
        System.assertEquals('100', map1.get('one'));
        System.assertEquals(true, map1.containsKey('two'));
        System.assertEquals('200', map1.get('two'));
        System.assertEquals(true, map1.containsKey('three'));
        System.assertEquals('300', map1.get('three'));
        
        TwilioParser.TwilioParseException e = null;
        JSONParser p = JSON.createParser('{"foo":"bar"}');
        p.nextToken(); // '{'
        p.nextToken(); // '"foo"'
        try {
            TwilioParser.jsonToMap(p);
        } catch (TwilioParser.TwilioParseException tpe) {
            e = tpe;
        }
        System.assertNotEquals(null,e);
        System.assertEquals('A JSON Object must start with \'{\'', e.getMessage());
    }
    
    @isTest
    static void test_jsonToMap_NestedObject() {
        String body = '{ "one":100, "two":"200", "three":{ "a":1, "b":2, "c":3 }, "four":400 }';
        Map<String,Object> map1 = TwilioParser.jsonToMap(body);
        
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
        
        Map<String,Object> map1 = TwilioParser.jsonToMap(body);
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
        System.assertEquals(null, TwilioParser.parseDateTime(null));
        System.assertEquals(Datetime.newInstanceGmt(2001, 01, 14, 18, 19, 20),
                            TwilioParser.parseDatetime('Mon, 14 Jan 2001 18:19:20 +0000'));
        System.assertEquals(Datetime.newInstanceGmt(2005, 8, 1, 3, 45, 53),
                            TwilioParser.parseDatetime('Tue, 01 Aug 2005 03:45:53 +0000'));
        System.assertEquals(Datetime.newInstanceGmt(2022, 12, 29, 12, 1, 1),
                            TwilioParser.parseDatetime('Wed, 29 Dec 2022 12:01:01 +0000'));
        
    }
    
}