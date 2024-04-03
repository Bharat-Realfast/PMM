
@isTest
private class ServiceScheduleService_1_Tests {

    // Method to create test data for ServiceSchedule
    private static Id createTestServiceSchedule() {
        // Assuming ServiceSchedule__c is an sObject and has a Name field.
        // If ServiceSchedule__c requires other mandatory fields, they should be included here.
        ServiceSchedule__c testServiceSchedule = new ServiceSchedule__c(Name = 'Test Schedule');
        insert testServiceSchedule;
        return testServiceSchedule.Id;
    }

    // Happy Path: serviceScheduleId is valid and not null
    @isTest
    static void testGetServiceScheduleModelWithValidId() {
        // Setup test data for ServiceSchedule
        Id serviceScheduleId = createTestServiceSchedule();
        Id recordTypeId = Schema.SObjectType.ServiceSchedule__c.getRecordTypeInfosByName().get('Default').getRecordTypeId();

        // Instantiate the class to test
        ServiceScheduleService service = new ServiceScheduleService();

        // Start the test context to monitor limit usage
        Test.startTest();
        // Call the method to test
        ServiceScheduleModel result = service.getServiceScheduleModel(serviceScheduleId, recordTypeId);
        // Stop the test context
        Test.stopTest();

        // Perform assertions
        System.assertNotEquals(null, result, 'The result should not be null.');
        // If serviceSessions is supposed to be populated, create corresponding test data and assert its contents
        // System.assertNotEquals(null, result.serviceSessions, 'Session records should be populated.');
    }

    // Happy Path: serviceScheduleId is null
    @isTest
    static void testGetServiceScheduleModelWithNullId() {
        Id recordTypeId = Schema.SObjectType.ServiceSchedule__c.getRecordTypeInfosByName().get('Default').getRecordTypeId();

        ServiceScheduleService service = new ServiceScheduleService();

        Test.startTest();
        ServiceScheduleModel result = service.getServiceScheduleModel(null, recordTypeId);
        Test.stopTest();

        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(null, result.serviceSessions, 'Session records should not be populated.');
    }

    // Sad Path: serviceScheduleId is invalid
    @isTest
    static void testGetServiceScheduleModelWithInvalidId() {
        Id invalidServiceScheduleId = 'a00xxxxxxxxxxxxxxx'; // A non-existent Id
        Id recordTypeId = Schema.SObjectType.ServiceSchedule__c.getRecordTypeInfosByName().get('Default').getRecordTypeId();

        ServiceScheduleService service = new ServiceScheduleService();

        Test.startTest();
        ServiceScheduleModel result = service.getServiceScheduleModel(invalidServiceScheduleId, recordTypeId);
        Test.stopTest();

        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(null, result.serviceSessions, 'Session records should not be populated for an invalid Id.');
    }
}
