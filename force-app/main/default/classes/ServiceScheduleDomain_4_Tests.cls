
@isTest
public class ServiceScheduleDomain_4_Tests {
    // Use @testSetup to create test data
    @testSetup
    static void setupTestData() {
        // Disable account triggers as per project-specific details
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Create test data for engagements and schedule
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Contact testContact = new Contact(LastName = 'Doe', AccountId = testAccount.Id);
        insert testContact;

        ProgramEngagement__c engagement = new ProgramEngagement__c(Contact__c = testContact.Id);
        insert engagement;

        ServiceSchedule__c schedule = new ServiceSchedule__c(Name = 'Test Schedule');
        insert schedule;
    }

    // Happy Path: Inserting participants with valid engagements and schedules
    @isTest
    static void testInsertParticipantsValidData() {
        List<ProgramEngagement__c> engagements = [SELECT Id, Contact__c FROM ProgramEngagement__c];
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];

        ServiceScheduleDomain serviceScheduleDomain = new ServiceScheduleDomain();

        Test.startTest();
        serviceScheduleDomain.insertParticipants(engagements, schedule);
        Test.stopTest();

        List<ServiceParticipant__c> participants = [SELECT Id, ServiceSchedule__c FROM ServiceParticipant__c];
        System.assertEquals(engagements.size(), participants.size(), 'Number of participants should match the number of engagements');
        System.assertEquals(schedule.Id, participants[0].ServiceSchedule__c, 'ServiceSchedule__c should be populated');
    }

    // Sad Path: Inserting participants with an empty list of engagements
    @isTest
    static void testInsertParticipantsEmptyEngagements() {
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];

        ServiceScheduleDomain serviceScheduleDomain = new ServiceScheduleDomain();

        Test.startTest();
        serviceScheduleDomain.insertParticipants(new List<ProgramEngagement__c>(), schedule);
        Test.stopTest();

        List<ServiceParticipant__c> participants = [SELECT Id FROM ServiceParticipant__c];
        System.assertEquals(0, participants.size(), 'No participants should be inserted');
    }

    // Sad Path: Inserting participants when the schedule is null
    @isTest(expectedExceptions = ServiceScheduleDomain.ServiceScheduleDomainException.class)
    static void testInsertParticipantsNullSchedule() {
        List<ProgramEngagement__c> engagements = [SELECT Id FROM ProgramEngagement__c];

        ServiceScheduleDomain serviceScheduleDomain = new ServiceScheduleDomain();
        
        Test.startTest();
        serviceScheduleDomain.insertParticipants(engagements, null);
        Test.stopTest();
    }

    // Exceptional Scenario: Attempt to insert participants when user lacks create access
    @isTest
    static void testInsertParticipantsNoCreateAccess() {
        List<ProgramEngagement__c> engagements = [SELECT Id, Contact__c FROM ProgramEngagement__c];
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];

        // Simulate condition where the user doesn't have create access
        // This is typically done by manipulating the PermissionValidator class
        // As this is project-specific, we assume there's a way to simulate this
        PermissionValidator mockValidator = new PermissionValidator();
        mockValidator.setCreateAccess(false); // This is a hypothetical method
        Test.setMock(PermissionValidator.class, mockValidator);

        ServiceScheduleDomain serviceScheduleDomain = new ServiceScheduleDomain();

        // Assert that an exception is thrown due to lack of access
        Boolean didExceptionOccur = false;
        Test.startTest();
        try {
            serviceScheduleDomain.insertParticipants(engagements, schedule);
        } catch (ServiceScheduleDomain.ServiceScheduleDomainException e) {
            didExceptionOccur = true;
        }
        Test.stopTest();
        
        System.assertTrue(didExceptionOccur, 'An exception should have been thrown due to lack of create access');
    }
}
