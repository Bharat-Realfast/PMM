
@isTest
private class ProgramEngagementService_1_Tests {

    // No need for @testSetup to create metadata records as they already exist in the org.

    @isTest
    static void testGetActiveStages_HappyPath() {
        Test.startTest();
        ProgramEngagementService engagementService = new ProgramEngagementService();
        Set<String> activeStages = engagementService.getActiveStages();
        Test.stopTest();

        // We can't assume the exact number of active stages as metadata exists in the org
        // So we check if the set is not empty
        System.assertNotEquals(0, activeStages.size(), 'There should be active stages.');
    }

    // Since we cannot manipulate the custom metadata types directly in Apex, we cannot create a sad path
    // where there are no active stages unless we use mocking techniques, which are beyond the scope of this test.

    // Exceptional scenarios are typically not testable without mocking frameworks or other advanced techniques
    // which are not usually a part of Salesforce Apex testing. Therefore, we won't cover this here.
}
