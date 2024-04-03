
@isTest
private class RollupRecord_10_Tests {

    @testSetup
    static void setup() {
        // No data setup needed for this test
    }

    // Since we don't have information about the ServiceDelivery__c object's fields, 
    // we'll create a new instance without setting any specific fields.
    // You will need to replace <DateFieldApiName> with the actual Date field API name from ServiceDelivery__c.
    private static ServiceDelivery createTestServiceDelivery() {
        ServiceDelivery__c sDelivery = new ServiceDelivery__c();
        // Assuming <DateFieldApiName> is an actual field on ServiceDelivery__c, set it to today's date.
        // sDelivery.<DateFieldApiName> = Date.today();
        insert sDelivery; // Insert the record so it gets an Id - required for realistic testing
        return new ServiceDelivery(sDelivery);
    }

    @isTest
    static void testAddOriginalDelivery_NewList() {
        RollupRecord rollup = new RollupRecord(null);
        ServiceDelivery delivery = createTestServiceDelivery();
        
        Test.startTest();
        rollup.addOriginalDelivery(delivery);
        Test.stopTest();
        
        System.assertNotEquals(null, rollup.originalDeliveries, 'originalDeliveries should not be null after adding a delivery.');
        System.assertEquals(1, rollup.originalDeliveries.size(), 'originalDeliveries should have 1 delivery after adding.');
    }
    
    @isTest
    static void testAddOriginalDelivery_ExistingList() {
        RollupRecord rollup = new RollupRecord(null);
        ServiceDelivery firstDelivery = createTestServiceDelivery();
        rollup.addOriginalDelivery(firstDelivery);
        ServiceDelivery secondDelivery = createTestServiceDelivery();
        
        Test.startTest();
        rollup.addOriginalDelivery(secondDelivery);
        Test.stopTest();
        
        System.assertNotEquals(null, rollup.originalDeliveries, 'originalDeliveries should not be null after adding a delivery.');
        System.assertEquals(2, rollup.originalDeliveries.size(), 'originalDeliveries should have 2 deliveries after adding another.');
    }
}
