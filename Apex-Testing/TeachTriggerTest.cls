@IsTest
public class TeachTriggerTest {
    // Test method for testing not allow to insert if teaching subject is Hindi
    @IsTest static void test1TeachNotAllowIfHindiSub(){
        // Given
        Contact con = new Contact(FirstName ='firstname Contact ',
                                  LastName = ' lastname Contact ');
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 10);
        insert con;
        insert classRecord;
        // When
        Teach__c teachRecord = new Teach__c(Class__c = classRecord.Id, Teacher__c = con.Id,Subject__c = 'Hindi');
        try {
            insert teachRecord; 
        }
        // Then
        catch(DmlException ex){
            System.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION,ex.getDmlType(0));
            System.assertEquals('Teaching not allowed for Hindi.', ex.getDmlMessage(0));
        }
    }
    // Test method for testing not allow to update if teaching subject is Hindi
    @IsTest static void test2TeachNotAllowIfHindiSub(){
        // Given
        Contact con = new Contact(FirstName ='firstname Contact ',
                                  LastName = ' lastname Contact ');
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 10);
        insert con;
        insert classRecord;
        // When
        Teach__c teachRecord = new Teach__c(Class__c = classRecord.Id, Teacher__c = con.Id,Subject__c = 'English');
        insert teachRecord; 
        // Then
        // Testing for negative test case when subject is not Hindi
        System.assertEquals(1, [SELECT Count() FROM Teach__c]);
        teachRecord.Subject__c = 'Hindi';
        try {
            update teachRecord;
        }
        catch(DmlException ex){
            System.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION,ex.getDmlType(0));
            System.assertEquals('Teaching not allowed for Hindi.', ex.getDmlMessage(0));
        }
    }
}