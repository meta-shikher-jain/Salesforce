public class ContactsRelatedWithManagerController {
    public Id oppId{get; set;}
    public list<Contact> contactList { get; set; }
    public String contactRecord{get; set;}
    
    public List<SelectOption> getRelatedContacts(){
        List<SelectOption> option = new List<SelectOption>();
        oppId = apexpages.currentpage().getparameters().get('id');
        contactList = [SELECT Id, Name FROM Contact WHERE AccountId IN (SELECT Managers__c FROM Opportunity WHERE Id = : oppId)];
        for(Contact cont : contactList){
            option.add(new SelectOption(cont.Id,cont.Name));
        }
        return option;
    }
    public PageReference Save(){
        Opportunity oppObj = [SELECT Bill_To_Contact__c FROM Opportunity WHERE id=:oppId ];
        if(contactRecord != null){
            oppObj.Bill_To_Contact__c = contactRecord;
            update oppObj;
        }
        PageReference pageredirect = new PageReference('/'+oppId);
        pageredirect.setRedirect(true);
        return pageredirect;
    }
    
    public PageReference Cancel(){
        PageReference pageredirect = new PageReference('/'+oppId);
        pageredirect.setRedirect(true);
        return pageredirect;
    }
    
    public PageReference Clear(){
        Opportunity oppObj = [SELECT Bill_To_Contact__c FROM Opportunity WHERE id = :oppId ];
        oppObj.Bill_To_Contact__c = null;
        update oppObj;
        PageReference pageredirect = new PageReference('/'+oppId);
        pageredirect.setRedirect(true);
        return pageredirect; 
    }    
}