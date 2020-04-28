@IsTest
public class SendMailToOpportunityOwnerTest {
    // Given
    @testsetup
    static void setup(){
        List<Opportunity> oppRecords = new List<Opportunity>();
        for(Integer i = 0; i < 150; i++){
            Opportunity opp = new Opportunity(Name = 'Test', StageName='Prospecting', CloseDate = date.newInstance(2020, 4, 28));
            oppRecords.add(opp);
        }
        insert oppRecords;
    }
    @IsTest  static void testSchedulable(){
        String CRON_EXP = '0 2 23 24 4 ? 2020';
        Test.startTest();
        // When
        System.schedule('ScheduledApexTest', CRON_EXP,new SendMailToOpportunityOwnerScheduler());   
        Test.stopTest();
        // Then
        System.assertEquals(150, [SELECT Count() FROM Opportunity]);
    }
}