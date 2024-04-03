
@isTest
private class ServiceDeliveryRollupsService_4_Tests {

    // Helper method to disable related triggers
    private static void disableTriggers() {
        // Replace the comments below with the actual trigger disabling code from your project
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    // Test the happy path scenario where the SObjectType is present in the map
    @isTest
    static void testGetDeliveryRollupsQueryWithValidSObjectType() {
        disableTriggers();
        
        Test.startTest();
        String query = (new ServiceDeliveryRollupsService()).getDeliveryRollupsQuery(Contact.SObjectType);
        Test.stopTest();
        
        System.assertNotEquals(null, query, 'Query should not be null for valid SObjectType');
        System.assert(query.contains('FROM ServiceDelivery__c'), 'Query should be for ServiceDelivery__c');
    }
    
    // Test the sad path scenario where the SObjectType is not present in the map
    @isTest
    static void testGetDeliveryRollupsQueryWithInvalidSObjectType() {
        disableTriggers();
        
        Test.startTest();
        String query = (new ServiceDeliveryRollupsService()).getDeliveryRollupsQuery(Account.SObjectType);
        Test.stopTest();
        
        System.assertEquals(null, query, 'Query should be null for invalid SObjectType');
    }

    // Test the exception scenario where the SObjectType is null
    @isTest
    static void testGetDeliveryRollupsQueryWithNullSObjectType() {
        disableTriggers();
        
        Test.startTest();
        String query = (new ServiceDeliveryRollupsService()).getDeliveryRollupsQuery(null);
        Test.stopTest();
        
        System.assertEquals(null, query, 'Query should be null for null SObjectType');
    }
}
