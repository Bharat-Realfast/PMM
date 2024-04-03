
@isTest
private class ServiceScheduleSelector_2_Tests {

    @testSetup
    static void setupTestData() {
        // Create test data for ServiceSchedule__c
        ServiceSchedule__c testSchedule = new ServiceSchedule__c(
            // Populate necessary fields for ServiceSchedule__c record
        );
        insert testSchedule;
    }
    
    @isTest
    static void testWithProperAccessAndValidIds() {
        // Setup
        Set<Id> testIds = new Set<Id>{[SELECT Id FROM ServiceSchedule__c LIMIT 1].Id};

        Test.startTest();
        // Exercise
        List<ServiceSchedule__c> schedules = new ServiceScheduleSelector().getServiceSchedulesFromId(testIds);
        Test.stopTest();

        // Verify
        System.assertEquals(1, schedules.size(), 'Should return one schedule');
        System.assertEquals(testIds.iterator().next(), schedules[0].Id, 'Returned schedule should have the same ID as the test record');
    }
    
    @isTest
    static void testWithProperAccessAndNoMatchingIds() {
        // Setup
        Set<Id> testIds = new Set<Id>{};

        Test.startTest();
        // Exercise
        List<ServiceSchedule__c> schedules = new ServiceScheduleSelector().getServiceSchedulesFromId(testIds);
        Test.stopTest();

        // Verify
        System.assertEquals(0, schedules.size(), 'Should return an empty list');
    }
    
    @isTest
    static void testWithNullInput() {
        Test.startTest();
        // Exercise
        List<ServiceSchedule__c> schedules = new ServiceScheduleSelector().getServiceSchedulesFromId(null);
        Test.stopTest();

        // Verify
        System.assertNotEquals(null, schedules, 'Should not return null');
        System.assertEquals(0, schedules.size(), 'Should return an empty list');
    }
}
