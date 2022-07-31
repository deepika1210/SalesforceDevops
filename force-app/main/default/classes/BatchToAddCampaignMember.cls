global class BatchToAddCampaignMember implements Database.Batchable<sObject>, Database.Stateful
{
	global final Id campaignId;
	global final Set<Id> qKeys;
	
	global BatchToAddCampaignMember(Id campaignId, Set<Id> qKeys){
        this.campaignId = campaignId;
        this.qKeys = qKeys;
    }
	
    global Database.QueryLocator start(Database.BatchableContext BC) {
       	return Database.getQueryLocator('Select Id From Contact Where Id In :qKeys');
    }
   
    global void execute(Database.BatchableContext BC, List<Contact> scope) {
    	 List<CampaignMember> cm = new List<CampaignMember>();   
    	 Map<Id, Campaign> cmMap = new Map<Id, Campaign>([Select (Select ContactId From CampaignMembers) From Campaign c WHERE Id = :campaignId]);
         for(Contact c : scope) {
              CampaignMember newCM = new CampaignMember(
                CampaignId = campaignId,
                ContactId = c.Id,
                status = 'Sent' );
             	if (!cmMap.containsKey(c.Id)) {
                cm.add(newCM); 
                }
         }
         try {
         Database.insert(cm); 
         } catch (Exception ex) {
         	System.Debug('Insert failed ' + ex);
         }
         
    }   
    global void finish(Database.BatchableContext BC) {
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email 
					   	 FROM AsyncApexJob WHERE Id = :BC.getJobId()];
		// Send an email to the Apex job's submitter notifying of job completion.
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {a.CreatedBy.Email};
		mail.setToAddresses(toAddresses);
		mail.setSubject('Add to Campaign ' + a.Status);
		String campaignURL = URL.getSalesforceBaseUrl().toExternalForm() + '/' + campaignId;
		mail.setPlainTextBody('The batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures. '
							  + 'Link to Campaign: ' + campaignURL);
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}