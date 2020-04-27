// Scheduler for sending mail to opportunity which are not modified for last 30 days
global class SendMailToOpportunityOwnerScheduler implements Schedulable {
   global void execute(SchedulableContext sc) {
      SendMailToOpportunityOwnerBatch obj = new SendMailToOpportunityOwnerBatch();
      database.executebatch(obj);
     // String CRON_EXP = '0 24 9 20 4 ? 2020';
       //String jobId = System.schedule('ScheduledApexTest',
            //CRON_EXP,new scheduledBatchable());  
   }
}