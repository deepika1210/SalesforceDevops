public class ActionFunEx 
{
     String usernam;
     public String getUsername() {
         return usernam;
     }

    private String TempVal = 'Dinesh';
            
     public PageReference AFcall() {
         usernam = UserInfo.getName();
         return null;
     }
            
     public void setTempVal(String n) {
         TempVal = n;
     }
            
     public String getTempVal() {
         return TempVal;
     }
           
     public PageReference ActionMethod() {
         return null;
     }


}