public class FetchDataController {
   public opportunity opp{get;set;}
public list<Opportunity> olist {get;set;}
public string ids;
public account acc;
    public FetchDataController(ApexPages.StandardController controller) 
    {
      Contact con = (Contact)controller.getRecord();
      contact c1 = [select id , accountId from Contact];
                    //where id =: con.id];
      ids = c1.accountId;
      olist = new list<opportunity>([select id, name, stagename from opportunity ]);
                                     //where AccountId =: ids]);
    }
}