// Teach Trigger Class Helper class
public class TeachTriggerHelper {
    // Trigger method to not allow to insert or update if teaching subject is Hindi 
    public static void TeachNotAllowIfHindiSub(List<Teach__c> teachList){
        for(Teach__c teachRecord : teachList){
            if(teachRecord.Subject__c.Contains('Hindi')){
                teachRecord.addError('Teaching not allowed for Hindi.');
            }
        }
    }
}