// Student Object Trigger Helper class
public class StudentTriggerHelper {
    // Trigger method to not allow student when class size exceed
    public static void StudentNotAllowedIfLimitExceed(List<Student__c> studentList){
        // Set of Class id which are present in students which are to be inserted
        Set<Id> classIdInStudentListSet = new Set<Id>();
        for(Student__c studentRecord : studentList){
            classIdInStudentListSet.add(studentRecord.Class__c);
        }
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
                stud.addError(
                    'Cannot add student in class, class size is full.');    
            } else	{
                classIdToStudentCountMap.put(stud.Class__c,classIdToStudentCountMap.get(stud.Class__c) + 1);
            }
        }
    }
    // Method to update the MyCount field of Class when the Student record is insert,delete,undelete
    public static void updateMyCountOnClassOnStudentAddition(List<Student__c> studentList){
        Set<Id> studClassId = new Set<Id>();
        for(Student__c stud : studentList){
            studClassId.add(stud.Class__c);
        }
        List<Class__c> classDataList = [SELECT MyCount__c,(SELECT Id FROM Students__r) FROM Class__c WHERE Id IN : studClassId];
        for(Class__c classRecord : classDataList){
            classRecord.MyCount__c = classRecord.Students__r.size();
        }
        update classDataList;
    }
}