/**
@author :Deepika Ghose
@CreatedDate: 09/02/2022
@Description:Trigger to count cases on Account
**/ 
public class CaseHandler {
    
    public Static void countCases( Map<Id,Case> newMapCase,Map<Id,Case> oldMapCase){
        Map<Id, Id> accountOwnerIds = new Map<Id, Id>();
        
        List<Case> lstCase = [SELECT id, AccountId 
                              FROM Case 
                              WHERE id in: Trigger.newMap.keyset()];
        List<Case> oldlstCase = [SELECT id, AccountId 
                                 FROM Case 
                                 WHERE id in: Trigger.oldMap.keyset()];
        List<Account> updateAccountList=new List<Account>();
        set<Id> sAccId = new set<Id>();
        for(Case cs: lstCase){
            if(cs.AccountId != null){
                sAccId.add(cs.AccountId);
            }
        }
        for(Case cs: oldlstCase){
            if(cs.AccountId != null){
                sAccId.add(cs.AccountId);
            }
        }
        if(sAccId != null && sAccId.size() > 0){
            List<Account> lstAccount = [SELECT id, Case_Count__c, (select id from Cases) 
                                        FROM Account 
                                        WHERE id in: sAccId];
            if(lstAccount.size() > 0){
                for(Account acc: lstAccount){
                    acc.Case_Count__c = acc.Cases.size();
                }
                
                update lstAccount;
            }
            for(Account acc:lstAccount)
            {
                accountOwnerIds.put(acc.OwnerId,acc.id);
                if(acc.Case_Count__c>5){
                    
                    acc.Account_Status__c='Red';
                    updateAccountList.add(acc);
                    
                }
                else if(acc.Case_Count__c<5){
                    
                    acc.Account_Status__c='Green';
                    updateAccountList.add(acc);
                    
                }
                else if(acc.Case_Count__c>10){
                    
                    
                    scheduledEmail.getownnermap(accountOwnerIds);
                    
                    
                }
            }
            if(updateAccountList.size()>0)
            {
                update updateAccountList;
            }
        }
        
        
    }
   
}