@IsTest
public class ClassTriggerTest {
    // Positive Test case method to not allow to delete the class if having more than 2 female students
    @IsTest static void positiveTestClassNotAllowedToDeleteTrigger(){
        // Given
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 10);
        insert classRecord;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 4; i++){
            Student__c studentData = new Student__c(First_Name__c = 'Test Name '+ i, LastName__c = 'LastName' + i, Sex__c = 'Female',Class__c = classRecord.Id);
            studentList.add(studentData);
        }
        insert studentList;
        // When
        try {
            delete classRecord; 
        }
        // Then
        catch(DmlException ex){
            System.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION,ex.getDmlType(0));
            System.assertEquals('Cannot delete class with more than 2 female students.', ex.getDmlMessage(0));
        }
    }
    // Negative Test case method to not allow to delete the class if having more than 2 female students
    @IsTest static void negativeTestClassNotAllowedToDeleteTrigger(){
        // Given
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 10);
        insert classRecord;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 4; i++){
            Student__c studentData = new Student__c(First_Name__c = 'Test Name '+ i, LastName__c = 'LastName' + i, Sex__c = 'Male',Class__c = classRecord.Id);
            studentList.add(studentData);
        }
        insert studentList;
        // When 
        delete classRecord;
        // Then
        System.assertEquals(0,[SELECT Count() FROM Class__c]);
    }
    // Test method to delete the related students when class Custom Status updated to Reset
    @IsTest static void testDeleteRelatedStudentsWhenReset(){
        // Given
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 10,Custom_Status__c = 'Open');
        insert classRecord;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 4; i++){
            Student__c studentData = new Student__c(First_Name__c = 'Test Name '+ i, LastName__c = 'LastName' + i, Sex__c = 'Male',Class__c = classRecord.Id);
            studentList.add(studentData);
        }
        insert studentList;
        // Test when the Custom Status field in class is Open
        System.assertEquals(4, [SELECT Count() FROM Student__c WHERE Class__c = : classRecord.Id]);
        // When 
        classRecord.Custom_Status__c = 'Reset';
        update classRecord;
        // Then
        // Test when the Custom Status field in class is Reset
        System.assertEquals(0, [SELECT Count() FROM Student__c WHERE Class__c = : classRecord.Id]);
    }
    
}