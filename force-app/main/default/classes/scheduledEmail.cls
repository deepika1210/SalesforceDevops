global class scheduledEmail  implements Schedulable {
global static Map<Id,Id> accountOwnerIdMap=new Map<Id,Id>();
   global void execute(SchedulableContext SC) {
       
      sendmail(accountOwnerIdMap);
      
   }
    public static Map<Id,Id> getownnermap(Map<Id,Id> accountOwnerIds)
    {
                accountOwnerIdMap.putAll(accountOwnerIds);
        return accountOwnerIdMap;

    }
     public static void sendmail(Map<Id,Id> accountOwnerIds)
    {
        List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
        Set<Id> ownerids=new  Set<Id> ();
        
        ownerids=accountOwnerIds.keyset();
        List<String> sendTo = new List<String>();
        List<User>users=new List<User>();
        if(ownerids.size()>0 )
        {
            
            users=[select name,id,email from user where id in:ownerids];
            system.debug('-------------users------'+users);
            if(users.size()>0){
                for(User u:users){
                    sendTo.add(u.Email);
                }
            }
        }
        //if(accountOwnerIds.values().size()>0)
        //{
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        string [] toaddress= New string[]{'deepika.chitu@gmail.com'};
            //  mail.setTargetObjectId(accountOwnerIds.
            mail.setReplyTo('deepika.chitu@gmail.com');
        mail.setSubject('Testing Apex Scheduler-Subject');
        mail.setPlainTextBody('Testing Apex Scheduler-Body');
        mail.setToAddresses(sendTo);
        mail.setSenderDisplayName('Case count');
        mail.setSubject('Case Count greater than 10');
        String body = 'Dear';
        body += 'Case Count greater than 10';
        mail.setHtmlBody(body);
        mails.add(mail);
        //Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
        // }
        if(!mails.isEmpty()) {
            Messaging.sendEmail(mails);
        }
    }
    
  
}