@IsTest
public class LoanTriggerTest {
    // Test method to test the updation of the Manager of loan according to the city manager
    @IsTest static void testLoanManagerUpdation(){
        // Given
        Profile testProfile = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User testUser = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                                 EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                                 LocaleSidKey='en_US', ProfileId = testProfile.Id, 
                                 TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@metacubeTest.com');
        insert testUser;
        CityManager__c cityManager = new CityManager__c(Manager__c = testUser.Id, City__c = 'Test City');
        insert cityManager;
        // When
        Loan__c testLoan = new Loan__c(Name__c = 'Test Loan', City__c = cityManager.Id);
        insert testLoan;
        List<Loan__c> outputLoanData = [SELECT Loan_Manager__c FROM Loan__c WHERE Id = : testLoan.Id];
        //Then 
        System.assertEquals(outputLoanData[0].Loan_Manager__c,testUser.Id);
    }
}