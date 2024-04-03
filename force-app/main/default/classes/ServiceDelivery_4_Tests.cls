
@isTest
private class ServiceDelivery_4_Tests {

    @testSetup
    static void setup() {
        // Create a related Program__c record assuming it is a required field on Service__c
        Program__c program = new Program__c(
            Name = 'Test Program', // Populate all required fields for Program__c. Assuming Name is required.
            Status__c = 'Active' // Populate the Status__c field which is required.
        );
        insert program;

        // Create a related Service__c record assuming it is a required field on ServiceDelivery__c
        Service__c service = new Service__c(
            Name = 'Test Service', // Populate all required fields for Service__c. Assuming Name is required.
            Program__c = program.Id // Associate the Program__c record with Service__c
        );
        insert service;

        // Now create ServiceDelivery__c record with all required fields populated
        ServiceDelivery__c delivery = new ServiceDelivery__c(
            AttendanceStatus__c = 'Present', // Assuming 'Present' is a valid Attendance status.
            Quantity__c = 1,
            DeliveryDate__c = Date.today(),
            Service__c = service.Id // Associate the Service__c record with ServiceDelivery__c
        );
        insert delivery;
    }

    @isTest
    static void testGetIdHappyPath() {
        // Given a ServiceDelivery instance with a non-null Id
        ServiceDelivery__c delivery = [SELECT Id FROM ServiceDelivery__c LIMIT 1];
        ServiceDelivery deliveryInstance = new ServiceDelivery(delivery);

        // When getId() is called
        Id resultId = deliveryInstance.getId();

        // Then the returned Id should be the same as the delivery record's Id
        System.assertEquals(delivery.Id, resultId, 'The returned Id should match the record Id.');
    }
}
