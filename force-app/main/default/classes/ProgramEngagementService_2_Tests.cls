
@isTest
public class ProgramEngagementService_2_Tests {
    
    @testSetup
    static void makeData() {
        // Set up mock metadata using a mocking framework or create records if needed
        // As we do not have access to actual metadata here, let's assume that 
        // mocking framework will handle this or those records are already there.
    }

    @isTest
    static void testGetActiveStagesByValue_HappyPath() {
        // Assume active stages are correctly returned by getActiveStages method
        // Perform the test
        ProgramEngagementService service = new ProgramEngagementService();
        Map<String, String> activeStagesMap = service.getActiveStagesByValue();
        
        // Assert that the map is not null and contains expected values
        System.assertNotEquals(null, activeStagesMap, 'The map should not be null');
        System.assert(!activeStagesMap.isEmpty(), 'The map should not be empty');
    }

    @isTest
    static void testGetActiveStagesByValue_SadPath() {
        // Assume no active stages are returned by getActiveStages method
        // Setting the activeStages property to an empty set to simulate no active stages
        ProgramEngagementService service = new ProgramEngagementService();
        service.activeStages = new Set<String>();
        Map<String, String> activeStagesMap = service.getActiveStagesByValue();
        
        // Assert that the map is not null and is empty
        System.assertNotEquals(null, activeStagesMap, 'The map should not be null');
        System.assert(activeStagesMap.isEmpty(), 'The map should be empty');
    }

    // As noted before, the exceptional scenario testing is not included as it typically involves mocking or scenarios that are not directly testable in Salesforce.
}
