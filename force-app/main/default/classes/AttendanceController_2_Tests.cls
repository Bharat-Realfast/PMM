
@isTest
private class AttendanceController_2_Tests {

    @testSetup
    static void makeTestData() {
        // Create test data for ServiceDelivery__c records
        ServiceDelivery__c sd = new ServiceDelivery__c();
        // ... set required fields for sd
        insert sd;

        // Disable the triggers using the project-specific framework
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    @isTest
    static void testUpsertServiceDeliveries_WithValidData() {
        // Create new ServiceDelivery__c records to upsert
        List<ServiceDelivery__c> serviceDeliveriesToUpsert = new List<ServiceDelivery__c>{
            new ServiceDelivery__c() // ... set required fields
        };

        // Perform the upsert operation within the test context
        Test.startTest();
        AttendanceController.upsertServiceDeliveries(serviceDeliveriesToUpsert);
        Test.stopTest();

        // Assert that the ServiceDelivery__c records have been upserted
        List<ServiceDelivery__c> upsertedRecords = [SELECT Id FROM ServiceDelivery__c];
        System.assertEquals(2, upsertedRecords.size(), 'There should be two ServiceDelivery__c records after the upsert operation.');
    }

    @isTest
    static void testUpsertServiceDeliveries_WithNullList() {
        // Try to upsert a null list and expect an exception
        Exception exception = null;
        try {
            AttendanceController.upsertServiceDeliveries(null);
        } catch (Exception e) {
            exception = e;
        }

        // Assert that an exception was thrown
        System.assertNotEquals(null, exception, 'Upserting a null list should throw an exception.');
    }

    // Additional test methods to cover more scenarios (e.g., upsert with existing records, upsert with invalid data, etc.) can be added here.
}
