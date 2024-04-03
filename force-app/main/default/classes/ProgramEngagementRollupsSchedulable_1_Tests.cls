
@isTest
private class EngmtRollupSchedTest {

    @isTest
    static void testExecuteScheduledJobInitiatesBatch() {
        Test.startTest();
        ProgramEngagementRollupsSchedulable schedulableJob = new ProgramEngagementRollupsSchedulable();
        schedulableJob.execute(null);
        Test.stopTest();

        // Verify that a batch job has been enqueued (asynchronously)
        Integer jobsQueued = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Queued'];
        System.assertEquals(1, jobsQueued, 'A batch job should be queued.');
    }
}
