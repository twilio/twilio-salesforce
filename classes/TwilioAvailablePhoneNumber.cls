public class TwilioAvailablePhoneNumber extends TwilioResource {

	public String friendly_name { get; set; }
    public String phone_number { get; set; }
    public String latitude { get; set; }
    public String longitude { get; set; }
    public String region { get; set; }
    public String postal_code { get; set; }
    public String iso_country { get; set; }
    public String lata { get; set; }
    public String rate_center { get; set; }
       
    public TwilioAvailablePhoneNumber(RestClient client) {
    	super(client);
            // do nothing yet
    }
    
    public List<TwilioAvailablePhoneNumber> availablePhoneNumbers { get; set; }
    
    public TwilioAvailablePhoneNumber(RestClient client, String requestAccountSid, Boolean toolFree, String isoCountryCode, Map<String,String> params){
    	super(client);
    	setRequestAccountSid(requestAccountSid);
    	
    	String category = 'Local';
        if (toolFree == true) {
            category = 'TollFree';
        }
        RestResponse response = client.request('/Accounts/' + getRequestAccountSid() + '/AvailablePhoneNumbers/' + isoCountryCode + '/' + category + '.json', 'GET', params);

        if(response != null){
            JSONObject json = new JSONObject(response.responseBody);
            list<JSONObject.value> phoneNumbers = json.getValue('available_phone_numbers').values;
            this.availablePhoneNumbers = new List<TwilioAvailablePhoneNumber>();
            
            for (JSONObject.value v : phoneNumbers) {
                TwilioAvailablePhoneNumber n = new TwilioAvailablePhoneNumber(client);
                n.friendly_name = v.obj.getValue('friendly_name').valueToString();
                n.phone_number = v.obj.getValue('phone_number').valueToString();
                n.latitude = v.obj.getValue('latitude').valueToString();
                n.longitude = v.obj.getValue('longitude').valueToString();
                n.region = v.obj.getValue('region').valueToString();
                n.postal_code = v.obj.getValue('postal_code').valueToString();
                n.iso_country = v.obj.getValue('iso_country').valueToString();
                n.lata = v.obj.getValue('lata').valueToString();
                n.rate_center = v.obj.getValue('rate_center').valueToString();
                this.availablePhoneNumbers.add(n);
                system.debug(logginglevel.WARN, 'Friendly Name' + v.obj.getValue('friendly_name').valueToString());     
            }
        }
    }
    
   

    
}