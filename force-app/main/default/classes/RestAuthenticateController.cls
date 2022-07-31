public with sharing class RestAuthenticateController {

   public String jsonResponse  {Set;get;}
    public string accessToken  {set;get;}
    public void getToken(){
        //Cred__c cr=[select ClientId__c,ClientSecret__c,Username__c,Password__c from Cred__c];
        Http p=new Http();
        HttpRequest request=new HttpRequest();
        request.setEndPoint('https://deepikacts-dev-ed.my.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        string body='grant_type=password&client_id='+label.clientId;
        body=body+'&client_secret='+label.clientSecret;
        body=body+'&username='+label.username;
        body=body+'&password='+label.Password_SecurityToken;
        request.setBody(body);
        //Sending Response to get access token
        HttpResponse response=p.send(request);
        jsonResponse=response.getBody();
        System.JSONParser jp=JSON.createParser(jsonResponse);
        while(jp.nextToken()!=null){
            if(jp.getText()=='access_token'){
                jp.nextToken();
                accesstoken=jp.getText();
                System.debug('+++++++'+accesstoken);
            }
        }
    }
    public void getOpp()
    {

        Http htp= new http();
        HttpRequest req= new HttpRequest();
        //req.setEndpoint('https://interfacebatch1-dev-ed.my.salesforce.com/services/data/v43.0/tabs');
        req.setEndpoint('https://deepikacts-dev-ed.my.salesforce.com/services/apexrest/getOpportunity');
        req.setMethod('GET');
        req.setHeader('Authorization','Bearer '+ accesstoken);
        System.debug('&&&&&&'+req);
        HttpResponse response=htp.send(req);
        System.debug('&&&&&&$$$$'+response);
        jsonResponse=response.getBody();
        
        System.debug('********'+response.getBody());
    }

}