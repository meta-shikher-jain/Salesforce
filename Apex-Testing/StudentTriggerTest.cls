@IsTest
public class StudentTriggerTest {
    // Positive Test case method to not allow student to add in class if class size exceeds
    @IsTest static void PositivetestStudentNotAllowedIfLimitExceed(){
        // Given
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 3);
        insert classRecord;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 4; i++){
            Student__c studentData = new Student__c(First_Name__c = 'Test Name '+ i, LastName__c = 'LastName' + i, Sex__c = 'Female',Class__c = classRecord.Id);
            studentList.add(studentData);
        }
        // When
        try{
            insert studentList;
        }
        // Then
        catch(DmlException ex){
            System.assertEquals(StatusCode.FIELD_CUSTOM_VALIDATION_EXCEPTION,ex.getDmlType(0));
            System.assertEquals('Cannot add student in class, class size is full.', ex.getDmlMessage(0));
        }
    }
    // Negative Test case method to not allow student to add in class if class size exceeds
    @IsTest static void NegativetestStudentNotAllowedIfLimitExceed(){
        // Given
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 5);
        insert classRecord;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 4; i++){
            Student__c studentData = new Student__c(First_Name__c = 'Test Name '+ i, LastName__c = 'LastName' + i, Sex__c = 'Female',Class__c = classRecord.Id);
            studentList.add(studentData);
        }
        // When
        insert studentList;
        // Then
        System.assertEquals(4, [SELECT Count() From Student__c WHERE Class__c = : classRecord.Id]);
    }
    // Test method to test the Mycount Field on Class according to student insert
    @IsTest static void InserttestupdateMyCountOnClassOnStudentAddition(){
        // Given
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 5);
        insert classRecord;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 4; i++){
            Student__c studentData = new Student__c(First_Name__c = 'Test Name '+ i, LastName__c = 'LastName' + i, Sex__c = 'Female',Class__c = classRecord.Id);
            studentList.add(studentData);
        }
        // When
        insert studentList;
        Class__c outputClassDataOnInsert = [SELECT MyCount__c From Class__c WHERE Id = : classRecord.Id];
        // Then
        // Test the Mycount field in Class when insert of student
        System.assertEquals(4, outputClassDataOnInsert.MyCount__c);
    }
    // Test method to test the Mycount Field on Class according to student delete 
    @IsTest static void DeletetestupdateMyCountOnClassOnStudentAddition(){
        // Given
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 5);
        insert classRecord;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 4; i++){
            Student__c studentData = new Student__c(First_Name__c = 'Test Name '+ i, LastName__c = 'LastName' + i, Sex__c = 'Female',Class__c = classRecord.Id);
            studentList.add(studentData);
        }
        insert studentList;
        Class__c outputClassDataOnInsert = [SELECT MyCount__c From Class__c WHERE Id = : classRecord.Id];
        // When
        delete studentList[0];
        Class__c outputClassDataOnDelete = [SELECT MyCount__c From Class__c WHERE Id = : classRecord.Id];
        // Then
        // Test the Mycount field in Class when delete of student
        System.assertEquals(3, outputClassDataOnDelete.MyCount__c);
    }
    // Test method to test the Mycount Field on Class according to student undelete
    @IsTest static void UndeletetestupdateMyCountOnClassOnStudentAddition(){
        // Given
        Class__c classRecord = new Class__c(Board__c = 'Bihar',Fee__c = 1000, MaxSize__c = 5);
        insert classRecord;
        List<Student__c> studentList = new List<Student__c>();
        for(Integer i = 0; i < 4; i++){
            Student__c studentData = new Student__c(First_Name__c = 'Test Name '+ i, LastName__c = 'LastName' + i, Sex__c = 'Female',Class__c = classRecord.Id);
            studentList.add(studentData);
        }
        insert studentList;
        Class__c outputClassDataOnInsert = [SELECT MyCount__c From Class__c WHERE Id = : classRecord.Id];
        delete studentList[0];
        Class__c outputClassDataOnDelete = [SELECT MyCount__c From Class__c WHERE Id = : classRecord.Id];
        // When
        undelete studentList[0];
        Class__c outputClassDataOnUndelete = [SELECT MyCount__c From Class__c WHERE Id = : classRecord.Id];
        // Then
        // Test the Mycount field in Class when undelete of student
        System.assertEquals(4, outputClassDataOnUndelete.MyCount__c);
    }
}