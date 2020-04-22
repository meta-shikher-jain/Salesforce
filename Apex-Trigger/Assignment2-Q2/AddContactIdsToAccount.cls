// Class for handling the contactId field of Account object
public class AddContactIdsToAccount {
    // Method to update contactIds in contactIds field 
    public static void ContactIdInAccount(Id ContactId){
        Id accId;
        //String contactIdsList;
        Contact con = [SELECT AccountId,Account.ContactIds__c FROM Contact WHERE Id = : ContactId];
        accId = con.AccountId;
        // Check if tha ContactIds field is blank than add related contacts with comma seperated list
        // else append the contact id in it
        if(String.isBlank(con.Account.ContactIds__c)){
            FindRelatedContacts batchToAddContactId = new FindRelatedContacts(accId);
            Database.executeBatch(batchToAddContactId);
        }
        else{
            List<Id> idList = con.Account.ContactIds__c.split(',');
            if(!idList.Contains(ContactId)){
                con.Account.ContactIds__c += ',' + ContactId; 
                update con.Account;
            }
        }
    }
}