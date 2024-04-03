
@isTest
public class ServiceScheduleCreatorController_7_Tests {
    
    // Create custom test data for the unit tests
    @testSetup
    static void makeTestData() {
        // Assuming ServiceSchedule__c and Contact are standard or custom objects with standard 'Name' and 'LastName' fields
        
        // Insert a test ServiceSchedule__c record
        ServiceSchedule__c testSchedule = new ServiceSchedule__c(Name = 'Test Schedule');
        insert testSchedule;

        // Insert a test Contact record
        Contact testContact = new Contact(LastName = 'TestContact', Email = 'testcontact@example.com');
        insert testContact;

        // Insert a test ScheduleParticipant__c record assuming ScheduleParticipant__c is a junction object between ServiceSchedule__c and Contact
        // Replace 'ServiceScheduleLookup__c' and 'ContactLookup__c' with the actual API names of the lookup fields on ScheduleParticipant__c
        ScheduleParticipant__c scheduleParticipant = new ScheduleParticipant__c(
            ServiceScheduleLookup__c = testSchedule.Id,
            ContactLookup__c = testContact.Id
        );
        insert scheduleParticipant;
    }

    @isTest
    static void testWithExistingParticipants() {
        // Retrieve the inserted test records
        ServiceSchedule__c testSchedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        
        // Begin test execution context
        Test.startTest();
        // Call the target method and capture the output
        List<Id> participantIds = ServiceScheduleCreatorController.getExistingParticipantContactIds(testSchedule.Id);
        // End test execution context
        Test.stopTest();
        
        // Assert that the method returns the expected number of participant IDs
        System.assertEquals(1, participantIds.size(), 'Should return one participant Id');
        System.assertNotEquals(null, participantIds[0], 'Participant Id should not be null');
    }

    @isTest
    static void testWithNoParticipants() {
        // Insert a new test ServiceSchedule__c record with no associated participants
        ServiceSchedule__c testScheduleNoPart = new ServiceSchedule__c(Name = 'Schedule without Participants');
        insert testScheduleNoPart;

        // Begin test execution context
        Test.startTest();
        // Call the target method and capture the output
        List<Id> participantIds = ServiceScheduleCreatorController.getExistingParticipantContactIds(testScheduleNoPart.Id);
        // End test execution context
        Test.stopTest();
        
        // Assert that the method returns an empty list for a schedule with no participants
        System.assertEquals(0, participantIds.size(), 'Should return an empty list for no participants');
    }

    @isTest
    static void testWithNullScheduleId() {
        // Begin test execution context
        Test.startTest();
        // Attempt to call the target method with a null parameter and expect an exception
        try {
            List<Id> participantIds = ServiceScheduleCreatorController.getExistingParticipantContactIds(null);
            System.assert(false, 'An exception was expected but not thrown.');
        } catch (Exception e) {
            // End test execution context inside the catch block to ensure Test.stopTest() is called
            Test.stopTest();
            // Assert that the caught exception is an instance of AuraHandledException
            System.assert(e instanceof AuraHandledException, 'An AuraHandledException was expected.');
        }
    }
}
