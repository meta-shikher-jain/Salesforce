// Class Trigger Helper Class
public class ClassTriggerHelper {
    // Method for not allow to delete the class if having more than 2 female students
    public static void ClassNotAllowedToDeleteTrigger(List<Class__c> classList,Map<Id,Class__c> oldMap){
        // Student objects which are in class with more than 2 female students
        List<AggregateResult> studentClass = [SELECT Class__c FROM Student__c WHERE Sex__c = 'Female' 
                                              GROUP BY Class__c Having Count(Id) > 2];
        // Class Id Set of class with more than two female students
        Set<Id> classIdSet = new Set<Id>();
        for(AggregateResult data : studentClass){
            Id classId = (Id)data.get('Class__c');
            classIdSet.add(classId);
        }
        // Setting error to class which is tried to delete having more than 2 female students
        for(Class__c classRecord : classList){
            if(classIdSet.Contains(classRecord.Id)){
                oldMap.get(classRecord.Id).addError(
               'Cannot delete class with more than 2 female students.'); 
            }
        }
    }
    // Trigger method to delete the related students 
    public static void DeleteRelatedStudentsWhenReset(Map<Id,Class__c> newClassMap, Map<Id,Class__c> oldClassMap){
        // Set Of classIds whose previous status is not equal to new status and also the status is 'Reset'
        Set<Id> classIdWithChangedStatusSet = new Set<Id>(); 
        for(Class__c classRecord : newClassMap.values() ){
            if(oldClassMap.get(classRecord.Id).Custom_Status__c != classRecord.Custom_Status__c 
               && classRecord.Custom_Status__c == 'Reset' ){
                
                classIdWithChangedStatusSet.add(classRecord.Id);
            }
        }
        if(classIdWithChangedStatusSet.size() > 0){
            // Related Student list whose class have a status changed and value is 'Reset'
            List<Student__c> relatedStudentList = [SELECT Id FROM Student__c 
                                                   WHERE Class__c IN : classIdWithChangedStatusSet];
            if(relatedStudentList.size() > 0){
                Delete relatedStudentList;
            }
        }
    }
}