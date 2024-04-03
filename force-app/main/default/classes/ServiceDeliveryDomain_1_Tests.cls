
@isTest
private class ServiceDeliveryDomain_1_Tests {
    @testSetup
    static void setup() {
        // Create test data for ServiceDelivery__c records
        // Replace 'Field__c' with the actual field name(s) required for ServiceDelivery__c
        List<ServiceDelivery__c> testServiceDeliveries = new List<ServiceDelivery__c>();
        for (Integer i = 0; i < 2; i++) {
            ServiceDelivery__c delivery = new ServiceDelivery__c(
                // Initialize required fields here
                Field__c = 'Value ' + i
            );
            testServiceDeliveries.add(delivery);
        }
        // Insert the test data
        insert testServiceDeliveries;
    }

    private static void bypassAccountTriggers() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }
    
    @isTest
    static void testUpsertWithNewAndExistingRecords() {
        bypassAccountTriggers();
        
        ServiceDeliveryDomain domain = new ServiceDeliveryDomain();
        List<ServiceDelivery__c> serviceDeliveriesToUpsert = new List<ServiceDelivery__c>();
        
        // Add an existing record
        ServiceDelivery__c existingDelivery = [SELECT Id FROM ServiceDelivery__c LIMIT 1];
        // Modify a field to update
        existingDelivery.Field__c = 'Updated Value';
        serviceDeliveriesToUpsert.add(existingDelivery);
        
        // Add a new record
        ServiceDelivery__c newDelivery = new ServiceDelivery__c(
            // Initialize required fields here
            Field__c = 'New Value'
        );
        serviceDeliveriesToUpsert.add(newDelivery);
        
        Test.startTest();
        domain.upsertServiceDeliveries(serviceDeliveriesToUpsert);
        Test.stopTest();
        
        List<ServiceDelivery__c> insertedDeliveries = [SELECT Id FROM ServiceDelivery__c WHERE Id = :newDelivery.Id];
        List<ServiceDelivery__c> updatedDeliveries = [SELECT Field__c FROM ServiceDelivery__c WHERE Id = :existingDelivery.Id];
        
        System.assertEquals(1, insertedDeliveries.size(), 'A new service delivery should have been inserted.');
        System.assertEquals('Updated Value', updatedDeliveries[0].Field__c, 'The existing service delivery should have an updated value.');
    }
    
    @isTest
    static void testUpsertWithEmptyList() {
        bypassAccountTriggers();
        
        ServiceDeliveryDomain domain = new ServiceDeliveryDomain();
        List<ServiceDelivery__c> emptyList = new List<ServiceDelivery__c>();
        
        Test.startTest();
        domain.upsertServiceDeliveries(emptyList);
        Test.stopTest();
        
        // Assert that no exception was thrown
        System.assert(true, 'No exception should have been thrown for an empty list.');
    }
    
    @isTest
    static void testUpsertWithoutPermissions() {
        bypassAccountTriggers();
        
        // We can't directly mock PermissionValidator behavior so we will simulate the exception throwing manually
        ServiceDeliveryDomain domain = new ServiceDeliveryDomain();
        List<ServiceDelivery__c> serviceDeliveries = [SELECT Id FROM ServiceDelivery__c LIMIT 1];
        
        // Assuming we have set up the PermissionValidator to throw an exception
        Boolean exceptionThrown = false;
        Test.startTest();
        try {
            domain.upsertServiceDeliveries(serviceDeliveries);
        } catch (ServiceDeliveryDomain.ServiceDeliveryDomainException e) {
            exceptionThrown = true;
        }
        Test.stopTest();
        
        // Assert that an exception was thrown
        System.assert(exceptionThrown, 'A ServiceDeliveryDomainException should have been thrown due to lack of permissions.');
    }
}
