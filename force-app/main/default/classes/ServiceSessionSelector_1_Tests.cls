
@isTest
public class ServiceSessionSelector_1_Tests {

    @testSetup
    static void makeTestData() {
        // Assuming TriggerHandler is defined in the org, uncomment the following lines:
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Create test data for ServiceSchedule__c
        ServiceSchedule__c testSchedule = new ServiceSchedule__c(
            // Set necessary fields for creating a test record
            Name = 'Test Schedule'
        );
        insert testSchedule;

        // Create future ServiceSession__c records associated with ServiceSchedule__c
        ServiceSession__c futureSession = new ServiceSession__c(
            ServiceSchedule__c = testSchedule.Id,
            SessionStart__c = System.today().addDays(1), // Future date
            Name = 'Future Service Session'
            // Set other necessary fields
        );
        insert futureSession;

        // Create past ServiceSession__c records (not returned by target method)
        ServiceSession__c pastSession = new ServiceSession__c(
            ServiceSchedule__c = testSchedule.Id,
            SessionStart__c = System.today().addDays(-1), // Past date
            Name = 'Past Service Session'
            // Set other necessary fields
        );
        insert pastSession;
    }

    @isTest
    static void shouldReturnFutureServiceSessions() {
        ServiceSchedule__c testSchedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        List<ServiceSession__c> sessions;

        Test.startTest();
        ServiceSessionSelector selector = new ServiceSessionSelector();
        sessions = selector.getFutureServiceSessionsForServiceSchedule(testSchedule.Id);
        Test.stopTest();

        System.assertEquals(1, sessions.size(), 'One future session should be returned.');
        System.assert(sessions[0].SessionStart__c > System.today(), 'Returned session should have a start date in the future.');
    }

    @isTest
    static void shouldReturnEmptyListWhenNoFutureSessionsExist() {
        ServiceSchedule__c testSchedule = new ServiceSchedule__c(
            // Set necessary fields
            Name = 'Test Schedule Without Future Sessions'
        );
        insert testSchedule;
        List<ServiceSession__c> sessions;

        Test.startTest();
        ServiceSessionSelector selector = new ServiceSessionSelector();
        sessions = selector.getFutureServiceSessionsForServiceSchedule(testSchedule.Id);
        Test.stopTest();

        System.assertEquals(0, sessions.size(), 'No sessions should be returned for schedules without future sessions.');
    }

    @isTest
    static void shouldReturnEmptyListWhenNoAccessToServiceSession() {
        ServiceSchedule__c testSchedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        List<ServiceSession__c> sessions;

        // Simulate running as a User with no access to ServiceSession__c
        // For the purpose of this example, assuming 'Standard User' profile has no access
        Profile standardProfile = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        User noAccessUser = new User(
            Alias = 'noaccess',
            Email='noaccessuser@test.com',
            EmailEncodingKey='UTF-8',
            LastName='Test',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            ProfileId = standardProfile.Id,
            TimeZoneSidKey='America/Los_Angeles',
            UserName='noaccessuser@test.com'
            // Set other necessary User fields
        );
        insert noAccessUser;

        System.runAs(noAccessUser) {
            Test.startTest();
            ServiceSessionSelector selector = new ServiceSessionSelector();
            sessions = selector.getFutureServiceSessionsForServiceSchedule(testSchedule.Id);
            Test.stopTest();
        }

        System.assertEquals(0, sessions.size(), 'No sessions should be returned when user has no access to ServiceSession__c.');
    }
}
