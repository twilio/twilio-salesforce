public class startHereController {

    public PageReference initPageAction() {
        if (this.theXMlDom == null) {
            PageReference homePage= new PageReference('/home/home.jsp');
            homePage.setRedirect(true);  
            return homePage;
        } else {
            return null;
        }
    }

    // Class variables
    XmlStreamReader reader;
    xmldom theXMLDom;        

    // Constructor
    public startHereController () {
        init(); 
    }
    
    public void init() {
        String lang = UserInfo.getLanguage();
        lang = lang.subString(0, 2);
        
        //Get the XML document from the external server 
        Http http       = new Http(); 
        HttpRequest req = new HttpRequest(); 

        try {        
            req.setEndpoint('http://www.apexdevnet.com/ootbe/starthere/catalog_'+lang+'.xml'); 
            req.setMethod('GET'); 
            
            HttpResponse res = http.send(req); 
            
            if (res.getStatusCode() == 404) {
                // Default to English if language doesn't exist
                req.setEndpoint('http://www.apexdevnet.com/ootbe/starthere/catalog_en.xml'); 
                req.setMethod('GET'); 
            
                res = http.send(req); 
            }
            this.theXMLDom = new xmldom(res.getBody());
        } catch (Exception e) {
            this.theXMLDom = null;
        }
    } 
    
    public String getHTMLHeader() {
        if (this.theXMLDom != null && this.theXMLDom.getElementsByTagName('htmlheader') != null) {
            return this.theXMLDom.getElementsByTagName('htmlheader')[0].nodeValue;
        } else {
            return '';
        }
    }

    public String getBannerURL() {
        if (this.theXMLDom != null && this.theXMLDom.getElementsByTagName('bannerURL') != null) {
            return this.theXMLDom.getElementsByTagName('bannerURL')[0].nodeValue;
        } else {
            return '';
        }
    }

    public String getBannerImageURL() {
        if (this.theXMLDom != null && this.theXMLDom.getElementsByTagName('bannerImageURL') != null) {
            return this.theXMLDom.getElementsByTagName('bannerImageURL')[0].nodeValue;
        } else {
            return '';
        }
    }
    
    public String getMainBody() {
        if (this.theXMLDom != null && this.theXMLDom.getElementsByTagName('main') != null) {
            return this.theXMLDom.getElementsByTagName('main')[0].nodeValue;
        } else {
            return '';
        }
    }
        
    public String getSideBar() {
        if (this.theXMLDom != null && this.theXMLDom.getElementsByTagName('sidebar') != null) {
            return this.theXMLDom.getElementsByTagName('sidebar')[0].nodeValue;
        } else {
            return '';
        }        
    }
    
    public String getFooter() {
        if (this.theXMLDom != null && this.theXMLDom.getElementsByTagName('footer') != null) {
            return this.theXMLDom.getElementsByTagName('footer')[0].nodeValue;
        } else {
            return '';
        }
    }
    
    public String getTracker() {
        if (this.theXMLDom != null && this.theXMLDom.getElementsByTagName('tracker') != null) {
            return this.theXMLDom.getElementsByTagName('tracker')[0].nodeValue;
        } else {
            return '';
        }
    }    
}