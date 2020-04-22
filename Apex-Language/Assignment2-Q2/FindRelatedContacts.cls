// Batch class to find the related contacts of account
global class FindRelatedContacts implements Database.Batchable<sObject>,Database.stateful{
    id accId;
    String contactIds = '';
    global FindRelatedContacts(Id accId){
        this.accId = accId;
    }
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id,Account.ContactIds__c FROM Contact WHERE AccountId = : accId]);
    }
    global void execute(Database.BatchableContext bc, List<Contact> scope){
        // If batch are run in subpart than the stored contactId field data of previous batch 
        String contactIdData = scope[0].Account.ContactIds__c;
        for(Contact data : scope){
            // Check if stored contactId field data is not blank than append with , 
            if(!String.isBlank(contactIdData)){
            	contactIds += ',' + data.Id + ','; 
            }
            else{
                contactIds += data.Id + ',';
            }
        }
        contactIds = contactIds.removeEnd(',');
        scope[0].Account.ContactIds__c = contactIds;
        update scope[0].Account;
    }
    global void finish(Database.BatchableContext bc){
    }
}