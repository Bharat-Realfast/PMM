
@isTest
private class ProgramService_2_Tests {

    @testSetup
    static void makeTestData() {
        // Assuming 'Program__c' and 'ProgramCohort__c' are custom objects
        Program__c testProgram = new Program__c(Name = 'Test Program');
        insert testProgram;

        ProgramCohort__c testCohort = new ProgramCohort__c(Program__c = testProgram.Id, Name = 'Test Cohort');
        insert testCohort;
    }

    @isTest
    static void testGetProgramCohortsWithValidId() {
        // Assuming there is a way to bypass triggers using the framework provided
        // Note: The actual implementation will depend on the framework used in the project

        Test.startTest();
        // Retrieve test data
        Program__c testProgram = [SELECT Id FROM Program__c LIMIT 1];

        // Instantiate the class and call the method
        ProgramService service = new ProgramService();
        List<ProgramCohort__c> cohorts = service.getProgramCohortsFromProgramId(testProgram.Id);

        // Assertions
        System.assertNotEquals(null, cohorts, 'Cohorts should not be null');
        System.assertEquals(1, cohorts.size(), 'There should be one cohort associated with the test program');
        Test.stopTest();
    }

    @isTest
    static void testGetProgramCohortsWithNoRelatedCohorts() {
        // Assuming there is a way to bypass triggers using the framework provided
        // Note: The actual implementation will depend on the framework used in the project

        Test.startTest();
        // Assume there is a dummy ID which will not have any related cohorts
        Id dummyProgramId = '000000000000000AAA'; // Dummy Id for the sake of the test

        // Instantiate the class and call the method
        ProgramService service = new ProgramService();
        List<ProgramCohort__c> cohorts = service.getProgramCohortsFromProgramId(dummyProgramId);

        // Assertions
        System.assertNotEquals(null, cohorts, 'Cohorts should not be null even if there are no related cohorts');
        System.assertEquals(0, cohorts.size(), 'There should be no cohorts associated with the dummy program');
        Test.stopTest();
    }

    @isTest
    static void testGetProgramCohortsWithInvalidId() {
        // Assuming there is a way to bypass triggers using the framework provided
        // Note: The actual implementation will depend on the framework used in the project

        Test.startTest();
        // Instantiate the class and call the method with a null ID
        ProgramService service = new ProgramService();

        Exception expectedException;
        try {
            List<ProgramCohort__c> cohorts = service.getProgramCohortsFromProgramId(null);
        } catch (Exception e) {
            expectedException = e;
        }

        // Assertions
        System.assertNotEquals(null, expectedException, 'An exception should have been thrown for null ID');
        Test.stopTest();
    }
}
