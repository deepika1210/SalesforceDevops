public class PaginationWithSelectAllClass 
{
     public ApexPages.StandardSetController con;
    
    public Map<Id, Decimal> quantityMap {get;set;}
    public Set<Id> selectedPropertyIds {get;set;}
    public String contextItem {get;set;}
    public String contextItemValue {get;set;}
    public Boolean selectedAllProperties {get;set;}
    
     public PaginationWithSelectAllClass()
    {         
        this.selectedPropertyIds = new Set<Id>();
        this.quantityMap = new Map<Id, Decimal>();
        size= 5;
        init();
    }
    /** handle item selected */
    public void doSelectItem()
    { 
        this.selectedPropertyIds.add(this.contextItem);
    }
    
    /** handle item deselected */
    public void doDeselectItem()
    {
        this.selectedPropertyIds.remove(this.contextItem);
    }
    
    public void isSelectedAll()
    {
        for (sObject record : this.con.getRecords()){
            Account a = (Account) record;
            if(selectedAllProperties){
                this.selectedPropertyIds.add(a.id);
            }else{
                this.selectedPropertyIds.remove(a.id);
            }
        }
    }
    
    public Integer getSelectedCount()
    {
        return this.selectedPropertyIds.size();
    } 
    
   
    
    public void init() 
    {
        this.con = new ApexPages.StandardSetController([SELECT Id,Name,AccountNumber,CreatedDate,Phone,Website,Industry,AnnualRevenue From Account ORDER BY Name  ASC, CreatedDate DESC LIMIT 50000] );
        this.con.setpageNumber(1);
        this.con.setPageSize(size);
        noOfRecords = this.con.getResultSize();  
    }
    
    public void updateQuantity()
    {
        this.quantityMap.put(this.contextItem, Decimal.valueOf(this.contextItemValue));
    }
    
    public List<PaginationWrap> getAccountWraps() 
    {
        List<PaginationWrap> accountWraps = new List<PaginationWrap>();
        Integer selectedPropertyNumber = 0;
        
        for (sObject record : this.con.getRecords())
        {
            Account a = (Account) record;
            PaginationWrap currentWrap = new PaginationWrap(a);
            //for the inputText
            if(quantityMap.containsKey(a.id))
            {
                currentWrap.quantity = quantityMap.get(a.id);
            } 
            //for the checkbox:
            if(this.selectedPropertyIds != null) 
            {
                if(this.selectedPropertyIds.contains(a.Id)){
                    currentWrap.checked = true;
                    selectedPropertyNumber ++; //show the checkbox selected count
                }
                else{
                    currentWrap.checked = false;
                }
            }
            accountWraps.add(currentWrap);
        }
        selectedAllProperties = selectedPropertyNumber == accountWraps.size() ? true: false; 
        return accountWraps; 
    } 
    
    public void savingSelectedRecords()
    {  
        for (Id key : quantityMap.keySet()) {
            // The "key" variable is also available inside the loop
            system.debug('map key: ' + key +  '  map key value: ' + quantityMap.get(key)); 
        }  
    } 
    
    public PageReference saveSelected() 
    {
        try{
            savingSelectedRecords();
        }
        catch(DmlException dmlException){
            Integer numErrors = dmlException.getNumDml();
            for(Integer i=0; i< numErrors; i++){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, dmlException.getDmlMessage(i)));
            }
            return null;
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error, e.getMessage()));
            return null;
        } 
        return null;
    }
    
    // If the pagiantion has next page 
    public Integer size {get;set;}
    public Integer noOfRecords{get; set;}
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }
    
    //Indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }
    
    //returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }
    
    public Integer totalPageNumber {
        get {
            Decimal totalSize = this.con.getResultSize();
            Decimal pageSize = this.con.getPageSize();
            Decimal pages = totalSize/pageSize;
            return (Integer)pages.round(System.RoundingMode.CEILING);
        }
        set;
    }
    
    /**
* Go to the first page directly
*/
    public void first() {
        con.first();
    }
    
    // returns the last page of records
    public void last() {
        con.last();
    }
    
    // returns the previous page of records
    public void previous() {
        con.previous();
    }
    
    // returns the next page of records
    public void next() {
        con.next();
    } 
    public class PaginationWrap { 
 
    public Boolean checked {get;set;} 
    public Account act {get;set;}
    public Decimal quantity {get;set;}
    public PaginationWrap(Account a){
        act = a;
        checked = false; 
        quantity = 0;
    }
}

}