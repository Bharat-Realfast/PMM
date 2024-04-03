
@isTest
public class ServiceDeliveryDomain_2_Tests {

    @testSetup
    static void setup() {
        // Create test data needed for the test scenarios
        List<ServiceDelivery__c> serviceDeliveries = new List<ServiceDelivery__c>();
        // Assuming ServiceDelivery__c has necessary fields populated correctly
        serviceDeliveries.add(new ServiceDelivery__c(/*required fields*/));
        insert serviceDeliveries;
    }

    @isTest
    static void testDeleteServiceDeliveries_HappyPath() {
        // Query for the test data
        List<ServiceDelivery__c> serviceDeliveries = [SELECT Id FROM ServiceDelivery__c];
        Test.startTest();
        
        new ServiceDeliveryDomain().deleteServiceDeliveries(serviceDeliveries);
        
        Test.stopTest();
        
        // Assert that the records were deleted
        List<ServiceDelivery__c> remainingDeliveries = [SELECT Id FROM ServiceDelivery__c];
        System.assertEquals(0, remainingDeliveries.size(), 'Service deliveries should be deleted.');
    }

    @isTest
    static void testDeleteServiceDeliveries_EmptyList() {
        // Create an empty list
        List<ServiceDelivery__c> emptyList = new List<ServiceDelivery__c>();
        Test.startTest();
        
        new ServiceDeliveryDomain().deleteServiceDeliveries(emptyList);
        
        Test.stopTest();
        
        // Assert no exception is thrown and no records are deleted
        List<ServiceDelivery__c> remainingDeliveries = [SELECT Id FROM ServiceDelivery__c];
        System.assertEquals(1, remainingDeliveries.size(), 'No service deliveries should be deleted.');
    }

    @isTest
    static void testDeleteServiceDeliveries_NoDeletePermission() {
        List<ServiceDelivery__c> serviceDeliveries = [SELECT Id FROM ServiceDelivery__c];
        Test.startTest();

        // Try to catch the custom exception thrown when delete permissions are missing
        Exception actualException;
        try {
            new ServiceDeliveryDomain().deleteServiceDeliveries(serviceDeliveries);
        } catch (ServiceDeliveryDomain.ServiceDeliveryDomainException e) {
            actualException = e;
        }

        Test.stopTest();

        // Assert that the custom exception is not null, indicating it was thrown
        System.assertNotEquals(null, actualException, 'A ServiceDeliveryDomainException should be thrown due to lack of delete permission.');
        // Additionally, assert the exception message to ensure the correct exception is caught
        // This assertion assumes that Label.Delete_Operation_Exception exists and is accessible in this context
        System.assertEquals(Label.Delete_Operation_Exception, actualException.getMessage(), 'The exception message should match the expected label.');
    }
}
