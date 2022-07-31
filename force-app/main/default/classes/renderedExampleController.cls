public class renderedExampleController 
{
    Public Boolean PBFlag{get;set;}
    Public Account[] accRec{get;set;}
    
    Public renderedExampleController(){
        accRec = [select name,id,accountnumber from account];
        
        PBFlag= false;
    }
    
    Public void ShowPB(){
        PBFlag= true;
    }
}