public class ClassOperation {
    // Method to search for all the students name from a class corresponding to class Id
    public static List<String> studentNamesInClass(Id classId){
        // List of student sObject which have classId equals to given classId
        List<Student__c> searchStudent = [SELECT First_Name__c FROM Student__c WHERE Class__c = : classId];
        // List of student names
        List<String> nameOfStudents = new List<String>();
        for(Student__c student : searchStudent){
            nameOfStudents.add(student.First_Name__c);
        }
        return nameOfStudents;
        //system.assert(false,nameOfStudents);
    }
    // Method to return map of class and students in it
    public static Map<String, Set<Id>> studentsInClass(){
        List<Class__c> classData = [SELECT Name,(SELECT Id FROM Students__r) FROM Class__c];
        // Map for class name as a key and stundents id in class list as a value
        Map<String, Set<Id>> classStudents = new  Map<String, Set<Id>>(); 
        for(Class__c tempClass : classData){
            // Temperorary Set to store set in map as a value
            Set<Id> studentsId = new Set<Id>();
            for(Student__c student : tempClass.Students__r){
                studentsId.add(student.Id);
            }
            classStudents.put(tempClass.Name,studentsId);
           	//studentsId.clear();
        }
        system.assert(false,classStudents);
        return classStudents;
       //system.assert(false,classStudents);
    }
    // Method to get the number of workin days between two dates
    public static Integer numberOfWorkingDays(Date startDate, Date endDate){
        Integer workingDays = 0;
        Integer daysBetweenDates = startDate.daysBetween(endDate) - 1;
        Integer numberOfWeeks = daysBetweenDates/7;
        //System.assert(false,daysBetweenDates);
        if(Math.mod(daysBetweenDates,7) == 0){
            workingDays = numberOfWeeks * 5;
        }
        else{
            workingDays = numberOfWeeks * 5;
            Integer remainingDays = Math.mod(daysBetweenDates,7);
            //System.assert(false,remainingDays);
            for(Integer iterator = 1; iterator <= remainingDays; iterator++){
                Date todayDate = startDate + iterator;
                //system.assert(false, dt);
                DateTime currDate = DateTime.newInstance(todayDate.year(), todayDate.month(), todayDate.day());
                String todayDay = currDate.format('EEEE');  
                if(todayDay != 'Saturday' && todayDay !='Sunday')  
                {  
                    workingDays = workingDays + 1;  
                }     
            }
        }
        //system.assert(false, workingDays);
        system.debug(workingDays);
        return workingDays;
    }
}