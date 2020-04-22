// Batch class to send mail to opportunity owner which are not modified for last 30 days
global class SendMailToOpportunityOwnerBatch implements Database.Batchable<sObject>{
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,ownerID,Owner.Email FROM Opportunity WHERE LastModifiedDate = LAST_N_DAYS:30]);
    }
	global void execute(Database.BatchableContext bc, List<Opportunity> scope){
     for(Opportunity s : scope){
		// Create an email message object
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {s.Owner.Email};
        mail.setCcAddresses(toAddresses);
        mail.setSubject('Testing Apex Scheduler-Subject');
        mail.setPlainTextBody('Testing Apex Scheduler-Body');
        // Sending mail to the opportunity owner
        Messaging.SendEmailResult[] results = Messaging.sendEmail(
                                 new Messaging.SingleEmailMessage[] {mail});
     }
   }    
    global void finish(Database.BatchableContext bc){}
}