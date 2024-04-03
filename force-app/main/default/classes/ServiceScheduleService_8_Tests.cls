
@isTest
private class ServiceScheduleService_8_Tests {

    @testSetup
    static void setup() {
        // Create test data for ServiceSchedule__c and ServiceSession__c
        // Assuming required fields are present on the objects
        ServiceSchedule__c schedule = new ServiceSchedule__c(
            // Initialize necessary fields
        );
        insert schedule;

        // Assuming SessionStart__c is a DateTime field and is a necessary field for ServiceSession__c
        ServiceSession__c sessionBeforeStartDate = new ServiceSession__c(
            ServiceSchedule__c = schedule.Id,
            SessionStart__c = DateTime.now().addDays(-2)
            // Initialize other necessary fields
        );
        ServiceSession__c sessionAfterStartDate = new ServiceSession__c(
            ServiceSchedule__c = schedule.Id,
            SessionStart__c = DateTime.now().addDays(2)
            // Initialize other necessary fields
        );
        insert new List<ServiceSession__c>{ sessionBeforeStartDate, sessionAfterStartDate };
    }

    @isTest
    static void testDeleteSessionsAfter_HappyPath() {
        Test.startTest();
        // Query for the scheduleId from setup data
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        // Set a startDate that is between the sessionBeforeStartDate and sessionAfterStartDate
        Date startDate = Date.today();

        ServiceScheduleService service = new ServiceScheduleService();
        Integer deletedCount = service.deleteSessionsAfter(schedule.Id, startDate);
        Test.stopTest();

        // Assert that one session was deleted, and one remains
        System.assertEquals(1, deletedCount, 'One session should be deleted.');
        Integer remainingSessionCount = [SELECT count() FROM ServiceSession__c WHERE SessionStart__c < :DateTime.now()];
        System.assertEquals(1, remainingSessionCount, 'One session should remain.');
    }

    @isTest
    static void testDeleteSessionsAfter_NoSessionsToDelete() {
        Test.startTest();
        // Query for the scheduleId from setup data
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        // Set a startDate that is after the sessionAfterStartDate
        Date startDate = Date.today().addDays(3);

        ServiceScheduleService service = new ServiceScheduleService();
        Integer deletedCount = service.deleteSessionsAfter(schedule.Id, startDate);
        Test.stopTest();

        // Assert that no sessions are deleted
        System.assertEquals(0, deletedCount, 'No sessions should be deleted.');
    }

    // Note: We do not need to test exception handling for DML operations as this is handled by Salesforce's runtime.
}
