
@isTest
private class ServiceDeliveryController_5_Tests {

    @testSetup
    static void makeTestData() {
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'User');
        insert testContact;
    }

    @isTest
    static void testGetServicesAndEngagementsHappyPath() {
        Test.startTest();
        Id contactId = [SELECT Id FROM Contact WHERE FirstName = 'Test' AND LastName = 'User' LIMIT 1].Id;
        Map<String, List<Object>> result = ServiceDeliveryController.getServicesAndEngagements(contactId);
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(true, result.containsKey('Services'), 'Services key should be present in the result map');
        Test.stopTest();
    }

    @isTest
    static void testGetServicesAndEngagementsSadPath() {
        Test.startTest();
        Id contactId = [SELECT Id FROM Contact WHERE FirstName = 'Test' AND LastName = 'User' LIMIT 1].Id;
        Map<String, List<Object>> result = ServiceDeliveryController.getServicesAndEngagements(contactId);
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(0, result.size(), 'Result map should be empty');
        Test.stopTest();
    }

    @isTest
    static void testGetServicesAndEngagementsExceptionalScenario() {
        Test.startTest();
        Id contactId = null;
        Map<String, List<Object>> result = ServiceDeliveryController.getServicesAndEngagements(contactId);
        
        // Assertions
        System.assertNotEquals(null, result, 'The result map should not be null even for null contactId');
        System.assert(result.containsKey('engagements') && result.get('engagements').isEmpty(), 'The engagements list should be empty for null contactId');
        System.assert(result.containsKey('services') && result.get('services').isEmpty(), 'The services list should be empty for null contactId');
        
        Test.stopTest();
    }
}
