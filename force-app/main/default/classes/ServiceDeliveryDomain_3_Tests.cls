
@isTest
private class ServiceDeliveryDomain_3_Tests {

    @testSetup
    static void makeTestData() {
        // Set up your test data if necessary. For this test scenario, we're assuming no specific data setup is required.
    }
    
    @isTest
    static void shouldInsertServiceDeliveriesSuccessfully() {
        // Assuming triggers have been bypassed or are not relevant for this test
        
        // Arrange
        List<ServiceDelivery__c> serviceDeliveries = new List<ServiceDelivery__c>{
            new ServiceDelivery__c() // Add necessary fields here
        };
        
        // Act
        Test.startTest();
        new ServiceDeliveryDomain().insertServiceDeliveries(serviceDeliveries);
        Test.stopTest();
        
        // Assert
        List<ServiceDelivery__c> insertedDeliveries = [SELECT Id FROM ServiceDelivery__c];
        System.assertEquals(1, insertedDeliveries.size(), 'One record should have been inserted.');
        System.assertNotEquals(null, insertedDeliveries[0].Id, 'The record should have an ID.');
    }

    @isTest
    static void shouldNotInsertEmptyList() {
        // Assuming triggers have been bypassed or are not relevant for this test
        
        // Arrange
        List<ServiceDelivery__c> emptyDeliveries = new List<ServiceDelivery__c>();
        
        // Act
        Test.startTest();
        new ServiceDeliveryDomain().insertServiceDeliveries(emptyDeliveries);
        Test.stopTest();
        
        // Assert
        List<ServiceDelivery__c> insertedDeliveries = [SELECT Id FROM ServiceDelivery__c];
        System.assertEquals(0, insertedDeliveries.size(), 'No records should have been inserted.');
    }

    @isTest
    static void shouldNotInsertServiceDeliveriesWithoutCreatePermission() {
        // Assuming triggers have been bypassed or are not relevant for this test
        
        // Arrange
        List<ServiceDelivery__c> serviceDeliveries = new List<ServiceDelivery__c>{
            new ServiceDelivery__c() // Add necessary fields here
        };
        
        // Act and Assert
        Test.startTest();
        try {
            new ServiceDeliveryDomain().insertServiceDeliveries(serviceDeliveries);
            System.assert(false, 'A ServiceDeliveryDomainException should have been thrown');
        } catch (ServiceDeliveryDomain.ServiceDeliveryDomainException e) {
            System.assert(e.getMessage().contains('UpsertOperationException'), 'The exception message should contain UpsertOperationException');
        }
        Test.stopTest();
    }
}
