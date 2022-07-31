public class RESTFetchListOfRecordsController 
{
    
    public static list<resultWrapper> listWrap{get;set;}
    
    
    public RESTFetchListOfRecordsController()
    {
        listWrap=new list<resultWrapper>();
        
    }
    
    
    
    public class responseWrapper{
        
        public string id;
        public string access_token;
        public string instance_url;
        
    }
    
    public string getRequestToken()
    {
        string reqBody='grant_type=password&client_id='+label.clientId+'&client_secret='+label.clientSecret+'&username='+label.username+'&password='+label.Password_SecurityToken;                                    
        
        Http h=new Http();
        HttpRequest req=new HttpRequest();
        req.setBody(reqBody);
        req.setMethod('POST');
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        
        HttpResponse hresp=h.send(req);
        responseWrapper wResp=(responseWrapper) JSON.deserialize(hresp.getBody(),responseWrapper.class);
        system.debug('Instance url'+wResp.instance_url);
        system.debug('session id'+wResp.access_token);
        return wResp.access_token;
        
        
    }
    
    public void getConList()
    {
        
        list<account> accList1=new list<account>();
        String accToken;
        string responseBody;
        string endPoint='https://deepikacts-dev-ed.my.salesforce.com/services/apexrest/getMyAccountList/';
        RESTFetchListOfRecordsController obj=new RESTFetchListOfRecordsController();
        accToken=obj.getRequestToken();
        system.debug('access token'+ accToken);
        if(accToken!='')
        {
            Http h1=new Http();
            HttpRequest req1=new HttpRequest();
            req1.setHeader('Authorization','Bearer '+accToken);
            req1.setHeader('Content-Type','application/json');
            //req1.setHeader('Accept','application/json');
            req1.setMethod('GET');
            req1.setEndpoint(endPoint);
            HttpResponse hresp1=h1.send(req1);
            listWrap=(list<resultWrapper>) JSON.deserialize(hresp1.getBody(),list<resultWrapper>.class);
            
        }
        
    }
    
    public class resultWrapper{
        
        public string id{get;set;}
        public string name{get;set;}
        
        
    }
    
}