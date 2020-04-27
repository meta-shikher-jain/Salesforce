// Trigger of Teach Custom Object
trigger TeachTrigger on Teach__c (before insert,before update) {
    If(Trigger.IsBefore && (Trigger.IsInsert || Trigger.IsUpdate)){
        TeachTriggerHelper.TeachNotAllowIfHindiSub(Trigger.new);
    }
}