
@isTest
private class ProgramSelector_1_Tests {

    @testSetup
    static void setupTestData() {
        // Assuming that Program__c is a parent object of ProgramCohort__c
        Program__c testProgram = new Program__c(Name='Test Program');
        insert testProgram;

        // Create an active ProgramCohort__c record
        ProgramCohort__c activeCohort = new ProgramCohort__c(
            Program__c = testProgram.Id,
            Status__c = 'Active'
        );
        insert activeCohort;

        // Create an inactive ProgramCohort__c record
        ProgramCohort__c inactiveCohort = new ProgramCohort__c(
            Program__c = testProgram.Id,
            Status__c = 'Inactive'
        );
        insert inactiveCohort;
    }

    @isTest
    static void testGetProgramCohortsFromProgramId_WithActiveCohorts() {
        Test.startTest();
        Id testProgramId = [SELECT Id FROM Program__c LIMIT 1].Id;
        ProgramSelector programSelector = new ProgramSelector();
        List<ProgramCohort__c> result = programSelector.getProgramCohortsFromProgramId(testProgramId);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assert(result.size() > 0, 'At least one active cohort should be returned');
    }

    @isTest
    static void testGetProgramCohortsFromProgramId_NoActiveCohorts() {
        Test.startTest();
        Id testProgramId = [SELECT Id FROM Program__c LIMIT 1].Id;
        ProgramSelector programSelector = new ProgramSelector();
        List<ProgramCohort__c> result = programSelector.getProgramCohortsFromProgramId(testProgramId);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(0, result.size(), 'No active cohorts should be returned');
    }

    @isTest
    static void testGetProgramCohortsFromProgramId_NullProgramId() {
        Test.startTest();
        ProgramSelector programSelector = new ProgramSelector();
        List<ProgramCohort__c> result = programSelector.getProgramCohortsFromProgramId(null);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(0, result.size(), 'No cohorts should be returned for null programId');
    }
}
