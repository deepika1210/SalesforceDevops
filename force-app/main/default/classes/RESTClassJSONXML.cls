@RestResource(urlMapping='/api/*/createContact')
global with sharing class RESTClassJSONXML 
{
    @HttpPost 
    global static void doPost(ContactDetail  Detail) {
    
        RestResponse standardResp = RestContext.response;
        FormatRESTResponse.ResponseBase  CustomeResponse = new FormatRESTResponse.ResponseBase(); 
        ContactDetail reqBodyObj = Detail; 

        RestRequest req = RestContext.request;       
        String ContentType = RestContext.request.headers.get('Content-Type') ;
        
        Contact cont = new Contact();
        cont.FirstName = reqBodyObj.FirstName.trim();   
        cont.LastName  = reqBodyObj.LastName.trim();
        insert cont;
        
        CustomeResponse.Success = true;
        CustomeResponse.Message = 'Contact Created id ='+cont.id;
        standardResp.statusCode = 200;
        standardResp.responseBody = FormatRESTResponse.formatResponse(CustomeResponse,ContentType); 
            
    }

    global class ContactDetail{
       global string FirstName {get;set;}
       global string LastName  {get;set;}
       public ContactDetail()  {}
    }
}