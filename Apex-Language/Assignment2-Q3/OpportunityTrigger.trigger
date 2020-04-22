// Opportunity object Trigger class
trigger OpportunityTrigger on Opportunity (before update) {
    // Checking condition of IsFireTrigger if true than execute the trigger
    if(Trigger.IsBefore && Trigger.IsUpdate && OpportunityTriggerHelper.IsFireTrigger){
       OpportunityTriggerHelper.opportunityUpdateManagerField();
    }
}