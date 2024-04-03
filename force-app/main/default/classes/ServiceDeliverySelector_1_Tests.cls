
@isTest
private class ServiceDeliverySelector_1_Tests {

    static void mockPermissionValidator(Boolean hasReadAccess) {
        // Assuming there's a way to mock the PermissionValidator's behavior. This method simulates it.
        // The actual implementation of this mock behavior needs to be done in the PermissionValidator class.
    }

    @testSetup
    static void setup() {
        // Create test data for ServiceSession and ServiceDelivery records
        ServiceSession__c testSession = new ServiceSession__c(/* required fields */);
        insert testSession;

        ServiceDelivery__c delivery1 = new ServiceDelivery__c(ServiceSession__c = testSession.Id /* other fields */);
        ServiceDelivery__c delivery2 = new ServiceDelivery__c(ServiceSession__c = testSession.Id /* other fields */);

        // Insert test ServiceDelivery records
        insert new List<ServiceDelivery__c>{delivery1, delivery2};
    }

    @isTest
    static void testGetNumberOfServiceDeliveriesForSessionWithPermissions() {
        mockPermissionValidator(true);
        Id sessionId = [SELECT Id FROM ServiceSession__c LIMIT 1].Id;

        Test.startTest();
        Integer count = new ServiceDeliverySelector().getNumberOfServiceDeliveriesForSession(sessionId);
        Test.stopTest();

        System.assertEquals(2, count, 'The number of deliveries should be equal to the number of inserted records.');
    }

    @isTest
    static void testGetNumberOfServiceDeliveriesForSessionWithoutPermissions() {
        mockPermissionValidator(false);
        Id sessionId = [SELECT Id FROM ServiceSession__c LIMIT 1].Id;

        Test.startTest();
        Integer count = new ServiceDeliverySelector().getNumberOfServiceDeliveriesForSession(sessionId);
        Test.stopTest();

        System.assertEquals(0, count, 'The count should be 0 as the user does not have read access.');
    }

    @isTest
    static void testGetNumberOfServiceDeliveriesForSessionNoRelatedRecords() {
        // Create a separate session with no deliveries
        ServiceSession__c testSessionWithoutDeliveries = new ServiceSession__c(/* required fields */);
        insert testSessionWithoutDeliveries;

        mockPermissionValidator(true);
        Id sessionId = testSessionWithoutDeliveries.Id;

        Test.startTest();
        Integer count = new ServiceDeliverySelector().getNumberOfServiceDeliveriesForSession(sessionId);
        Test.stopTest();

        System.assertEquals(0, count, 'There should be no deliveries related to the new session.');
    }
}
