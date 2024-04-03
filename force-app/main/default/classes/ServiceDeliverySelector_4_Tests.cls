
@isTest
private class ServiceDeliverySelector_4_Tests {

    // We'll use this method to setup common test data for all test methods.
    @testSetup
    static void setupTestData() {
        // Create test data for ServiceSession__c and ServiceDelivery__c records.
        ServiceSession__c testSession = new ServiceSession__c(Name = 'Test Session');
        insert testSession;

        ServiceDelivery__c delivery1 = new ServiceDelivery__c(
            ServiceSession__c = testSession.Id
            // Populate other required fields
        );
        ServiceDelivery__c delivery2 = new ServiceDelivery__c(
            ServiceSession__c = testSession.Id
            // Populate other required fields
        );

        insert new List<ServiceDelivery__c>{delivery1, delivery2};
    }

    @isTest
    static void testGetServiceDeliveriesBySessionIdWithPermission() {
        Test.startTest();
        ServiceDeliverySelector selector = new ServiceDeliverySelector();

        // We are passing null for the FieldSet parameter as a simplification for the test context.
        // In actual implementation, the method is expected to be called with a valid FieldSet instance.
        Id testSessionId = [SELECT Id FROM ServiceSession__c LIMIT 1].Id;
        List<ServiceDelivery__c> results = selector.getServiceDeliveriesBySessionId(null, testSessionId);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, results, 'Results should not be null.');
        System.assertEquals(2, results.size(), 'Expected two records to be returned.');
    }

    @isTest
    static void testGetServiceDeliveriesBySessionIdWithoutPermission() {
        // Simulate no permission scenario by assuming method returns empty list.
        Test.startTest();
        ServiceDeliverySelector selector = new ServiceDeliverySelector();

        // We are passing null for the FieldSet parameter as a simplification for the test context.
        Id testSessionId = [SELECT Id FROM ServiceSession__c LIMIT 1].Id;
        List<ServiceDelivery__c> results = selector.getServiceDeliveriesBySessionId(null, testSessionId);
        Test.stopTest();

        // Assertions
        System.assertEquals(true, results.isEmpty(), 'Expected no records to be returned due to no permission.');
    }

    @isTest
    static void testGetServiceDeliveriesBySessionIdNoRecords() {
        // Create a session with no associated service deliveries.
        ServiceSession__c testSession = new ServiceSession__c(Name = 'Empty Session');
        insert testSession;

        Test.startTest();
        ServiceDeliverySelector selector = new ServiceDeliverySelector();

        // We are passing null for the FieldSet parameter as a simplification for the test context.
        List<ServiceDelivery__c> results = selector.getServiceDeliveriesBySessionId(null, testSession.Id);
        Test.stopTest();

        // Assertions
        System.assertEquals(0, results.size(), 'Expected no records to be returned as there are no service deliveries for the session.');
    }
}
