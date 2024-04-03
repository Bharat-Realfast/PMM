
@isTest
private class ServiceDelivery_6_Tests {

    // The test setup method to create test data
    @testSetup
    static void setup() {
        // Assuming there's no need to bypass triggers in the test context or that it's handled elsewhere
        
        // Create a ServiceDelivery__c object with a lookup field value
        Account testAccount = new Account(Name = 'TestAccount');
        insert testAccount;
        
        ServiceDelivery__c deliveryRecord = new ServiceDelivery__c(
            Account__c = testAccount.Id,
            AttendanceStatus__c = 'Present',
            Quantity__c = 10,
            DeliveryDate__c = Date.today()
        );
        
        insert deliveryRecord;
    }
    
    // Happy Path Test
    @isTest
    static void testGetLookupIdHappyPath() {
        // Arrange
        ServiceDelivery__c testDelivery = [SELECT Id, Account__c FROM ServiceDelivery__c LIMIT 1];
        ServiceDelivery serviceDelivery = new ServiceDelivery(testDelivery);
        
        // Act
        Id accountLookupId = serviceDelivery.getLookupId(ServiceDelivery__c.Account__c);
        
        // Assert
        System.assertNotEquals(null, accountLookupId, 'Account lookup Id should not be null.');
        System.assertEquals(testDelivery.Account__c, accountLookupId, 'Account lookup Id should match the test Account Id.');
    }
    
    // Sad Path Test
    @isTest
    static void testGetLookupIdSadPath() {
        // Arrange
        ServiceDelivery__c testDelivery = [SELECT Id FROM ServiceDelivery__c LIMIT 1];
        ServiceDelivery serviceDelivery = new ServiceDelivery(testDelivery);
        
        // Act
        // Assuming DeliveryDate__c is not a lookup field and will therefore not be populated in setup
        Id invalidLookupId = serviceDelivery.getLookupId(ServiceDelivery__c.DeliveryDate__c);
        
        // Assert
        System.assertEquals(null, invalidLookupId, 'Non-lookup field should return null.');
    }
    
    // Exceptional Scenario Test
    @isTest
    static void testGetLookupIdWithNull() {
        // Arrange
        ServiceDelivery__c testDelivery = [SELECT Id FROM ServiceDelivery__c LIMIT 1];
        ServiceDelivery serviceDelivery = new ServiceDelivery(testDelivery);
        
        // Act
        Id nullFieldId = serviceDelivery.getLookupId(null);
        
        // Assert
        System.assertEquals(null, nullFieldId, 'Passing null should return null.');
    }
}
