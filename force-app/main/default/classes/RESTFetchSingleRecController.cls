public with sharing class RESTFetchSingleRecController {
    
    
    public static list<resultWrapper> listWrap{get;set;}
    public RESTFetchSingleRecController()
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
    
    public void getRecord()
    {
        
        list<account> accList1=new list<account>();
        String accToken;
        string responseBody;
        string externalAccId='0017F00001ezJbe'; // Id of account from SYSTEM B
        string endPoint='https://deepikacts-dev-ed.my.salesforce.com/services/apexrest/getMyAccount/' +externalAccId;
        //string endPoint='https://deepikacts-dev-ed.my.salesforce.com/services/apexrest/getMyAccountList';
        RESTFetchSingleRecController obj=new RESTFetchSingleRecController();
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
            //resultWrapper wResp1=(resultWrapper) JSON.deserialize(hresp1.getBody(),resultWrapper.class);
            List<resultWrapper>  wResp1 = (List<resultWrapper>)JSON.deserialize(hresp1.getBody(), List<resultWrapper>.class);

            
            listWrap.addAll(wResp1);
            
        }
        
        
        
    }
    public void createRecord()
    {
        system.debug('inside create list');
        list<account> accList1=new list<account>();
        String accToken;
        string responseBody;
        string endPoint='https://deepikacts-dev-ed.my.salesforce.com/services/apexrest/getMyAccount';
        RESTFetchSingleRecController obj=new RESTFetchSingleRecController();
        accToken=obj.getRequestToken();
        system.debug('access token'+ accToken);
        if(accToken!='')
        {
            string Jsonstring='{"Name":"Testname 1"}';
            Http h1=new Http();
            HttpRequest req1=new HttpRequest();
            req1.setHeader('Authorization','Bearer '+accToken);
            req1.setHeader('Content-Type','application/json');
            //req1.setHeader('accept','application/json');
            req1.setMethod('POST');
            req1.setBody(Jsonstring);
            req1.setEndpoint(endPoint);
            HttpResponse hresp1=h1.send(req1);
            system.debug('hresp1'+ hresp1);
            
            
        }
        
        
    }
    public void updateRecord()
    {
        
        list<account> accList1=new list<account>();
        String accToken;
        string responseBody;
        string Jsonstring='{"Name":"API First Communications","NewAccountNumber":"456","OldAccountNumber":"7789"}';
        string accIdToupdate='0017F00001LSIua';
        string endPoint='https://deepikacts-dev-ed.my.salesforce.com/services/apexrest/updaterecord/';
        RESTFetchSingleRecController obj=new RESTFetchSingleRecController();
        accToken=obj.getRequestToken();
        system.debug('access token'+ accToken);
        if(accToken!='')
        {
            Http h1=new Http();
            HttpRequest req1=new HttpRequest();
            req1.setHeader('Authorization','Bearer '+accToken);
            req1.setHeader('Content-Type','application/json');
            req1.setBody(Jsonstring);
            req1.setMethod('PUT');
            req1.setEndpoint(endPoint);
            HttpResponse hresp1=h1.send(req1);
            
            
        }
        
        
    }
    public void deleteRecord()
    {
        system.debug('inside delete');
        
        list<account> accList1=new list<account>();
        String accToken;
        string responseBody;
        string accIdToDelete='0017F00001SiFXM'; //Account Id from source system.
        string endPoint='https://deepikacts-dev-ed.my.salesforce.com/services/apexrest/deleterecord/'+accIdToDelete;
        RESTFetchSingleRecController obj=new RESTFetchSingleRecController();
        accToken=obj.getRequestToken();
        system.debug('access token'+ accToken);
         system.debug('End point@@@@ '+ endPoint);
        if(accToken!='')
        {
            Http h1=new Http();
            HttpRequest req1=new HttpRequest();
            req1.setHeader('Authorization','Bearer '+accToken);
            req1.setHeader('Content-Type','application/json');
            //req1.setHeader('Accept','application/json');
            req1.setMethod('DELETE');
            req1.setEndpoint(endPoint);
            HttpResponse hresp1=h1.send(req1);
            string strres=hresp1.getBody();
             system.debug('@@@@@req:'+req1);
            system.debug('@@@@@Response:'+ strres);
            
        }
        
        
        
    }
    
    public class resultWrapper{
        
        public string id{get;set;}
        public string name{get;set;}
        
        
    }
    
}