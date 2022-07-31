public with sharing class showData {
   
  
    public static string cnval{get; set;}
    
    @AuraEnabled
    public static string assignValue(string svr){
        cnval = svr;
          system.debug('aura-->'+cnval);   
          return svr;
       }    
}