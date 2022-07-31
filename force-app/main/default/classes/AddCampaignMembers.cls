/*@Author : Deepika
* @Created Date: Jan-17-2022
* @Description : class for adding campaign members from report contacts
*/

public class AddCampaignMembers {
    
    //method to add campaign members from report contacts
    public static void CreateCampaignMembersFromReport(id campaignId,id reportId){

        //This will be the initial filter for the report until it runs a second time.
        //the second time and on, the filter gets dynamically assigned the autonumuber related to the bottommost id on the report.
        String filterNumber = '0';

        //initialize numOfRow at 1. When it gets reassigned to 0, stop the while loop
        id firstconid;
        Integer numOfRows = 1;
        Integer loopCount = 0;

        //you do your setup here. i'm setting up a campaign member list.

        //create a set of campaign memebers. To be populated in the for loop with contacts. Sets removes possibility of dupes.
        Set<CampaignMember> campaignmembers = new Set<CampaignMember>();
        //create list for insert at the end
        List<CampaignMember> campaignMemberList = new List<CampaignMember>();
        Boolean manualBreak = false;

        //break loop when report stops returning results, or when told to break.
        while(numOfRows>0 && !manualBreak){
            loopCount++;                

            // Get the report metadata in order to create dynamic filter (since reports run with a maximum of 2,000 return results)
            Reports.ReportDescribeResult describe = Reports.ReportManager.describeReport(reportId);
            Reports.ReportMetadata reportMd = describe.getReportMetadata();           
            Reports.ReportFilter filter = reportMd.getReportFilters()[0];
            filter.setValue(String.valueOf(filterNumber));                              

            // Run a report synchronously
            Reports.reportResults ActiveISOContacts = Reports.ReportManager.runReport(reportId, reportMd, true);
            ActiveISOContacts.getAllData();

            // Get the fact map from the report results
            Reports.ReportFactWithDetails factDetails = 
            (Reports.ReportFactWithDetails)ActiveISOContacts.getFactMap().get('T!T');

            //create a list of report rows and populate it with the result rows from fact map
            List<Reports.ReportDetailRow> reportRows = factDetails.getRows();

            numOfRows = reportRows.size();
            System.debug('Value of numOfRows: ' + numOfRows);
            //loop through each report detail row and create a campaign member

            //loop throgh row by row the get the data
            for(integer count = 0; count<numOfRows;count++){                        

                List<Reports.ReportDataCell> datacells = reportRows[count].getDataCells();
                Reports.ReportDataCell datacell = datacells[0];
                id conid = (id)datacell.getValue();
        		system.debug('****conid'+conid);

                //make sure loop doesn't enter infinite loop
                if(count==0 && loopCount>1 && firstconid==conid){
                    manualBreak = true;
                    break;
                }

                //set conid to firstconid for reference in the next loop
                if(count==0){                       
                    firstconid = conid;                     
                }

                CampaignMember campaignmember = new CampaignMember(CampaignId=campaignId,ContactId=conid);
                campaignmembers.add(campaignmember);

                //HERE's WHERE YOU SET THE FILTER TO DYNAMICALLY CHANGE (only get it when you're in the last row of the report results)**
                if(count==numOfRows-1){
                   filterNumber= [Select Record_Number__c FROM Contact WHERE id= :conid].Record_Number__c;
                }
       system.debug('****campaignmembers'+campaignmembers);

            }
        }
        campaignMemberList.addall(campaignmembers);
        system.debug('****campaignMemberList'+campaignMemberList);
        system.debug('****campaignMemberList.size'+campaignMemberList.size());

        Database.insert(campaignMemberList,false);
    }       

}