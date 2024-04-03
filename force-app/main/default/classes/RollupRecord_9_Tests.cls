
@isTest
private class RollupRecord_9_Tests {
    
    // Helper method to create a mock ServiceDelivery__c record
    private static ServiceDelivery__c createMockServiceDelivery() {
        return new ServiceDelivery__c(
            // Add fields and corresponding test data here
            // Example: Field__c = 'Test Data'
        );
    }
    
    // Happy path test: add a delivery to an initially null list
    @isTest
    static void testAddDelivery_InitiallyNull() {
        RollupRecord rollupRecord = new RollupRecord(null);
        ServiceDelivery__c deliveryRecord = createMockServiceDelivery();

        // Convert the ServiceDelivery__c record to a wrapper object if necessary
        // Assuming ServiceDelivery constructor takes a ServiceDelivery__c record
        ServiceDelivery delivery = new ServiceDelivery(deliveryRecord);

        Test.startTest();
        rollupRecord.addDelivery(delivery);
        Test.stopTest();

        // Assert that the delivery was added
        System.assertEquals(1, rollupRecord.deliveries.size(), 'The delivery should have been added to the list.');
        System.assertEquals(delivery, rollupRecord.deliveries[0], 'The delivery in the list should match the one added.');
    }
    
    // Happy path test: add a delivery to a non-empty list
    @isTest
    static void testAddDelivery_NonEmptyList() {
        RollupRecord rollupRecord = new RollupRecord(null);
        ServiceDelivery__c deliveryRecord1 = createMockServiceDelivery();
        ServiceDelivery__c deliveryRecord2 = createMockServiceDelivery();

        // Convert the ServiceDelivery__c records to wrapper objects if necessary
        ServiceDelivery delivery1 = new ServiceDelivery(deliveryRecord1);
        ServiceDelivery delivery2 = new ServiceDelivery(deliveryRecord2);

        // Pre-adding a delivery to simulate a non-empty list
        rollupRecord.addDelivery(delivery1);

        Test.startTest();
        rollupRecord.addDelivery(delivery2);
        Test.stopTest();

        // Assert that both deliveries were added
        System.assertEquals(2, rollupRecord.deliveries.size(), 'There should be two deliveries in the list.');
        System.assertEquals(delivery2, rollupRecord.deliveries[1], 'The second delivery should match the one added second.');
    }
}
