trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
     List<BatchLeadConvertErrors__c> LeadConvertErrorList = new List<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent event: trigger.new){
    	BatchLeadConvertErrors__c lcerror = new BatchLeadConvertErrors__c();
        lcerror.AsyncApexJobId__c = event.AsyncApexJobId;
        lcerror.Records__c = event.JobScope;
        lcerror.StackTrace__c = event.StackTrace;
        
        LeadConvertErrorList.add(lcerror);
    }
    if(LeadConvertErrorList.size() > 0 && LeadConvertErrorList != null){
    	insert LeadConvertErrorList;
    }

}