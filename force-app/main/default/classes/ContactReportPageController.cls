/*@Author : Deepika
* @Created Date: Jan-14-2022
* @Description : class for ShowContactReport page
*/

public class ContactReportPageController {
    public List<SelectOption> availableReports { get; set; }
    public Id reportId { get; set; }
    public Id instanceId { get; set; }
    public Id campid { get; set; }
    public Boolean reportIsRunning { get; set; }
    private transient Reports.ReportResults reportResults;
    
    public ContactReportPageController() {
        availableReports = retrieveAvailableReports();
    }
    //to get availableReport
    public List<SelectOption> retrieveAvailableReports() {
        List<SelectOption> reptOpts = new List<SelectOption>();
        List<Report> repRecList=new List<Report>();
        repRecList=[SELECT Id,Name,DeveloperName 
                    FROM Report 
                    WHERE DeveloperName='Contact_Report_Cube84'];
        system.debug('***repRecList'+repRecList);
        if(repRecList.size()>0)
        {
            for (Report r : repRecList) {
                reptOpts.add(new SelectOption(r.Id, r.Name));
            }
        }
        system.debug('***reptOpts'+reptOpts);
        return reptOpts;
    }
    //called on click of submit button
    public PageReference runReport() {
        reportResults = Reports.ReportManager.runReport(reportId, true);
        system.debug('***reportResults'+reportResults);
        campid = System.currentPageReference().getParameters().get('id');
        system.debug('***campid'+campid);
      
        String JSONString = JSON.serialize(reportResults);
         system.debug('***JSONString'+JSONString);
       AddCampaignMembers.CreateCampaignMembersFromReport(campid,reportId);
       ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM,'Campaign members added Successfully.Thank you!'));

       return null; 
        
    }
    
    
    public PageReference checkForReportResults() {
        reportResults = Reports.ReportManager.runReport(instanceId,true);
        //processInstance(reportInstance);
        
        return null;
    }
    
   
    
    public Reports.ReportResults getReportResults() {
        return reportResults;
    }
   
    
}