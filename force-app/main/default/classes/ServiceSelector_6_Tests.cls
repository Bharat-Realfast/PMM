
@isTest
public class ServiceSelector_6_Tests {
  
    // Test Setup creating required data
    @testSetup
    static void makeData() {
        ServiceSchedule__c schedule = new ServiceSchedule__c(Name = 'Test Schedule');
        insert schedule;
        
        Contact participantContact = new Contact(LastName = 'Doe');
        insert participantContact;
        
        ServiceParticipant__c serviceParticipant = new ServiceParticipant__c(
            ServiceSchedule__c = schedule.Id,
            Contact__c = participantContact.Id
        );
        insert serviceParticipant;
        
        // Assuming no triggers related to these objects, if any, use TriggerHandler.bypass
    }

    // Happy path test
    @isTest
    static void testWithCorrectPermissionsAndExistingParticipants() {
        // Setup
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        Contact expectedContact = [SELECT Id FROM Contact LIMIT 1];

        // Execution
        ServiceSelector serviceSelector = new ServiceSelector();
        List<Id> participantContactIds = serviceSelector.getExistingParticipantContactIdsByScheduleId(schedule.Id);

        // Assertions
        System.assertEquals(1, participantContactIds.size(), 'Should return one participant Id');
        System.assertEquals(expectedContact.Id, participantContactIds[0], 'Participant Id should match expected contact Id');
    }

    // No ServiceParticipants test
    @isTest
    static void testWithNoServiceParticipants() {
        // Setup
        ServiceSchedule__c schedule = new ServiceSchedule__c(Name = 'Empty Schedule');
        insert schedule;

        // Execution
        ServiceSelector serviceSelector = new ServiceSelector();
        List<Id> participantContactIds = serviceSelector.getExistingParticipantContactIdsByScheduleId(schedule.Id);

        // Assertions
        System.assert(participantContactIds.isEmpty(), 'Should return empty list as there are no ServiceParticipants');
    }

    // Invalid ScheduleId test
    @isTest
    static void testWithInvalidScheduleId() {
        // Setup
        Id invalidScheduleId = null;

        // Execution
        ServiceSelector serviceSelector = new ServiceSelector();
        List<Id> participantContactIds = serviceSelector.getExistingParticipantContactIdsByScheduleId(invalidScheduleId);

        // Assertions
        System.assert(participantContactIds.isEmpty(), 'Should return empty list with invalid ScheduleId');
    }
}
