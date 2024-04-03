
@isTest
private class ServiceDeliveryRollupsService_7_Tests {

    @testSetup
    static void setup() {
        // Create test data for Service__c, Contact, etc.
        // Actual creation of these records is not shown here and should conform to your schema
        // You should also create at least one ServiceDelivery__c record to associate with some parents
    }

    @isTest
    static void testResetParentsWithoutAssociatedDeliveries() {
        List<SObject> testParents = [SELECT Id, NumPresentServiceDeliveries__c FROM Contact];
        ServiceDeliveryRollupsService service = new ServiceDeliveryRollupsService();
        
        Test.startTest();
        service.resetParentsWithoutDeliveries(testParents);
        Test.stopTest();

        // Query the updated records and validate the rollup fields were reset
        List<Contact> updatedContacts = [SELECT Id, NumPresentServiceDeliveries__c FROM Contact WHERE Id IN :testParents];

        for (Contact c : updatedContacts) {
            System.assertEquals(null, c.NumPresentServiceDeliveries__c, 'The NumPresentServiceDeliveries__c field should be reset for parents without deliveries.');
        }
    }

    @isTest
    static void testResetParentsWithEmptyList() {
        List<SObject> testParents = new List<SObject>();
        ServiceDeliveryRollupsService service = new ServiceDeliveryRollupsService();
        
        Test.startTest();
        service.resetParentsWithoutDeliveries(testParents);
        Test.stopTest();

        // Since no action is expected, we simply check that no exception was thrown
        System.assert(true, 'Method should handle an empty list without exceptions.');
    }

    @isTest
    static void testResetParentsWithMixedSObjectTypes() {
        List<SObject> testParents = new List<SObject>{
            new Contact(FirstName = 'Test', LastName = 'Contact'),
            new Account(Name = 'Test Account')
        };
        insert testParents; // Insert the mixed SObjects to ensure they have Ids
        ServiceDeliveryRollupsService service = new ServiceDeliveryRollupsService();
        
        Test.startTest();
        service.resetParentsWithoutDeliveries(testParents);
        Test.stopTest();

        // Since we're testing that the method handles mixed SObject types without errors,
        // we assert that no exceptions are thrown and the method completes execution.
        System.assert(true, 'Method should handle mixed SObject types without throwing exceptions.');
    }
}
