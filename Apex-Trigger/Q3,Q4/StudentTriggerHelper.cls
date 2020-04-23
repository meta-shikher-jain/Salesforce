// Student Object Trigger Helper class
public class StudentTriggerHelper {
    // Trigger method to not allow student when class size exceed
    public static void StudentNotAllowedIfLimitExceed(List<Student__c> studentList){
        // Set of Class id which are present in students which are to be inserted
        Set<Id> classIdInStudentListSet = new Set<Id>();
        for(Student__c studentRecord : studentList){
            classIdInStudentListSet.add(studentRecord.Class__c);
        }
        Boolean IsErrorOccurToAddStudent = false;
        // Class List
        List<Class__c> classOfStudentList = [SELECT MyCount__c,MaxSize__c,(SELECT Id FROM Students__r),Custom_Status__c 
                                             FROM Class__c WHERE Id IN : classIdInStudentListSet];
        // Map for class id as a key and student count in class as a value
        Map<Id,Integer> classIdToStudentCountMap = new Map<Id,Integer>();
        // Map for class id as a key ans max size of student in class as a value
        Map<Id,Integer> classIdToMaxStudentSizeMap = new Map<Id,Integer>();
        for(Class__c classRecord : classOfStudentList){
            classIdToStudentCountMap.put(classRecord.Id, classRecord.Students__r.size());
            classIdToMaxStudentSizeMap.put(classRecord.Id,(Integer)classRecord.MaxSize__c);
        }
        //system.assert(false,'hello' + Trigger.new);
        //for(Student__c stud : (List<Student__c>)Trigger.new)
        for(Student__c stud : studentList){
            // When if student count gets more than max size of class than show error
            // else increase the student count in class
            if(classIdToStudentCountMap.get(stud.Class__c) >= classIdToMaxStudentSizeMap.get(stud.Class__c)){
                IsErrorOccurToAddStudent = true;
                stud.addError(
                    'Cannot add student in class, class size is full.');    
            } else	{
                classIdToStudentCountMap.put(stud.Class__c,classIdToStudentCountMap.get(stud.Class__c) + 1);
            }
        }
// Condition to update the MyCount field in Class if there is not any error occurs to add students
        if(!IsErrorOccurToAddStudent){
            for(Class__c classRecord : classOfStudentList){
                classRecord.MyCount__c = classIdToStudentCountMap.get(classRecord.Id);
            }
            update classOfStudentList;
        }
    }
    // Method to update the MyCount field of Class when the Student record is deleted
    public static void updateClassFieldOnStudentDelete(List<Student__c> studentList){
        if(!studentList.IsEmpty()){
            // Set of Class id which are present in students which are to be remains after deleted
            Set<Id> classIdInStudentListSet = new Set<Id>();
            for(Student__c studentRecord : studentList){
                classIdInStudentListSet.add(studentRecord.Class__c);
            }
            // Map of class id with Deleted students class
            Map<Id,Class__c> classOfDeletedStudentMap = new Map<Id,Class__c>([SELECT MyCount__c FROM Class__c 
                                                                              WHERE Id IN : classIdInStudentListSet]);
            for(Student__c studentRecord : studentList){
                Class__c classRecord = classOfDeletedStudentMap.get(studentRecord.Class__c);
                classRecord.MyCount__c -= 1;
                classOfDeletedStudentMap.put(studentRecord.Class__c,classRecord);
            }
            update classOfDeletedStudentMap.values();
        }
    }
}