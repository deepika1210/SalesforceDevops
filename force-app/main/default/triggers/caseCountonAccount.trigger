trigger caseCountonAccount on Case (after insert, after update,after delete,after undelete) {
    //List<Case> lstCase = [select id, AccountId from Case where id in: trigger.newmap.keyset()];
    List<Account> updateAccountList=new List<Account>();
    set<Id> sAccId = new set<Id>();
    if(trigger.isInsert || trigger.isUpdate||  trigger.isUndelete) 
       {
    for(Case cs: Trigger.new){
        if(cs.AccountId != null){
            sAccId.add(cs.AccountId);
        }
    }
       }
     if(trigger.isDelete) 
     {
    for(Case cs: Trigger.old){
        if(cs.AccountId != null){
            sAccId.add(cs.AccountId);
        }
    }
     }
    if(sAccId != null && sAccId.size() > 0){
        List<Account> lstAccount = new List<Account>();
                List<Account> updatedlstAccount = new List<Account>();

        lstAccount=[select id, Case_Count__c, (select id from Cases) from Account where id in: sAccId];
        if(lstAccount.size() > 0){
            for(Account acc: lstAccount){
                acc.Case_Count__c = acc.Cases.size();
                //updatedlstAccount.add(acc);
            
               //ystem.debug('***'+lstAccount[0].Case_Count__c);
            }
           /*(updatedlstAccount.size()>0) 
           {
                update updatedlstAccount;
               
           }*/
           
        }
        for(Account acc:lstAccount)
    {
        
        if(acc.Case_Count__c>5){
            
            acc.Account_Status__c='Red';
            updateAccountList.add(acc);
            
        }
        else if(acc.Case_Count__c<5){
            
            acc.Account_Status__c='Green';
            updateAccountList.add(acc);
            
        }
        else if(acc.Case_Count__c>10){
            
            //send mail;
            
        }
    }
    if(updateAccountList.size()>0)
    {
        try
        {
           update updateAccountList;

        }catch(Exception e)
        {
          system.debug('***'+e.getMessage()) ; 
        }
    }
    }
    
}