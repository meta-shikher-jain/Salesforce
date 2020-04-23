// Trigger of Student custom object
trigger StudentTrigger on Student__c (before insert,after delete) {
    If(Trigger.IsBefore && Trigger.IsInsert){
        StudentTriggerHelper.StudentNotAllowedIfLimitExceed(Trigger.new);
    }
    If(Trigger.IsAfter && Trigger.IsDelete){
        StudentTriggerHelper.updateClassFieldOnStudentDelete(Trigger.old);
    }
}