
@isTest
private class ProgramEngagementSelector_4_Tests {

    @testSetup
    static void setupTestData() {
        // Create test program
        Program__c testProgram = new Program__c(Name = 'Test Program');
        insert testProgram;

        // Create test engagements
        List<ProgramEngagement__c> engagements = new List<ProgramEngagement__c>();
        for (Integer i = 0; i < 10; i++) {
            engagements.add(new ProgramEngagement__c(
                Program__c = testProgram.Id,
                Name = 'Engagement ' + i,
                Stage__c = (Math.mod(i, 2) == 0) ? 'Active' : 'Inactive'
            ));
        }
        insert engagements;
    }

    static void preparePermissionMocks() {
        // Mock permission checks within the PermissionValidator to return true for the sake of unit tests.
        // This step assumes that PermissionValidator can be mocked, which might require altering the production code for testability.
    }

    @isTest
    static void testGetProgramEngagementsByValidProgramId() {
        preparePermissionMocks();

        // Assuming TriggerHandler is available in the org, otherwise comment out or remove the following lines
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');

        Test.startTest();
        ProgramEngagementSelector selector = new ProgramEngagementSelector();
        Program__c testProgram = [SELECT Id FROM Program__c LIMIT 1];
        List<ProgramEngagement__c> engagements = selector.getProgramEngagementsByProgramId(
            testProgram.Id,
            new Set<String>{'Id', 'Name', 'Stage__c'},
            new Set<String>{'Active'},
            '',
            null
        );
        Test.stopTest();

        System.assertNotEquals(null, engagements, 'Engagements list should not be null.');
        System.assertEquals(5, engagements.size(), 'There should be 5 active engagements for the test program.');
    }

    @isTest
    static void testGetProgramEngagementsByInvalidProgramId() {
        preparePermissionMocks();

        // Assuming TriggerHandler is available in the org, otherwise comment out or remove the following lines
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');

        Test.startTest();
        ProgramEngagementSelector selector = new ProgramEngagementSelector();
        List<ProgramEngagement__c> engagements = selector.getProgramEngagementsByProgramId(
            'InvalidId',
            new Set<String>{'Id', 'Name', 'Stage__c'},
            new Set<String>{'Active'},
            '',
            null
        );
        Test.stopTest();

        System.assertEquals(0, engagements.size(), 'No engagements should be returned for an invalid program ID.');
    }

    // Additional test methods could be added to verify behavior with different stages, search text, cohortId, etc.
}
