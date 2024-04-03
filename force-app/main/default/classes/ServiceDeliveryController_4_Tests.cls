
@isTest
public class ServiceDeliveryController_4_Tests {

    @isTest
    static void testGetNumberOfServiceDeliveriesForValidSession() {
        // Create session and associated service deliveries
        ServiceSession__c session = new ServiceSession__c(Name = 'Test Session');
        insert session;

        ServiceDelivery__c delivery1 = new ServiceDelivery__c(ServiceSession__c = session.Id, Name = 'Delivery 1');
        ServiceDelivery__c delivery2 = new ServiceDelivery__c(ServiceSession__c = session.Id, Name = 'Delivery 2');
        insert new List<ServiceDelivery__c>{delivery1, delivery2};

        Integer expectedCount = 2;

        // Perform the test
        Test.startTest();
        Integer deliveryCount = ServiceDeliveryController.getNumberOfServiceDeliveriesForSession(session.Id);
        Test.stopTest();

        System.assertEquals(expectedCount, deliveryCount, 'The count of service deliveries is incorrect.');
    }

    @isTest
    static void testGetNumberOfServiceDeliveriesForSessionWithNoDeliveries() {
        // Create session with no associated service deliveries
        ServiceSession__c session = new ServiceSession__c(Name = 'Test Session');
        insert session;

        // Perform the test
        Test.startTest();
        Integer deliveryCount = ServiceDeliveryController.getNumberOfServiceDeliveriesForSession(session.Id);
        Test.stopTest();

        System.assertEquals(0, deliveryCount, 'The count should be zero when no service deliveries are associated.');
    }

    @isTest
    static void testGetNumberOfServiceDeliveriesForException() {
        // Perform the test with a null sessionId to simulate an exceptional scenario
        Test.startTest();
        Exception thrownException = null;
        try {
            ServiceDeliveryController.getNumberOfServiceDeliveriesForSession(null);
        } catch (Exception e) {
            thrownException = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, thrownException, 'An exception should have been thrown for the invalid session Id.');
    }
}
