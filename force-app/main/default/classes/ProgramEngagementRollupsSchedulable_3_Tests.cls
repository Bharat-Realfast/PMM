
@isTest
private class StripInaccessibleRecipes_2_Tests {

    @testSetup
    static void setupTestData() {
        // Setup test data for the scope of the test
    }

    @isTest
    static void testStartMethod() {
        // Instantiate the batch class
        ProgramEngagementRollupsSchedulable batchInstance = new ProgramEngagementRollupsSchedulable();

        // Call the start method and capture the result
        Database.QueryLocator queryLocator = batchInstance.start(null);

        // Assert that a non-null QueryLocator is returned
        System.assertNotEquals(null, queryLocator, 'The start method should return a non-null QueryLocator.');
    }
}
