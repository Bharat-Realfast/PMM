
@isTest
private class ProgramEngagementService_3_Tests {

    @testSetup
    static void setup() {
        // Create test data for ProgramEngagement__c
        ProgramEngagement__c pe = new ProgramEngagement__c();
        // Set required fields for ProgramEngagement__c
        // pe.Field__c = 'value'; // Uncomment and use actual field names and values
        insert pe;
    }

    @isTest
    static void testGetProgramEngagementByIdWithValidId() {
        // Fetch the test record created in the test setup
        ProgramEngagement__c testPE = [SELECT Id FROM ProgramEngagement__c LIMIT 1];
        
        // Create an instance of the service class
        ProgramEngagementService service = new ProgramEngagementService();
        
        // Call the target method with a valid ID
        ProgramEngagement__c result = service.getProgramEngagementById(testPE.Id);

        // Assertions
        System.assertNotEquals(null, result, 'The result should not be null for a valid ID.');
        System.assertEquals(testPE.Id, result.Id, 'The ID of the result should match the test record ID.');
    }

    @isTest
    static void testGetProgramEngagementByIdWithInvalidId() {
        // Generate a random ID that does not correspond to any record
        Id fakeId = Id.valueOf('a0Q000000000001AAA'); // Sample Id format for ProgramEngagement__c
        
        // Create an instance of the service class
        ProgramEngagementService service = new ProgramEngagementService();
        
        // Call the target method with an invalid ID
        ProgramEngagement__c result = service.getProgramEngagementById(fakeId);

        // Assertions
        System.assertEquals(null, result, 'The result should be null for an invalid ID.');
    }

    @isTest
    static void testGetProgramEngagementByIdWithNullId() {
        // Create an instance of the service class
        ProgramEngagementService service = new ProgramEngagementService();
        
        // Call the target method with null ID
        ProgramEngagement__c result = service.getProgramEngagementById(null);

        // Assertion
        System.assertEquals(null, result, 'The result should be null when the ID passed is null.');
    }
}
