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
@isTest
private class Twilio_TestAuthAccessToken
{
    final static String accountSid = 'skOPGTJWyBM7Wyrz5tRCbm8zqGGUAvfhePVU';
    final static String apiKeySid = 'VOM7EV29bq8kEfG2jyPA0b0ywD894lxlxZqn';
    final static String apiKeySecret = 'uGhUTeKS3xjkDQJlCq2gH1r9BBEPX5SVQyhf';
    final static String configurationProfileSid = 'DNTBElGC532wArnIBYE2unCDI6yWbstanNzC';

    static testMethod void testGetIdentity()
    {
        TwilioAuthAccessToken accessToken = new TwilioAuthAccessToken(accountSid, apikeySid, apiKeySecret,
                                                                      3600, 'Testing', configurationProfileSid);

        System.assertEquals('Testing', accessToken.getIdentity());
    }

    static testMethod void testEncodeBase64()
    {
        System.assertEquals('', TwilioAuthAccessToken.urlSafeEncodeBase64(''));
        System.assertEquals('QQ', TwilioAuthAccessToken.urlSafeEncodeBase64('A'));
        System.assertEquals('QUI', TwilioAuthAccessToken.urlSafeEncodeBase64('AB'));
        System.assertEquals('QUJDRA', TwilioAuthAccessToken.urlSafeEncodeBase64('ABCD'));
    }

    static testMethod void testJoin()
    {
        System.assertEquals('', TwilioAuthAccessToken.join(new List<String>{''}, '-'));
        System.assertEquals('a-b-c', TwilioAuthAccessToken.join(new List<String>{'a','b','c'}, '-'));
        System.assertEquals('a', TwilioAuthAccessToken.join(new List<String>{'a'}, '-'));
        System.assertEquals('abc', TwilioAuthAccessToken.join(new List<String>{'a','b','c'}, ''));
    }

    static testMethod void testToJWT()
    {
        TwilioAuthAccessToken accessToken = new TwilioAuthAccessToken(accountSid, apiKeySid, apiKeySecret,
                                                                      3600, 'Testing', configurationProfileSid);

        System.assert(accessToken.toJWT() != null);
    }
}
