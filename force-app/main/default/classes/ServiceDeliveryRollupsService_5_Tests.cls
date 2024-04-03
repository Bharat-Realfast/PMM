
@isTest
private class ServiceDeliveryRollupsService_5_Tests {

    @testSetup
    static void setup() {
        // Create test data for different SObjectTypes that may be used by rollupDeliveryRecords method

        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact');
        insert testContact;

        List<ServiceDelivery__c> serviceDeliveries = new List<ServiceDelivery__c>();
        for (Integer i = 0; i < 5; i++) {
            ServiceDelivery__c delivery = new ServiceDelivery__c(
                Contact__c = testContact.Id
                // Populate other required fields and ensure they are linked to the corresponding parent record
            );
            serviceDeliveries.add(delivery);
        }
        // Assuming that NumPresentServiceDeliveries__c is a rollup field on Contact, reset it to 0 for the test
        testContact.NumPresentServiceDeliveries__c = 0;
        update testContact;
        insert serviceDeliveries;
    }

    @isTest
    static void testRollupDeliveryRecordsWithValidSObjectType() {
        List<ServiceDelivery__c> testDeliveries = [SELECT Id, Contact__c FROM ServiceDelivery__c];
        Contact testContact = [SELECT Id, NumPresentServiceDeliveries__c FROM Contact LIMIT 1];

        ServiceDeliveryRollupsService service = new ServiceDeliveryRollupsService();
        service.rollupDeliveryRecords(Contact.SObjectType, testDeliveries);

        testContact = [SELECT Id, NumPresentServiceDeliveries__c FROM Contact WHERE Id = :testContact.Id];

        // Assert that the contact has the updated delivery count
        System.assertEquals(5, testContact.NumPresentServiceDeliveries__c, 'The contact should have 5 present service deliveries.');
    }

    @isTest
    static void testRollupDeliveryRecordsWithEmptyDeliveryList() {
        // Query the contact's NumPresentServiceDeliveries__c before calling the method
        Contact testContactBefore = [SELECT Id, NumPresentServiceDeliveries__c FROM Contact LIMIT 1];

        List<ServiceDelivery__c> emptyDeliveries = new List<ServiceDelivery__c>();

        ServiceDeliveryRollupsService service = new ServiceDeliveryRollupsService();
        service.rollupDeliveryRecords(Contact.SObjectType, emptyDeliveries);

        // Query the contact's NumPresentServiceDeliveries__c after calling the method
        Contact testContactAfter = [SELECT Id, NumPresentServiceDeliveries__c FROM Contact WHERE Id = :testContactBefore.Id];

        // Assert that the NumPresentServiceDeliveries__c field remains the same after calling the method with an empty list
        System.assertEquals(testContactBefore.NumPresentServiceDeliveries__c, testContactAfter.NumPresentServiceDeliveries__c, 'No change should occur on an empty delivery list.');
    }

    // Additional test methods for other scenarios or SObjectTypes can be added as needed
}
