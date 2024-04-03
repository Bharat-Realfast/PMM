
@isTest
private class ServiceScheduleCreatorController_5_Tests {

    // Test method for the happy path scenario where getActiveStages returns a non-empty map
    @isTest
    static void testGetActiveStagesHappyPath() {
        // Given: In a real application, we would potentially mock the service call. Here we assume the map is non-empty.

        // When: Invoke the method to be tested
        Test.startTest();
        Map<String, String> activeStages = ServiceScheduleCreatorController.getActiveStages();
        Test.stopTest();

        // Then: Verify the result is not null and contains data
        System.assertNotEquals(null, activeStages, 'The active stages map should not be null.');
        System.assert(activeStages.size() > 0, 'The active stages map should have at least one entry.');
    }
}
