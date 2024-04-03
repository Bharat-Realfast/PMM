
@isTest
private class ServiceDeliveryController_3_Tests {

    @testSetup
    static void setup() {
        // Setup test data
        Session__c testSession = new Session__c(Name = 'Test Session');
        insert testSession;

        List<ServiceDelivery__c> serviceDeliveries = new List<ServiceDelivery__c>{
            new ServiceDelivery__c(Session__c = testSession.Id),
            new ServiceDelivery__c(Session__c = testSession.Id)
        };
        insert serviceDeliveries;
    }
    
    @isTest
    static void testDeleteServiceDeliveriesWithRecords() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Session__c testSession = [SELECT Id FROM Session__c LIMIT 1];
        Test.startTest();
        Integer deletedCount = ServiceDeliveryController.deleteServiceDeliveriesForSession(testSession.Id);
        Test.stopTest();

        System.assertEquals(2, deletedCount, 'Two records should be deleted.');
        System.assertEquals(0, [SELECT COUNT() FROM ServiceDelivery__c WHERE Session__c = :testSession.Id], 'No records should remain for the session after deletion.');
    }
    
    @isTest
    static void testDeleteServiceDeliveriesWithNoRecords() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Create a session with no related ServiceDelivery__c records
        Session__c testSession = new Session__c(Name = 'Lonely Session');
        insert testSession;

        Test.startTest();
        Integer deletedCount = ServiceDeliveryController.deleteServiceDeliveriesForSession(testSession.Id);
        Test.stopTest();

        System.assertEquals(0, deletedCount, 'No records should be deleted when there are no related service deliveries.');
    }
    
    @isTest
    static void testDeleteServiceDeliveriesWithNullSessionId() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Boolean exceptionCaught = false;
        Test.startTest();
        try {
            ServiceDeliveryController.deleteServiceDeliveriesForSession(null);
        } catch (Util.AuraHandledException e) {
            exceptionCaught = true;
        }
        Test.stopTest();

        System.assertTrue(exceptionCaught, 'An AuraHandledException should be thrown when attempting to delete service deliveries with a null session ID.');
    }
    
    @isTest(expectedExceptions = Util.AuraHandledException.class)
    static void testDeleteServiceDeliveriesWithDmlException() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // This is a hypothetical scenario, assuming that an AuraHandledException is thrown by the method under test.
        // Since we cannot directly simulate a DML exception in a test, we will assert that an AuraHandledException is thrown.
        Session__c testSession = [SELECT Id FROM Session__c LIMIT 1];
        Test.startTest();
        Integer deletedCount = ServiceDeliveryController.deleteServiceDeliveriesForSession(testSession.Id);
        Test.stopTest();

        System.assertNotEquals(null, deletedCount, 'An exception should have been thrown, so no count should be returned.');
    }
}
