public with sharing class AccountSOAPRegisterController 
{
    public Account act{get;set;}
    public String statusmsg{get;set;}
     public String city{get;set;}
    public AccountSOAPRegisterController()
    {
     act=new Account();
    statusmsg='';
    }
    public pageReference dosave()
    {
    //1.connection create to source system
    partnerSoapSforceCom.Soap conObj=new partnerSoapSforceCom.Soap();
     partnerSoapSforceCom.LoginResult partnerresult = conObj.Login('deepika@cognizant.com','deepa12109JHFgo3ZKocdoq4P3N4L5Pjx');
    system.debug('@@@@partnerResult'+partnerresult );
     system.debug('@@@@SessionId'+partnerresult.sessionId );
     String sessionIdval=partnerresult.sessionId;
    //Pass parameters(name,city, phone)
     soapSforceComSchemasClassAccountsoa.SessionHeader_element sesObj=new soapSforceComSchemasClassAccountsoa.SessionHeader_element();
    sesObj.sessionId=sessionIdval;
    soapSforceComSchemasClassAccountsoa.AccountSOAPService obj=new soapSforceComSchemasClassAccountsoa.AccountSOAPService();
    obj.sessionHeader = sesObj;
    String status=obj.customerRegistration(act.name,act.phone,act.billingcity);
    if(status =='Success')
    {
    insert act;
    
    }
    if(act.Id!=NULL)
    {
    statusmsg='Account created successfully';
    
    }
    return (new pagereference('apex/AccountSOAPRegister/').setRedirect(true));
    
    }
    public void doSearch()
    {
    
      //1.connection create to source system
    partnerSoapSforceCom.Soap conObj=new partnerSoapSforceCom.Soap();
     partnerSoapSforceCom.LoginResult partnerresult = conObj.Login('deepika@cognizant.com','deepa12109JHFgo3ZKocdoq4P3N4L5Pjx');
    system.debug('@@@@partnerResult'+partnerresult );
     system.debug('@@@@SessionId'+partnerresult.sessionId );
     String sessionIdval=partnerresult.sessionId;
    //Pass parameters(name,city, phone)
     soapSforceComSchemasClassSearchacco.SessionHeader_element sesObj=new soapSforceComSchemasClassSearchacco.SessionHeader_element();
    sesObj.sessionId=sessionIdval;
    soapSforceComSchemasClassSearchacco.SearchAccountSOAPService  obj=new soapSforceComSchemasClassSearchacco.SearchAccountSOAPService();
    obj.sessionHeader = sesObj;
    List<soapSforceComSchemasClassSearchacco.AccountWrapper> results=obj.getAccount(city);
    accwraplist = new List<AccountWrapper>();
    for(soapSforceComSchemasClassSearchacco.AccountWrapper ob:results)
    {
    accwrap = new AccountWrapper();
    accwrap.name=ob.name;
    accwrap.phone=ob.phone;
    accwrap.city= ob.city;
    accwraplist .add(accwrap);
    
    
    }
    
    
    
    }
    public List<AccountWrapper> accwraplist{get;set;}
    public AccountWrapper accwrap{get;set;}
    
     public class AccountWrapper
     {
        public String city{get;set;}
        public String name{get;set;}
        public String phone{get;set;}
       }
    
}