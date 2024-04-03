
@isTest
private class ServiceScheduleService_3_Tests {

    // Test the happy path scenario
    @isTest
    static void testGetExistingParticipantContactIdsHappyPath() {
        // Instantiate the class and invoke the method
        Id mockScheduleId = 'a0X1N00000cXYZUUA4'; // Example mock ID. Replace with actual test setup ID.
        ServiceScheduleService service = new ServiceScheduleService();
        List<Id> participantIds = service.getExistingParticipantContactIds(mockScheduleId);
        
        // Perform assertions
        System.assertNotEquals(null, participantIds, 'The list should not be null.');
        System.assert(participantIds.size() > 0, 'The list should have participants.');
    }

    // Test the sad path scenario
    @isTest
    static void testGetExistingParticipantContactIdsSadPath() {
        // Instantiate the class and invoke the method
        Id mockScheduleId = 'a0X1N00000cXYZVUA4'; // Example mock ID with no participants. Replace with actual test setup ID.
        ServiceScheduleService service = new ServiceScheduleService();
        List<Id> participantIds = service.getExistingParticipantContactIds(mockScheduleId);
        
        // Perform assertions
        System.assertNotEquals(null, participantIds, 'The list should not be null.');
        System.assertEquals(0, participantIds.size(), 'The list should be empty.');
    }

    // Test the exceptional scenario
    @isTest
    static void testGetExistingParticipantContactIdsExceptional() {
        // Instantiate the class and invoke the method
        ServiceScheduleService service = new ServiceScheduleService();
        List<Id> participantIds = service.getExistingParticipantContactIds(null);
        
        // Perform assertions
        System.assertEquals(new List<Id>(), participantIds, 'The list should be empty when passing a null ServiceSchedule Id.');
    }
}
