// Trigger of Class custom object
trigger ClassTrigger on Class__c (before delete,before update,before insert,after update) {
    if(Trigger.IsBefore && Trigger.IsDelete){
        ClassTriggerHelper.ClassNotAllowedToDeleteTrigger(Trigger.old,Trigger.oldMap);
    }
    if(Trigger.IsAfter && Trigger.IsUpdate){
        ClassTriggerHelper.DeleteRelatedStudentsWhenReset(Trigger.newMap, Trigger.oldMap);
    }
}