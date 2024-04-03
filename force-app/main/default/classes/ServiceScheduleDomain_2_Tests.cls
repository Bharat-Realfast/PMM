
@isTest
private class ServiceScheduleDomain_2_Tests {

    @testSetup
    static void setupTestData() {
        // Create test data for ServiceSchedule__c
        // If required fields are present, you would set them here
        ServiceSchedule__c testSchedule = new ServiceSchedule__c(
            Name = 'Test Schedule'
            // Add other necessary fields here
        );
        insert testSchedule; // Inserting the test data to be used in update test
    }

    @isTest
    static void testInsertSchedule() {
        // Prepare a new ServiceSchedule__c record for insertion
        ServiceScheduleDomain domain = new ServiceScheduleDomain();
        ServiceSchedule__c newSchedule = new ServiceSchedule__c(
            Name = 'New Schedule'
            // Set other necessary fields here
        );

        Test.startTest();
        domain.upsertSchedule(newSchedule); // This should result in an insert operation
        Test.stopTest();

        // Assertions: Verify insert was successful
        List<ServiceSchedule__c> insertedSchedules = [SELECT Id, Name FROM ServiceSchedule__c WHERE Name = 'New Schedule'];
        System.assertEquals(1, insertedSchedules.size(), 'One new schedule should be inserted.');
        System.assertNotEquals(null, insertedSchedules[0].Id, 'The new schedule should have an Id.');
    }

    @isTest
    static void testUpdateSchedule() {
        // Query the existing ServiceSchedule__c record for update
        ServiceScheduleDomain domain = new ServiceScheduleDomain();
        ServiceSchedule__c existingSchedule = [SELECT Id, Name FROM ServiceSchedule__c LIMIT 1];
        existingSchedule.Name = 'Updated Schedule Name';

        Test.startTest();
        domain.upsertSchedule(existingSchedule); // This should result in an update operation
        Test.stopTest();

        // Assertions: Verify update was successful
        ServiceSchedule__c updatedSchedule = [SELECT Id, Name FROM ServiceSchedule__c WHERE Id = :existingSchedule.Id];
        System.assertEquals('Updated Schedule Name', updatedSchedule.Name, 'The schedule name should be updated.');
    }

    // Additional test methods would be written for the sad paths and exceptional scenarios.
    // These would require mocking or setting up user permissions for testing access control.
    // You would also include testing for null handling, and other edge cases.
}
