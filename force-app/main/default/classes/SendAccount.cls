public class SendAccount {

   String clientId = label.ClientId;
   String clientsecret = label.Clientsecret;
   String username = label.Username;
   String password = label.Password_SecurityToken;
   String accesstoken_url = 'https://login.salesforce.com/services/oauth2/token';

   String authurl = 'https://login.salesforce.com/services/oauth2/authorize';

   public class deserializeResponse {
        public String access_token;
   }
   public String ReturnAccessToken() {
       String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
       Http h = new Http();
      HttpRequest req = new HttpRequest();
      req.setBody(reqbody);
      req.setMethod('POST');
       req.setHeader('Content-Type', 'application/json');
		req.setHeader('Accept','application/json');
      req.setEndpoint('https://mytrailhead1210-dev-ed--c.visualforce.com/apex/displayAccountCallout');
      HttpResponse res = h.send(req);
     deserializeResponse resp1 = (deserializeResponse)JSON.deserialize(res.getbody(),deserializeResponse.class);
     system.debug('@@@@access_token@@'+resp1 );
       system.debug('@@@@access_token@@'+resp1.access_token);
      return resp1.access_token;
   }

}