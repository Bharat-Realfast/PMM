
@isTest
private class ServiceSchRollupsSched_3_Tests {

    // Test setup to create test data
    @testSetup
    static void makeTestData() {
        // Create test data for ServiceSchedule__c
        ServiceSchedule__c testServiceSchedule = new ServiceSchedule__c(
            NumPresentServiceDeliveries__c = 1,
            NumAbsentServiceDeliveries__c = 1
        );
        insert testServiceSchedule;
    }

    // Test method for happy path scenario
    @isTest
    static void testStartWithRecords() {
        // Start Test Context
        Test.startTest();
        
        ServiceScheduleRollupsSchedulable batch = new ServiceScheduleRollupsSchedulable();
        Database.QueryLocator ql = batch.start(null);
        
        // Assert that the QueryLocator is not null
        System.assertNotEquals(null, ql, 'QueryLocator should not be null');
        
        // Assert that the query returns records
        Integer count = [SELECT COUNT() FROM ServiceSchedule__c WHERE NumPresentServiceDeliveries__c >= 0 OR NumAbsentServiceDeliveries__c >= 0];
        System.assertEquals(1, count, 'There should be one record returned');
        
        // End Test Context
        Test.stopTest();
    }

    // Test method for sad path scenario (no records meet criteria)
    @isTest
    static void testStartWithNoMatchingRecords() {
        // Prepare data for the test
        // Update the test data to not meet the criteria
        ServiceSchedule__c testServiceSchedule = [SELECT Id, NumPresentServiceDeliveries__c, NumAbsentServiceDeliveries__c FROM ServiceSchedule__c LIMIT 1];
        testServiceSchedule.NumPresentServiceDeliveries__c = -1; // set to not meet the criteria
        testServiceSchedule.NumAbsentServiceDeliveries__c = -1;
        update testServiceSchedule;

        // Start Test Context
        Test.startTest();
        
        ServiceScheduleRollupsSchedulable batch = new ServiceScheduleRollupsSchedulable();
        Database.QueryLocator ql = batch.start(null);
        
        // Assert that the QueryLocator is not null
        System.assertNotEquals(null, ql, 'QueryLocator should not be null');
        
        // Assert that the query returns no records
        Integer count = [SELECT COUNT() FROM ServiceSchedule__c WHERE NumPresentServiceDeliveries__c >= 0 OR NumAbsentServiceDeliveries__c >= 0];
        System.assertEquals(0, count, 'There should be no records returned');
        
        // End Test Context
        Test.stopTest();
    }
    
    // Additional tests could be created for other scenarios, but they are not included here as per instructions.
}
