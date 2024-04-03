
@isTest
private class ServiceScheduleCreatorController_10_Tests {

    @testSetup
    static void setupTestData() {
        // Setup test data - create a ServiceSchedule__c record and associated ServiceSession__c records
        // Be sure to create some ServiceSession__c records before and after the startDate
        // Example of creating a ServiceSchedule__c record
        // Insert schedule and sessions according to your SObject structure

        // Note: Adjust your SObject and fields as per your Org's schema
    }

    @isTest
    static void testDeleteSessionsWithExistingSessionsAfterStartDate() {
        // Arrange
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Assuming 'makeData' method creates the required test data
        Id scheduleId = // [TODO: set scheduleId from test data];
        Date startDate = // [TODO: set startDate where sessions exist after this date];

        // Act
        Integer result = ServiceScheduleCreatorController.deleteSessionsAfter(scheduleId, startDate);

        // Assert
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertEquals(/*expected number of deletions*/, result, 'Incorrect number of sessions deleted.');
    }

    @isTest
    static void testDeleteSessionsWithNoSessionsAfterStartDate() {
        // Arrange
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Assuming 'makeData' method creates the required test data
        Id scheduleId = // [TODO: set scheduleId from test data];
        Date startDate = // [TODO: set startDate where no sessions exist after this date];

        // Act
        Integer result = ServiceScheduleCreatorController.deleteSessionsAfter(scheduleId, startDate);

        // Assert
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertEquals(0, result, 'There should be no sessions deleted.');
    }

    @isTest
    static void testDeleteSessionsWithNullScheduleId() {
        // Arrange
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Date startDate = Date.today();

        // Act
        Integer result = ServiceScheduleCreatorController.deleteSessionsAfter(null, startDate);

        // Assert
        System.assertEquals(0, result, 'Result should be 0 when scheduleId is null.');
    }

    @isTest
    static void testDeleteSessionsWithNullStartDate() {
        // Arrange
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Assuming 'makeData' method creates the required test data
        Id scheduleId = // [TODO: set scheduleId from test data];

        // Act
        Integer result = ServiceScheduleCreatorController.deleteSessionsAfter(scheduleId, null);

        // Assert
        System.assertEquals(0, result, 'Result should be 0 when startDate is null.');
    }

    @isTest
    static void testDeleteSessionsExceptionScenario() {
        // Arrange
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Assuming 'makeData' method creates the required test data
        Id scheduleId = // [TODO: set scheduleId from test data];
        Date startDate = // [TODO: set startDate to a value that causes an exception];

        // Act and Assert
        Boolean isExceptionThrown = false;
        try {
            Integer result = ServiceScheduleCreatorController.deleteSessionsAfter(scheduleId, startDate);
        } catch (Exception e) {
            isExceptionThrown = true;
            System.assert(e instanceof AuraHandledException, 'The exception should be of type AuraHandledException.');
        }
        System.assertTrue(isExceptionThrown, 'Expected an AuraHandledException to be thrown.');
    }
}
