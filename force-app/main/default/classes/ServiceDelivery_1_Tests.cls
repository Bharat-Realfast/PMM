
@isTest
private class ServiceDelivery_1_Tests {

    // Test setup method to create test data
    @testSetup
    static void makeTestData() {
        // Create a related record for the Program__c field with all required fields populated
        Program__c program = new Program__c(
            Name = 'Test Program',
            Status__c = 'Active' // Populate the required Status__c field
        );
        insert program;

        // Now we can create Service__c records with the required Program__c field populated
        Service__c service = new Service__c(
            Name = 'Test Service',
            Program__c = program.Id // Associate the related record
        );
        insert service;

        // Now we can create ServiceDelivery__c records with the required Service__c field populated
        ServiceDelivery__c deliveryPresent = new ServiceDelivery__c(
            Service__c = service.Id, // Associate the related record
            AttendanceStatus__c = 'Present',
            Quantity__c = 1,
            DeliveryDate__c = Date.today()
        );

        ServiceDelivery__c deliveryAbsent = new ServiceDelivery__c(
            Service__c = service.Id, // Associate the related record
            AttendanceStatus__c = 'Absent'
        );

        insert new List<ServiceDelivery__c>{ deliveryPresent, deliveryAbsent };
    }

    // Test method for happy path scenario
    @isTest
    static void testIsPresentTrue() {
        ServiceDelivery__c delivery = [SELECT Id, AttendanceStatus__c FROM ServiceDelivery__c WHERE AttendanceStatus__c = 'Present' LIMIT 1];
        ServiceDelivery serviceDelivery = new ServiceDelivery(delivery);

        Boolean result = serviceDelivery.isPresent();

        System.assert(result, 'The delivery should be marked as present.');
    }

    // Test method for sad path scenario
    @isTest
    static void testIsPresentFalse() {
        ServiceDelivery__c delivery = [SELECT Id, AttendanceStatus__c FROM ServiceDelivery__c WHERE AttendanceStatus__c = 'Absent' LIMIT 1];
        ServiceDelivery serviceDelivery = new ServiceDelivery(delivery);

        Boolean result = serviceDelivery.isPresent();

        System.assert(!result, 'The delivery should not be marked as present.');
    }
}
