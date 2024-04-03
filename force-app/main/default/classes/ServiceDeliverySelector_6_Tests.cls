
@isTest
private class ServiceDeliverySelector_6_Tests {
    @testSetup
    static void setup() {
        // Create test data for ServiceSession__c
        ServiceSession__c testSession = new ServiceSession__c(
            // Populate required fields
        );
        insert testSession;
    }

    @isTest
    static void testGetSessionHappyPath() {
        // Setup test data
        ServiceSession__c existingSession = [SELECT Id FROM ServiceSession__c LIMIT 1];

        Test.startTest();
        // Call the method with a valid session ID
        ServiceSession__c result = new ServiceDeliverySelector().getSession(existingSession.Id);
        Test.stopTest();

        // Validate the returned session
        System.assertNotEquals(null, result, 'The session should not be null.');
        System.assertEquals(existingSession.Id, result.Id, 'The session ID should match.');
    }

    @isTest
    static void testGetSessionSadPath() {
        Test.startTest();
        // Call the method with a non-existing session ID
        ServiceSession__c result = new ServiceDeliverySelector().getSession('a1Sxx00000000xxEAA');
        Test.stopTest();

        // Validate that null is returned
        System.assertEquals(null, result, 'The result should be null for a non-existing session.');
    }
}
