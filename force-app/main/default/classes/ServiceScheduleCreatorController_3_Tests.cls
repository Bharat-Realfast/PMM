
@isTest
private class ServiceScheduleCreatorController_3_Tests {

    @testSetup
    static void makeData() {
        // Create test data for ProgramEngagement__c
        // If there are required fields, please ensure they are populated here.
        ProgramEngagement__c pe = new ProgramEngagement__c();
        insert pe;
    }
    
    @isTest
    static void testGetProgramEngagementByIdHappyPath() {
        // Retrieve the ProgramEngagement__c record inserted in the test setup
        ProgramEngagement__c pe = [SELECT Id FROM ProgramEngagement__c LIMIT 1];

        // Perform the test
        Test.startTest();
        ProgramEngagement__c result = ServiceScheduleCreatorController.getProgramEngagementById(pe.Id);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, result, 'Program Engagement should not be null.');
        System.assertEquals(pe.Id, result.Id, 'The ID should match the Program Engagement record inserted in setup.');
    }
    
    @isTest
    static void testGetProgramEngagementByIdSadPath() {
        // Create a dummy ID that doesn't exist in the org (assuming 'a0W' is the prefix for ProgramEngagement__c objects)
        Id dummyId = Id.valueOf('a0W000000000000AAA');
        
        // Perform the test
        Test.startTest();
        ProgramEngagement__c result = ServiceScheduleCreatorController.getProgramEngagementById(dummyId);
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, result, 'Program Engagement should be null when an invalid ID is provided.');
    }
    
    @isTest
    static void testGetProgramEngagementByIdExceptionalScenario() {
        // Test for handling of a null ID input, which should throw an AuraHandledException
        Boolean didThrowException = false;

        Test.startTest();
        try {
            ServiceScheduleCreatorController.getProgramEngagementById(null);
        } catch (Exception e) {
            didThrowException = true;
            // Check if the exception is of type AuraHandledException
            System.assertEquals(AuraHandledException.class, e.getClass(), 'The exception should be an AuraHandledException.');
        }
        Test.stopTest();
        
        // Confirm that an exception was thrown
        System.assertTrue(didThrowException, 'Passing null ID should throw an exception.');
    }
}
