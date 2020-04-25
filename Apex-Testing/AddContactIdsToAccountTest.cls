@IsTest
public class AddContactIdsToAccountTest {
    // Test method for testing the contactIds field in account object
    static testmethod void testContactIdInAccount(){
        // Given
        List<Contact> contList = TestFactoryDataForAccountAndContact.createAccountsWithContacts(1,150);
        // When
        Test.startTest();
        // Test when the ContactIds field in account object is empty 
        AddContactIdsToAccount.ContactIdInAccount(contList[0].Id);
        Test.stopTest(); 
        // Set of inserted contact id
        Set<Id> insertedContId = new Set<Id>();
        for(Contact cont : contList){
            insertedContId.add(cont.Id);
        }
        Account accOutputData1 = [SELECT ContactIds__c FROM Account WHERE Id = : contList[0].AccountId]; 
        // Set to get the contactIds which are in the field ContactIds in a account
        Set<Id> contIdInAccountSet = new Set<Id>();
        // Getting the list of all contactIds from ContactIds field in account
        List<Id> contIdInAccountList = accOutputData1.ContactIds__c.split(',');
        contIdInAccountSet.addAll(contIdInAccountList);
        // Then
        System.assertEquals(insertedContId,contIdInAccountSet);
        contIdInAccountList.clear();
        contIdInAccountSet.clear();
        // Testing the condition when ContactIds field in account object is not empty
        Contact con = new Contact(FirstName = 'Test ', LastName = 'Data ', AccountId =  contList[0].AccountId);
        insert con;
        insertedContId.add(con.id);
        AddContactIdsToAccount.ContactIdInAccount(con.Id);
        Account accOutputData2 = [SELECT ContactIds__c FROM Account WHERE Id = : contList[0].AccountId];
        contIdInAccountList = accOutputData2.ContactIds__c.split(',');
        contIdInAccountSet.addAll(contIdInAccountList);
        System.assertEquals(contIdInAccountSet,insertedContId);
    }
}