
@isTest
private class SystemAccess_2_Tests {

    @testSetup
    static void setup() {
        // Create test data for ServiceDelivery__c records
        // Assuming ServiceDelivery__c and related objects exist in the schema
        
        // Create a parent record, e.g., Account for the lookup
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create related ServiceDelivery__c records
        ServiceDelivery__c delivery1 = new ServiceDelivery__c(
            // Set necessary fields, including the lookup to Account
            AttendanceStatus__c = 'Present',
            DeliveryDate__c = Date.today(),
            Quantity__c = 1,
            Account__c = testAccount.Id // Assuming the lookup field is Account__c
        );
        
        ServiceDelivery__c delivery2 = new ServiceDelivery__c(
            AttendanceStatus__c = 'Absent',
            DeliveryDate__c = Date.today(),
            Quantity__c = 2,
            Account__c = testAccount.Id
        );
        
        insert new List<ServiceDelivery__c>{ delivery1, delivery2 };
    }

    @isTest
    static void testGetDeliveryRollupsCountWithValidData() {
        // Query for the test Account record to use its ID in the test
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        
        // Instantiate the class and invoke the method
        SystemAccess systemAccess = new SystemAccess();
        Integer rollupsCount = systemAccess.getDeliveryRollupsCount('Account__c', testAccount.Id);
        
        // Assert the expected count of rollups is returned
        System.assertEquals(2, rollupsCount, 'The rollups count should be 2.');
    }

    @isTest
    static void testGetDeliveryRollupsCountWithInvalidLookupField() {
        // Query for the test Account record to use its ID in the test
        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        
        // Instantiate the class and invoke the method with an invalid field
        SystemAccess systemAccess = new SystemAccess();
        Integer rollupsCount = systemAccess.getDeliveryRollupsCount('Invalid__c', testAccount.Id);
        
        // Assert that the count is zero since the lookup field is invalid
        System.assertEquals(0, rollupsCount, 'The rollups count should be 0 for an invalid lookup field.');
    }

    @isTest
    static void testGetDeliveryRollupsCountWithInvalidRecordId() {
        // Instantiate the class and invoke the method with a non-existing record ID
        SystemAccess systemAccess = new SystemAccess();
        Integer rollupsCount = systemAccess.getDeliveryRollupsCount('Account__c', '001XXXXXXXXXXXXXXX');
        
        // Assert that the count is zero since the record ID is invalid
        System.assertEquals(0, rollupsCount, 'The rollups count should be 0 for a non-existing record ID.');
    }

    @isTest
    static void testGetDeliveryRollupsCountWithNullRecordId() {
        // Instantiate the class and invoke the method with a null record ID
        SystemAccess systemAccess = new SystemAccess();
        
        try {
            Integer rollupsCount = systemAccess.getDeliveryRollupsCount('Account__c', null);
            System.assert(false, 'The method did not throw an exception as expected.');
        } catch (Exception e) {
            System.assert(e instanceof QueryException, 'A QueryException should have been thrown.');
        }
    }
}
