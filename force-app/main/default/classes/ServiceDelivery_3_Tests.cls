
@isTest
private class ServiceDelivery_3_Tests {

    @testSetup
    static void setup() {
        // Setup data if required for future tests that may include DML operations
        // As of now, there are no DML operations in the test methods below, so setup data is not necessary
    }

    @isTest
    static void testIsDeliveredTrue() {
        // Happy Path: Quantity is positive and Delivery Date is not null
        ServiceDelivery__c mockDelivery = new ServiceDelivery__c(
            Quantity__c = 10,
            DeliveryDate__c = Date.today()
        );
        ServiceDelivery delivery = new ServiceDelivery(mockDelivery);

        Boolean result = delivery.isDelivered();
        System.assertEquals(true, result, 'The delivery should be marked as delivered.');
    }

    @isTest
    static void testIsDeliveredFalseDueToQuantity() {
        // Sad Path: Quantity is 0 but Delivery Date is not null
        ServiceDelivery__c mockDelivery = new ServiceDelivery__c(
            Quantity__c = 0,
            DeliveryDate__c = Date.today()
        );
        ServiceDelivery delivery = new ServiceDelivery(mockDelivery);

        Boolean result = delivery.isDelivered();
        System.assertEquals(false, result, 'The delivery should not be marked as delivered due to quantity.');
    }

    @isTest
    static void testIsDeliveredFalseDueToDate() {
        // Sad Path: Quantity is positive but Delivery Date is null
        ServiceDelivery__c mockDelivery = new ServiceDelivery__c(
            Quantity__c = 10,
            DeliveryDate__c = null
        );
        ServiceDelivery delivery = new ServiceDelivery(mockDelivery);

        Boolean result = delivery.isDelivered();
        System.assertEquals(false, result, 'The delivery should not be marked as delivered due to date.');
    }

    @isTest
    static void testIsDeliveredFalseDueToBoth() {
        // Sad Path: Both Quantity is 0 or negative and Delivery Date is null
        ServiceDelivery__c mockDelivery = new ServiceDelivery__c(
            Quantity__c = -1, // Testing negative quantity
            DeliveryDate__c = null
        );
        ServiceDelivery delivery = new ServiceDelivery(mockDelivery);

        Boolean result = delivery.isDelivered();
        System.assertEquals(false, result, 'The delivery should not be marked as delivered due to both date and quantity.');
    }
}
