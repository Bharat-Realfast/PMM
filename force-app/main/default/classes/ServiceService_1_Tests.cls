
@isTest
private class ServiceService_1_Tests {

    @testSetup
    static void makeTestData() {
        // Create test Contact
        Contact testContact = new Contact(LastName = 'TestContact');
        insert testContact;

        // Other test data that correspond to the ServiceService class logic should be created here.
        // This could include creating test records for Program__c, Service__c, and ProgramEngagement__c,
        // as well as any required setup for Custom Metadata Types used in activeStatuses and bsdtFilterIsActive logic.
    }

    @isTest
    static void testGetServicesEngagementsByContactId_NoActiveFilter() {
        Id testContactId = [SELECT Id FROM Contact WHERE LastName = 'TestContact' LIMIT 1].Id;
        ServiceService serviceService = new ServiceService();

        // Execute the target method
        Map<String, List<Object>> result = serviceService.getServicesEngagementsByContactId(testContactId);

        // Assertions
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertTrue(result.containsKey('engagements'), 'Engagements key should be present.');
        System.assertTrue(result.containsKey('services'), 'Services key should be present.');
    }

    @isTest
    static void testGetServicesEngagementsByContactId_ActiveFilter() {
        Id testContactId = [SELECT Id FROM Contact WHERE LastName = 'TestContact' LIMIT 1].Id;
        ServiceService serviceService = new ServiceService();

        // Assuming a mechanism to mock bsdtFilterIsActive to return true
        // Depending on the implementation, you might need to adjust test data or mock responses here.

        // Execute the target method
        Map<String, List<Object>> result = serviceService.getServicesEngagementsByContactId(testContactId);

        // Assertions
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertTrue(result.containsKey('engagements'), 'Engagements key should be present.');
        System.assertTrue(result.containsKey('services'), 'Services key should be present.');

        // Additional assertions based on the expected filtering behavior would go here.
    }

    @isTest
    static void testGetServicesEngagementsByContactId_NullContactId() {
        ServiceService serviceService = new ServiceService();

        // Execute the target method
        Map<String, List<Object>> result = serviceService.getServicesEngagementsByContactId(null);

        // Assertions
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertEquals(0, result.get('engagements').size(), 'Engagements list should be empty.');
        System.assertEquals(0, result.get('services').size(), 'Services list should be empty.');
    }

    @isTest
    static void testGetServicesEngagementsByContactId_NoRelatedData() {
        Contact testContact = new Contact(LastName = 'NoRelations');
        insert testContact;
        
        ServiceService serviceService = new ServiceService();

        // Execute the target method
        Map<String, List<Object>> result = serviceService.getServicesEngagementsByContactId(testContact.Id);

        // Assertions
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertEquals(0, result.get('engagements').size(), 'Engagements list should be empty.');
        System.assertEquals(0, result.get('services').size(), 'Services list should be empty.');
    }
}
