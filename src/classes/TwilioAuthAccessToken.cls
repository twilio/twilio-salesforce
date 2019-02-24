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
public class TwilioAuthAccessToken
{
    private final String accountSid;
    private final String keySid;
    private final String secret;
    private final Integer ttl;

    private final Integer nbf;
    private final String identity;
    private final Set<TwilioAuthGrant> grants;

    public TwilioAuthAccessToken(String accountSid, String keySid, String secret,
                                 Integer ttl, String identity, String configSid)
    {
        this.accountSid = accountSid;
        this.keySid = keySid;
        this.secret = secret;
        this.ttl = ttl;
        this.identity = identity;

        TwilioAuthConversationsGrant configGrant = new TwilioAuthConversationsGrant();
        configGrant.configurationProfileSid = configSid;

        grants = new Set<TwilioAuthGrant>();
        grants.add(configGrant);
    }

    public String getIdentity()
    {
        return this.identity;
    }

    public String toJWT()
    {
        Map<String, String> headers = new Map<String, String>();
        headers.put('cty', 'twilio-fpa;v=1');
        headers.put('alg', 'HS256');
        headers.put('typ', 'JWT');

        Integer timestamp = (Integer)(System.currentTimeMillis() / 1000);
        Map<String, Object> grantPayload = new Map<String, Object>();

        if (this.identity != null)
        {
            grantPayload.put('identity', this.identity);
        }

        for (TwilioAuthGrant grant : this.grants)
        {
            grantPayload.put(grant.getGrantKey(), grant.getPayload());
        }

        Map<String, Object> payload = new Map<String, Object>();
        payload.put('grants', grantPayload);
        payload.put('exp', timestamp + this.ttl);
        payload.put('sub', this.accountSid);
        payload.put('iss', this.keySid);
        payload.put('jti', this.keySid + '-' + String.valueOf(timestamp));

        List<String> segments = new List<String>();
        segments.add(urlSafeEncodeBase64(JSON.serialize(headers)));
        segments.add(urlSafeEncodeBase64(JSON.serialize(payload)));

        String signature = sign(join(segments, '.'), this.secret);
        segments.add(signature);

        return join(segments, '.');
    }

    @TestVisible
    private static String urlSafeEncodeBase64(String data)
    {
        return urlSafeEncodeBase64(Blob.valueOf(data));
    }

    @TestVisible
    private static String urlSafeEncodeBase64(Blob data)
    {
        String encodedString = EncodingUtil.base64Encode(data);
        return encodedString.replace('+', '-').replace('/', '_').replace('=', '');
    }

    @TestVisible
    public static String join(List<String> vals, String sep)
    {
        String sb = '';
        for (Iterator<String> it = vals.iterator(); it.hasNext();)
        {
            String value = it.next();
            if (sb.length() != 0)
            {
                sb += sep;
            }

            sb += value;
        }

        return sb;
    }

    private static String sign(String data, String key)
    {
        Blob mac = Crypto.generateMac('hmacSHA256', Blob.valueOf(data), Blob.valueOf(key));
        String result = urlSafeEncodeBase64(mac);

        return result;
    }
}
