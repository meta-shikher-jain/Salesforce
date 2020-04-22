//Trigger class for loan custom object
trigger LoanTrigger on Loan__c (before insert) {
    if(Trigger.IsBefore && Trigger.IsInsert){
        LoanTriggerHelper.LoanManagerUpdation(Trigger.new);
    }
}