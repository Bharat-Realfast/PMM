
@isTest
private class ServiceScheduleService_5_Tests {

    @testSetup
    static void makeTestData() {
        // Create test ServiceSchedule__c record
        ServiceSchedule__c testSchedule = new ServiceSchedule__c(
            // set necessary fields
        );
        insert testSchedule;
        
        // Create test ProgramEngagement__c records related to the ServiceSchedule__c
        ProgramEngagement__c testEngagement = new ProgramEngagement__c(
            // set necessary fields, including a lookup to the testSchedule
        );
        insert testEngagement;
    }
    
    private static void commonTestSetup() {
        // Replace with actual logic for bypassing triggers in your project
        // e.g., TriggerHandler.bypass('AccountTriggerHandler');
    }

    @isTest
    static void testAddParticipantsHappyPath() {
        commonTestSetup();
        // Get test data
        ServiceSchedule__c testSchedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        List<ProgramEngagement__c> testEngagements = [SELECT Id FROM ProgramEngagement__c LIMIT 1];
        
        // Instantiate the service and call the target method
        ServiceScheduleService service = new ServiceScheduleService();
        Test.startTest();
        service.addParticipants(testEngagements, testSchedule.Id);
        Test.stopTest();
        
        // Assertions
        List<ServiceParticipant__c> participants = [SELECT Id FROM ServiceParticipant__c WHERE ServiceSchedule__c = :testSchedule.Id];
        System.assertEquals(1, participants.size(), 'One participant should have been added.');
    }
    
    @isTest
    static void testAddParticipantsSadPathWithEmptyList() {
        commonTestSetup();
        ServiceSchedule__c testSchedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        
        // Instantiate the class and call the method with an empty list
        ServiceScheduleService service = new ServiceScheduleService();
        Test.startTest();
        service.addParticipants(new List<ProgramEngagement__c>(), testSchedule.Id);
        Test.stopTest();
        
        // Assertions
        List<ServiceParticipant__c> participants = [SELECT Id FROM ServiceParticipant__c WHERE ServiceSchedule__c = :testSchedule.Id];
        System.assert(participants.isEmpty(), 'No participants should be added for an empty engagements list.');
    }
    
    @isTest
    static void testAddParticipantsSadPathWithNullScheduleId() {
        commonTestSetup();
        List<ProgramEngagement__c> testEngagements = [SELECT Id FROM ProgramEngagement__c LIMIT 1];
        
        // Instantiate the class and call the method with a null scheduleId
        ServiceScheduleService service = new ServiceScheduleService();
        Test.startTest();
        service.addParticipants(testEngagements, null);
        Test.stopTest();
        
        // Assertions
        List<ServiceParticipant__c> participants = [SELECT Id FROM ServiceParticipant__c];
        System.assert(participants.isEmpty(), 'No participants should be added when scheduleId is null.');
    }
    
    @isTest
    static void testAddParticipantsExceptionalScenario() {
        commonTestSetup();
        ServiceSchedule__c testSchedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        List<ProgramEngagement__c> testEngagements = [SELECT Id FROM ProgramEngagement__c LIMIT 1];
        
        // Force an exceptional scenario, such as inserting a participant with a required field missing
        
        // Insert a participant without setting a required field
        ServiceParticipant__c participant = new ServiceParticipant__c(
            // Set necessary fields, except for the required one to trigger the exception
        );
        
        // Try to insert the participant to simulate the exception
        Boolean exceptionThrown = false;
        Test.startTest();
        try {
            insert participant;
        } catch (DmlException e) {
            exceptionThrown = true;
        }
        Test.stopTest();
        
        System.assert(exceptionThrown, 'An exception should have been thrown due to missing required field.');
    }
}
