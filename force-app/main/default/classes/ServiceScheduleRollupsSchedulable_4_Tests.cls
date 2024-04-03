
@isTest
private class SSRSchedulable_4_Tests {
   
    // Test method for the happy path of finish method
    @isTest
    static void testFinishMethod() {
        // Instantiate the ServiceScheduleRollupsSchedulable class
        ServiceScheduleRollupsSchedulable batchClass = new ServiceScheduleRollupsSchedulable();
        
        Test.startTest();
        // Execute the finish method
        batchClass.finish(null);
        Test.stopTest();
        
        // Assertions for the happy path
        List<AsyncApexJob> jobs = [
            SELECT Id, ApexClass.Name, Status 
            FROM AsyncApexJob 
            WHERE ApexClass.Name = 'ServiceDeliveryRollupsBatch'
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];
        
        System.assertNotEquals(0, jobs.size(), 'A job for ServiceDeliveryRollupsBatch should have been found.');
        System.assertEquals('Queued', jobs[0].Status, 'Job should be queued.');
    }
}
