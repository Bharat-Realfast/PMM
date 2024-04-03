
@isTest
private class ContactRollupsSchedulable_4_Tests {
    
    @testSetup
    static void setup() {
        // Since no test data is required for finish method, the setup is left empty
    }
    
    @isTest
    static void testFinishMethodHappyPath() {
        // Given a ContactRollupsSchedulable instance
        ContactRollupsSchedulable batchInstance = new ContactRollupsSchedulable();
        
        // Capture the initial job count before enqueuing the new batch
        Integer initialJobCount = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Queued'];

        Test.startTest();
        // Execute batch job
        batchInstance.finish(null);
        Test.stopTest();
        
        // Capture the job count after enqueuing the new batch
        Integer postJobCount = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Queued'];

        // Then a new batch job should be triggered
        System.assertEquals(initialJobCount + 1, postJobCount, 'A new batch job should have been enqueued.');
    }
}
