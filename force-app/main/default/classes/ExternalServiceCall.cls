public class ExternalServiceCall {
    public PageReference callMethod() {
        String Endpoint = 'https://login.salesforce.com/services/oauth2/authorize?response_type=code&client_id=3MVG9d8..z.hDcPK7.wgxqaoZS3UVQI1NX56Ny1T8UXlB13P04FlQbzT.ikcnTK7ir7o7CKLmNxYcWbBmyhRt&redirect_uri=http://localhost:5000';
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(Endpoint);
        req.setMethod('POST');
        HTTPResponse res = http.send(req);
        System.debug('----------------'+res);
        return null;
    }
}