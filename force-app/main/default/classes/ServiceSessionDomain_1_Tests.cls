
@isTest
private class ServiceSessionDomain_1_Tests {

    @testSetup
    static void setup() {
        // Create test data required for the tests
        ServiceSession__c testServiceSession = new ServiceSession__c(
            // Initialize necessary fields for the test record
        );
        insert testServiceSession;
    }

    @isTest
    static void testUpdateServiceSessionWithPermission() {
        // Assume permission validation is successful
        ServiceSession__c sessionToUpdate = [SELECT Id, OmittedContactIds__c FROM ServiceSession__c LIMIT 1];
        sessionToUpdate.OmittedContactIds__c = 'TestValue';

        // Bypass triggers if necessary
        // Assume these methods exist in the actual project codebase
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');

        Test.startTest();
        // Instantiate the class and call the method
        ServiceSessionDomain domain = new ServiceSessionDomain();
        domain.updateServiceSession(sessionToUpdate);
        Test.stopTest();

        // Verify that the record was updated
        ServiceSession__c updatedSession = [SELECT Id, OmittedContactIds__c FROM ServiceSession__c WHERE Id = :sessionToUpdate.Id];
        System.assertEquals('TestValue', updatedSession.OmittedContactIds__c, 'The session should have the new OmittedContactIds__c value.');
    }

    @isTest
    static void testUpdateServiceSessionWithoutPermission() {
        // Assume permission validation will fail
        ServiceSession__c sessionToUpdate = [SELECT Id, OmittedContactIds__c FROM ServiceSession__c LIMIT 1];
        sessionToUpdate.OmittedContactIds__c = 'TestValue';

        // Bypass triggers if necessary
        // Assume these methods exist in the actual project codebase
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');

        Boolean exceptionThrown = false;
        Test.startTest();
        // Instantiate the class and call the method expecting an exception
        ServiceSessionDomain domain = new ServiceSessionDomain();
        try {
            domain.updateServiceSession(sessionToUpdate);
        } catch (ServiceSessionDomain.ServiceSessionDomainException e) {
            exceptionThrown = true;
            System.assert(e.getMessage().contains(Label.UpsertOperationException),
                'The exception message should contain the defined label message.');
        }
        Test.stopTest();

        // Confirm that an exception was indeed thrown
        System.assert(exceptionThrown, 'A ServiceSessionDomainException should have been thrown.');
    }
}
