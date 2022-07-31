public class ForceInputContactController {
 @AuraEnabled
    public static Contact getContact() {
        return [select Id, Name from Contact Limit 1];
    }
}