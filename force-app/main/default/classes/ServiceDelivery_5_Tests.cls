
@isTest
public with sharing class ServiceDelivery_5_Tests {
    
    @testSetup
    static void setupTestData() {
        ServiceDelivery__c delivery = new ServiceDelivery__c(
            AttendanceStatus__c = 'Present', // Assuming 'Present' is a valid status
            Quantity__c = 1,
            DeliveryDate__c = Date.today()
        );
        // Assuming triggers are properly bypassed if necessary
        insert delivery; 
    }
    
    private static ServiceDelivery__c getTestDeliveryRecord() {
        return [SELECT Id, AttendanceStatus__c, Quantity__c, DeliveryDate__c FROM ServiceDelivery__c LIMIT 1];
    }
    
    @isTest
    static void testGetDeliveryDateWithDateSet() {
        ServiceDelivery__c testDelivery = getTestDeliveryRecord();
        ServiceDelivery serviceDeliveryInstance = new ServiceDelivery(testDelivery);
        
        Test.startTest();
        Date deliveryDate = serviceDeliveryInstance.getDeliveryDate();
        Test.stopTest();
        
        System.assertEquals(Date.today(), deliveryDate, 'The delivery date should match the date set in test setup.');
    }
    
    @isTest
    static void testGetDeliveryDateWithNoDateSet() {
        ServiceDelivery__c testDelivery = new ServiceDelivery__c(
            AttendanceStatus__c = 'Present', // Assuming 'Present' is a valid status
            Quantity__c = 1
            // Not setting DeliveryDate__c to simulate sad path
        );
        // Assuming triggers are properly bypassed if necessary
        insert testDelivery; 

        ServiceDelivery serviceDeliveryInstance = new ServiceDelivery(testDelivery);
        
        Test.startTest();
        Date deliveryDate = serviceDeliveryInstance.getDeliveryDate();
        Test.stopTest();
        
        System.assert(deliveryDate == null, 'The delivery date should be null when not set.');
    }
}
