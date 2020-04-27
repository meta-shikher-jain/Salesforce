// Opportunity Trigger Helper class
public class OpportunityTriggerHelper {
    public static Boolean IsFireTrigger = True;
    // Trigger Helper method to execute the Queueable
    // method to update the manager field with the Bill To Contact field related Account 
    public static void opportunityUpdateManagerField(){
		OpportunityUpdateAccountQueueable updateJob = new OpportunityUpdateAccountQueueable(Trigger.new);
		System.enqueueJob(updateJob);
    }
}