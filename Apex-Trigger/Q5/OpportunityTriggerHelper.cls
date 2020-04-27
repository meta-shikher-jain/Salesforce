// Opportunity Trigger Helper class
public class OpportunityTriggerHelper {
    // Trigger Method to update the close date of opportunity to today if stage change to Closed Won or Closed Lost
    public static void updateCloseDateFieldWithToday(Map<Id,Opportunity> newOpportunityMap, Map<Id,Opportunity> oldOpportunityMap){
        // List of stages which are mention as a closed
        List<String> closeStage = new List<String>{'Closed Won','Closed Lost'};
        // Updating the close date of opportunity to today if stage changed from another value to Closed Won or Closed Lost
        for(Opportunity oppRecord : newOpportunityMap.values()){
            if(oppRecord.StageName != oldOpportunityMap.get(oppRecord.Id).StageName 
               && closeStage.Contains(oppRecord.StageName) != closeStage.Contains(oldOpportunityMap.get(oppRecord.Id).StageName)
               && (oppRecord.StageName.Contains('Closed Won') || oppRecord.StageName.Contains('Closed Lost'))){
                   
                   oppRecord.CloseDate = system.today();
               }
        }
    }
}