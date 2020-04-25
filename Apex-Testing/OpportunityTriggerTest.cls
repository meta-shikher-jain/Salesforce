@IsTest
public class OpportunityTriggerTest {
    // Test class for testing the , updation of manager field according to the account 
    // related to contact in Bill_to_manager field
    static testmethod void opportunityUpdateManagerField(){
        // Given
        List<Contact> contactList = TestFactoryDataForAccountAndContact.createAccountsWithContacts(1,1);
        Opportunity opp = new Opportunity(Name='Opportunity Test',StageName='Prospecting',CloseDate=System.today().addMonths(1));
        insert opp;
        // When
        Test.startTest();
        opp.Bill_To_Contact__c = contactList[0].Id;
        update opp;
        Test.stopTest();
        Opportunity updatedOpp = [SELECT Managers__c FROM Opportunity];
        // Then
        System.assertEquals(contactList[0].AccountId, updatedOpp.Managers__c);
    }
    // Test Class for updating the opportunity close date if the stage changed 
    // from any other stage to Closed Won or Closed Lost
    static testmethod void opportunityUpdateCloseDate(){
        // Given
        List<Contact> contactList = TestFactoryDataForAccountAndContact.createAccountsWithContacts(1,1);
        Opportunity opp = new Opportunity(Name='Opportunity Test',StageName='Prospecting',CloseDate=System.today().addMonths(1));
        insert opp;
        opp.StageName = 'Closed Lost';
        // When
        update opp;
        Opportunity updatedOpp = [SELECT CloseDate FROM Opportunity];
        // Then
        System.assertEquals(System.today(),updatedOpp.CloseDate);
    }
}