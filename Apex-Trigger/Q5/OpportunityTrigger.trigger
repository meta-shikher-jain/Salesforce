// Opportunity object Trigger class
trigger OpportunityTrigger on Opportunity (before update) {
    if(Trigger.IsBefore && Trigger.IsUpdate){
        OpportunityTriggerHelper.updateCloseDateFieldWithToday(Trigger.newMap,Trigger.oldMap);
    }
}