trigger AccountDuplicate on Account (before insert,before update) 
{
        /*for(Account a:Trigger.new)
{
List<Account> acc=[Select id,Name,Rating from Account where Name=:a.Name and Rating=:a.Rating];
if(acc.size()>0)
{
a.get(acc[0].Name).addError('You Cannot Create the Duplicate Account');
}
}


}*/
    list<string> accountNames=new list<string>();
        for(Account Var:trigger.new)
        {
            accountNames.add(Var.name);
        }
        
        list<Account> listOfDuplicateAccounts=[select id,name from Account where name in :accountNames];
        for(Account acc:trigger.new)
        {
            if(trigger.isInsert){
            if(listOfDuplicateAccounts.size()!=0)
            {
                acc.addError('You Cannot Create the Duplicate Account with this existing name');
            }
        }
        /*if(trigger.isUpdate)
        {
           for(Account oldaccount :trigger.old)
           {
               if(acc.Name!=oldAccount.Name && listOfDuplicateAccounts.size()!=0)
               {
                   acc.addError('You Cannot Create the Duplicate Account with this existing name');
               }
           }
        }*/
            
            
        }
    }