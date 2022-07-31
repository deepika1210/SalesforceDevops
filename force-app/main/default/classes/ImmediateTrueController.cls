public class ImmediateTrueController {
    public Boolean Flag1{get;set;}
    public Boolean Flag2{get;set;}
    public ImmediateTrueController(ApexPages.StandardController controller) {
        Flag1= false;
        Flag2= false;
    }
    
    public pagereference savebutton(){
        Flag1= true;
        Flag2= false;
        return null; }
    
    public pagereference cancelbutton(){
        Flag1= false;
        Flag2= true;
        return null; }
    
    
}