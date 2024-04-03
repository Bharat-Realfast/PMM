
@isTest
private class ServiceSelector_5_Tests {

    @testSetup
    static void setupTestData() {
        // Create test data for ServiceSchedule__c
        ServiceSchedule__c schedule = new ServiceSchedule__c(
            Name = 'Test Schedule'
            // Set other necessary fields
        );
        // Insert the schedule record without any trigger handler bypassing
        insert schedule;
    }
    
    @isTest
    static void testGetScheduleByIdHappyPath() {
        // Retrieve the test data
        ServiceSchedule__c testSchedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        
        // Instantiate the selector class
        ServiceSelector selector = new ServiceSelector();
        
        // Call the target method and assert the result
        ServiceSchedule__c result = selector.getScheduleById(testSchedule.Id);
        
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(testSchedule.Id, result.Id, 'The schedule ID should match the test data.');
    }
    
    @isTest
    static void testGetScheduleByIdSadPath() {
        // Generate a random ID that does not exist
        Id nonexistentId = generateNonExistingId(ServiceSchedule__c.SObjectType);
        
        // Instantiate the selector class
        ServiceSelector selector = new ServiceSelector();
        
        // Call the target method and assert the result
        ServiceSchedule__c result = selector.getScheduleById(nonexistentId);
        
        System.assertEquals(null, result.Id, 'The result should have a null ID for a non-existent ID.');
    }
    
    // Utility method to generate a non-existing record ID
    private static Id generateNonExistingId(Schema.SObjectType sObjType) {
        String keyPrefix = sObjType.getDescribe().getKeyPrefix();
        String uniqueSuffix = '1234567890123'.left(12 - keyPrefix.length());
        return Id.valueOf(keyPrefix + uniqueSuffix);
    }
}
