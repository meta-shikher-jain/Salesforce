// Class for getting all the Sobjects in the org
public class ListOfSobjects {
    // Method to get all the sObjects in the org according to their permissionx
    public static List<string> showAllSobjects(){
        List<string> SObjectList = new List<string>();
            for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
                String name = objTyp.getDescribe().getName();
                SobjectList.add(name);
            }
            for(String s : SobjectList){
                System.debug(s);
            }
        return SobjectList;
    }
}