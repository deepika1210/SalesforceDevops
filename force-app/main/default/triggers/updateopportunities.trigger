trigger updateopportunities on Account(after update) 
{
    Set<Id> accountIds = new Set<Id>();

    for(Account ac : Trigger.new)
    {
      //   if(ac.Status__c=='Cancelled')
          //    accounIds.add(ac.Id);
    }

     List<Opportunity> oppsToUpdate = new List<Opportunity>();

     for(Opportunity opp : [select id, StageName from Opportunity where AccountId in: accountIds])
     {
          opp.StageName='Closed - Cancelled';
          oppsToUpdate.add(opp);
     }

     update oppsToUpdate;
}