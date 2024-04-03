
@isTest
private class ServiceDeliverySelector_2_Tests {
    @testSetup
    static void setupTestData() {
        // Create a ServiceSession__c record
        ServiceSession__c session = new ServiceSession__c(); // populate required fields
        insert session;

        // Create a ServiceDelivery__c record associated with the session
        ServiceDelivery__c serviceDelivery = new ServiceDelivery__c(
            ServiceSession__c = session.Id // populate other required fields
        );
        insert serviceDelivery;
    }

    @isTest
    static void testGetServiceDeliveriesForSession_WithRecords() {
        Test.startTest();
        ServiceDeliverySelector serviceDeliverySelector = new ServiceDeliverySelector();
        Id testSessionId = [SELECT Id FROM ServiceSession__c LIMIT 1].Id;
        List<ServiceDelivery__c> result = serviceDeliverySelector.getServiceDeliveriesForSession(testSessionId);
        Test.stopTest();

        // Assert that we received at least one ServiceDelivery__c record
        System.assertNotEquals(0, result.size(), 'There should be one or more ServiceDelivery__c records retrieved.');
        // Assert that the retrieved records have the expected sessionId
        for (ServiceDelivery__c sd : result) {
            System.assertEquals(testSessionId, sd.ServiceSession__c, 'The ServiceDelivery__c record should be associated with the correct ServiceSession__c.');
        }
    }

    @isTest
    static void testGetServiceDeliveriesForSession_NoRecords() {
        Test.startTest();
        // Create a new ServiceSession__c record that has no associated ServiceDelivery__c records
        ServiceSession__c newSession = new ServiceSession__c(); // populate required fields
        insert newSession;

        ServiceDeliverySelector serviceDeliverySelector = new ServiceDeliverySelector();
        List<ServiceDelivery__c> result = serviceDeliverySelector.getServiceDeliveriesForSession(newSession.Id);
        Test.stopTest();

        // Assert that no records are found
        System.assertEquals(0, result.size(), 'There should be no ServiceDelivery__c records retrieved for the new session.');
    }

    // As previously mentioned, we cannot write a test for lack of permissions without a way to mock PermissionValidator 
}
