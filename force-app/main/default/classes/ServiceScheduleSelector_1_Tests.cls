
@isTest
private class ServiceScheduleSelector_1_Tests {

    @testSetup
    static void setupTestData() {
        // Create a ServiceSchedule__c record
        ServiceSchedule__c serviceSchedule = new ServiceSchedule__c(
            // Initialize required fields here
        );
        insert serviceSchedule;
    }

    @isTest
    static void testGetServiceScheduleFromValidId() {
        // Retrieve the test data
        ServiceSchedule__c expectedSchedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];

        // Execute the method with a valid ID
        ServiceScheduleSelector selector = new ServiceScheduleSelector();
        ServiceSchedule__c actualSchedule = selector.getServiceScheduleFromId(expectedSchedule.Id);

        // Perform the assertions
        System.assertNotEquals(null, actualSchedule, 'The service schedule should not be null');
        System.assertEquals(expectedSchedule.Id, actualSchedule.Id, 'The retrieved record should have the same ID');
    }

    @isTest
    static void testGetServiceScheduleFromInvalidId() {
        // Use an arbitrary ID that doesn't exist
        Id invalidId = Schema.SObjectType.Account.getKeyPrefix() + '00000000000XYZ';

        // Execute the method with an invalid ID
        ServiceScheduleSelector selector = new ServiceScheduleSelector();
        ServiceSchedule__c actualSchedule = selector.getServiceScheduleFromId(invalidId);

        // Perform the assertions
        System.assertEquals(null, actualSchedule, 'The service schedule should be null for an invalid ID');
    }

    // Note: Simulating permission denial is not straightforward and depends on the project-specific details.
    // The `testPermissionDenied` method is omitted until a viable way to simulate or mock permission checks is available.
}
