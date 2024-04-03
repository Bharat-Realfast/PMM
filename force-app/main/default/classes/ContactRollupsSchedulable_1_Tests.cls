
@isTest
private class ContactRollupsSchedulable_1_Tests {
    
    @testSetup
    static void makeTestData() {
        // No test data is created since this test does not depend on persisted data.
    }
    
    // Happy Path Test
    @isTest
    static void testExecuteSchedulable() {
        // Exercise
        Test.startTest();
        // Use a valid cron expression that represents a future time.
        // For example, '0 0 23 * * ?' schedules the job to run at 11 PM every day.
        String jobId = System.schedule('Test Contact Rollups', '0 0 23 * * ?', new ContactRollupsSchedulable());
        Test.stopTest();
        
        // Verify
        // Check if the job has been scheduled successfully by asserting that the jobId is not null.
        System.assertNotEquals(null, jobId, 'Job should be successfully scheduled and jobId should not be null.');
        
        // Check the CronTrigger to assert the scheduled job's existence.
        CronTrigger ct = [SELECT Id, CronExpression FROM CronTrigger WHERE Id = :jobId];
        System.assertEquals('0 0 23 * * ?', ct.CronExpression, 'The scheduled job\'s CronExpression should match.');
    }
}
