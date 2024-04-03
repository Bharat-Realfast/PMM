
@isTest
private class ProgramController_1_Tests {

    @testSetup
    static void setup() {
        // Create test data for Program__c and related ProgramCohort__c records
        Program__c testProgram = new Program__c(Name = 'Test Program');
        insert testProgram;
        
        ProgramCohort__c testCohort = new ProgramCohort__c(Name = 'Test Cohort', Program__c = testProgram.Id);
        insert testCohort;
    }

    private static void bypassTriggersForTest() {
        // Bypass trigger framework is assumed to be part of this project as per the instructions.
        // The actual implementation details of this method are not provided; it's based on the assumption.
        // If the sfdc-trigger-framework is not available, this method will need to be adjusted accordingly.
    }

    @isTest
    static void testGetProgramCohortsFromValidProgramId() {
        bypassTriggersForTest();
        
        Program__c testProgram = [SELECT Id FROM Program__c LIMIT 1];
        Test.startTest();
        List<ProgramCohort__c> cohorts = ProgramController.getProgramCohortsFromProgramId(testProgram.Id);
        Test.stopTest();
        
        System.assertNotEquals(null, cohorts, 'Cohorts should not be null');
        System.assertEquals(1, cohorts.size(), 'There should be one cohort associated with the program');
    }

    @isTest
    static void testGetProgramCohortsFromInvalidProgramId() {
        bypassTriggersForTest();
        
        Id fakeProgramId = Id.valueOf('a045000000XxxxxXXX');
        Test.startTest();
        List<ProgramCohort__c> cohorts = ProgramController.getProgramCohortsFromProgramId(fakeProgramId);
        Test.stopTest();
        
        System.assertNotEquals(null, cohorts, 'Cohorts should not be null');
        System.assertEquals(0, cohorts.size(), 'There should be no cohorts associated with the fake program');
    }

    @isTest
    static void testGetProgramCohortsExceptionHandling() {
        bypassTriggersForTest();
        
        try {
            Test.startTest();
            List<ProgramCohort__c> cohorts = ProgramController.getProgramCohortsFromProgramId(null);
            Test.stopTest();
            System.assert(false, 'An exception should have been thrown');
        } catch (Exception ex) {
            System.assert(ex instanceof AuraHandledException, 'The exception should be an AuraHandledException');
        }
    }
}
