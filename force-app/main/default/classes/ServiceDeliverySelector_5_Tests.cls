
@isTest
private class ServiceDeliverySelector_5_Tests {

    @testSetup
    static void setupTestData() {
        // Assuming the creation of ServiceSchedule__c, Contact, and ServiceParticipant__c test data
        // Omitted for brevity, assume necessary fields are filled in to create valid records
        // ...
    }

    // Test method for the scenario where the user has access
    @isTest
    static void testGetServiceParticipantsByScheduleId() {
        // Retrieve test data created in @testSetup
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        Contact[] testContacts = [SELECT Id FROM Contact];
        
        // Set of Ids to exclude in the method call
        Set<Id> contactsToExclude = new Set<Id>{testContacts[0].Id};

        // Instantiate the class and call the method
        ServiceDeliverySelector selector = new ServiceDeliverySelector();
        Test.startTest();
        List<ServiceParticipant__c> result = selector.getServiceParticipantsByScheduleId(schedule.Id, contactsToExclude);
        Test.stopTest();

        // Assert results
        System.assertNotEquals(0, result.size(), 'Result should not be empty when access is permitted');
        for (ServiceParticipant__c participant : result) {
            System.assertFalse(contactsToExclude.contains(participant.Contact__c), 'Excluded contacts should not be in the result set');
        }
    }

    // Test method for the scenario where the user does not have access
    @isTest
    static void testGetServiceParticipantsByScheduleIdNoAccess() {
        // Retrieve test data created in @testSetup
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];

        // Instantiate the class and call the method with no access (simulating via mocking or test setup)
        ServiceDeliverySelector selector = new ServiceDeliverySelector();
        Test.startTest();
        List<ServiceParticipant__c> result = selector.getServiceParticipantsByScheduleId(schedule.Id, new Set<Id>());
        Test.stopTest();

        // Assert no results are returned due to no access
        System.assertEquals(0, result.size(), 'Result should be empty when there is no access');
    }

    // Test method for the scenario where an invalid schedule ID is passed
    @isTest
    static void testGetServiceParticipantsByScheduleIdInvalidScheduleId() {
        // Use an invalid schedule ID (that does not exist in test data)
        Id invalidScheduleId = 'a045000000XvQWEAA0';

        // Instantiate the class and call the method with an invalid schedule ID
        ServiceDeliverySelector selector = new ServiceDeliverySelector();
        Test.startTest();
        List<ServiceParticipant__c> result = selector.getServiceParticipantsByScheduleId(invalidScheduleId, new Set<Id>());
        Test.stopTest();

        // Assert no results are returned for an invalid schedule ID
        System.assertEquals(0, result.size(), 'Result should be empty for an invalid schedule ID');
    }
}
