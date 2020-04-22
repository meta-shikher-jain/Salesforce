// Helper class for Loan Trigger
public class LoanTriggerHelper {
    // Method to update the Manager of loan according to the city manager
    public static void LoanManagerUpdation(List<Loan__c> loanData){
        Set<Id> cityId = new Set<Id>();
        for(Loan__c loan : loanData){
            cityId.add(loan.City__c);
        }
        Map<Id, CityManager__c> cityEntries = new Map<Id, CityManager__c>([SELECT City__c,Manager__c FROM CityManager__c 
                                                                           WHERE Id IN : cityId]);
        for(Loan__c loan : loanData){
            CityManager__c entry = cityEntries.get(loan.City__c);
            if(entry != null){
                loan.Loan_Manager__c = entry.Manager__c;
            }
        }
    }
}