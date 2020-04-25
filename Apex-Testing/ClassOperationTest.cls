@IsTest
public class ClassOperationTest {
    @IsTest static void studentNamesInClassMethodTest(){
        // Given
		Class__c clsData = new Class__c(Fee__c = 1000 ,MaxSize__c = 10);
		insert clsData; 
        Student__c stud = new Student__c(First_Name__c = 'Test' , LastName__c = 'Data', Class__c = clsData.Id);
        insert stud;
        List<String> expextedOutput = new List<String>{stud.First_Name__c};
        // When
        List<String> output = ClassOperation.studentNamesInClass(clsData.Id);
        // Then
        System.assertEquals(expextedOutput.size(), output.size());
        for(Integer i = 0; i < expextedOutput.size(); i++){
            System.assertEquals(expextedOutput[i], output[i]);
        }
    }
    @IsTest static void studentsInClassTest(){
        // Given
        Class__c clsData = new Class__c(Fee__c = 1000 ,MaxSize__c = 10);
        insert clsData;
        List<Student__c> studentRecord = new List<Student__c>();
        for(Integer i = 0; i < 2; i++){
        	Student__c stud = new Student__c(First_Name__c = 'Test' , LastName__c = 'Data', Class__c = clsData.Id);
            studentRecord.add(stud);
        }
        insert studentRecord;
        // When
        Map<String,Set<Id>> output = ClassOperation.studentsInClass();
        // Then
        System.assertEquals(output.keyset().size(),1);
        for (String key : output.keySet()){
            system.assertEquals(output.get(key).size(),2);
        }
    }
    @IsTest static void numberOfWorkingDaysTest(){
        // Given
        Date date1 = Date.newInstance(2020, 04, 17);
        Date date2 = Date.newInstance(2020, 04, 24);
        Date date3 = Date.newInstance(2020, 04, 25);
        // When
        Integer workDays1 = ClassOperation.numberOfWorkingDays(date1, date2);
        // Then
        system.assertEquals(workDays1,4);
        Integer workDays2 = ClassOperation.numberOfWorkingDays(date1, date3);
        system.assertEquals(workDays2,5);
    }
}