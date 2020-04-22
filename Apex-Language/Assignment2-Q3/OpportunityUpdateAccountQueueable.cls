public class OpportunityUpdateAccountQueueable implements Queueable {
	private List<Opportunity> listOpportunity;
    public OpportunityUpdateAccountQueueable(List<Opportunity> records){
        this.listOpportunity = records;
    }
    public void execute(QueueableContext context) {
        Set<Id> opportunityIdSet = new Set<Id>();
        set<Id> opportunityContactIdSet = new Set<Id>();
        for(Opportunity opp : listOpportunity){
            if(opp.Bill_To_Contact__c != null && opp.Managers__c == null){
                opportunityIdSet.add(opp.id);
                opportunityContactIdSet.add(opp.Bill_To_Contact__c);
            }
        }
        if(opportunityIdSet.size() > 0){
            Map<Id,Contact> contactAccountId = new Map<Id,Contact>([SELECT AccountId FROM Contact WHERE Id IN : opportunityContactIdSet]);
            for(Opportunity objOpp : listOpportunity){
                objOpp.Managers__c = contactAccountId.get(objOpp.Bill_To_Contact__c).AccountId;
            }
            // Updating the IsFireTrigger with False so that it does not call trigger again
            OpportunityTriggerHelper.IsFireTrigger = False;
            update listOpportunity;
        }
    }
}