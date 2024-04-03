
@isTest
private class ServiceDeliveryService_2_Tests {

    @testSetup
    static void makeData() {
        // Create test data for ServiceDelivery__c records
        // Note: Ensure that all required fields and relationships are properly set up
        // For simplicity, this is omitted in the sample. In a real test setup, you would create necessary records.
    }
    
    @isTest
    static void testSuccessfulUpsertServiceDeliveries() {
        // Retrieve the test data
        List<ServiceDelivery__c> testServiceDeliveries = [SELECT Id FROM ServiceDelivery__c];

        Test.startTest();
        ServiceDeliveryService service = new ServiceDeliveryService();
        service.upsertServiceDeliveries(testServiceDeliveries);
        Test.stopTest();

        List<ServiceDelivery__c> upsertedServiceDeliveries = [SELECT Id FROM ServiceDelivery__c];
        System.assertEquals(testServiceDeliveries.size(), upsertedServiceDeliveries.size(), 'The number of upserted records should match test data');
        System.assertNotEquals(null, upsertedServiceDeliveries[0].Id, 'The upserted record should have an Id');
    }
    
    @isTest
    static void testUpsertServiceDeliveriesWithException() {
        // Retrieve the test data
        List<ServiceDelivery__c> testServiceDeliveries = new List<ServiceDelivery__c>();
        // Create a new ServiceDelivery__c with a required field missing
        ServiceDelivery__c sd = new ServiceDelivery__c(); // Assuming ServiceDelivery__c.ServiceSession__c is required
        // Do not set sd.ServiceSession__c which is required to cause a DML exception
        testServiceDeliveries.add(sd);

        Boolean exceptionThrown = false;
        try {
            Test.startTest();
            ServiceDeliveryService service = new ServiceDeliveryService();
            service.upsertServiceDeliveries(testServiceDeliveries);
            Test.stopTest();
        } catch (ServiceDeliveryService.ServiceDeliveryException ex) {
            exceptionThrown = true;
        }

        System.assertTrue(exceptionThrown, 'A ServiceDeliveryException should have been thrown due to missing required fields');
    }
    
    @isTest
    static void testUpsertServiceDeliveriesWithEmptyList() {
        ServiceDeliveryService service = new ServiceDeliveryService();

        Test.startTest();
        service.upsertServiceDeliveries(new List<ServiceDelivery__c>());
        Test.stopTest();

        Integer recordsCount = [SELECT COUNT() FROM ServiceDelivery__c];
        System.assertEquals(0, recordsCount, 'No ServiceDelivery records should be upserted since the list was empty');
    }
}
