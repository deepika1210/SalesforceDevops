public class ContactFormatUseController {
  @AuraEnabled

public static Contact CreateNewContact (Contact con) {

    upsert con;

    return con;

}
}