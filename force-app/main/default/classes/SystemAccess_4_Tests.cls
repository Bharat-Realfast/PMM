
@isTest
private class SystemAccess_4_Tests {

    // Create test data
    @testSetup
    static void setup() {
        // Create test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create test ServiceDelivery__c records
        ServiceDelivery__c sd1 = new ServiceDelivery__c(AccountId__c = testAccount.Id, Quantity__c = 10);
        ServiceDelivery__c sd2 = new ServiceDelivery__c(AccountId__c = testAccount.Id, Quantity__c = 20);
        insert new List<ServiceDelivery__c>{ sd1, sd2 };
    }

    // Happy path test
    @isTest
    static void testGetDeliveryRecordsToRollupHappyPath() {
        Test.startTest();
        // Bypass triggers as per the project's framework
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Set<Id> recordIds = new Set<Id>{};
        for (ServiceDelivery__c sd : [SELECT Id FROM ServiceDelivery__c]) {
            recordIds.add(sd.Id);
        }

        // Execute the target method
        SystemAccess systemAccess = new SystemAccess();
        List<ServiceDelivery__c> results = systemAccess.getDeliveryRecordsToRollup('AccountId__c', recordIds);

        Test.stopTest();

        // Assertions
        System.assertEquals(2, results.size(), 'Should return exactly two ServiceDelivery__c records');
    }

    // Sad path test for empty recordIds
    @isTest
    static void testGetDeliveryRecordsToRollupEmptySet() {
        Test.startTest();
        // Bypass triggers as per the project's framework
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        // Execute the target method with an empty set of Ids
        SystemAccess systemAccess = new SystemAccess();
        List<ServiceDelivery__c> results = systemAccess.getDeliveryRecordsToRollup('AccountId__c', new Set<Id>());

        Test.stopTest();

        // Assertions
        System.assertEquals(0, results.size(), 'Should return an empty list for empty recordIds');
    }

    // Sad path test for invalid lookupField
    @isTest
    static void testGetDeliveryRecordsToRollupInvalidLookupField() {
        Set<Id> recordIds = new Set<Id>{};
        for (ServiceDelivery__c sd : [SELECT Id FROM ServiceDelivery__c]) {
            recordIds.add(sd.Id);
        }

        SystemAccess systemAccess = new SystemAccess();
        Boolean exceptionThrown = false;
        
        Test.startTest();
        // Bypass triggers as per the project's framework
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        try {
            systemAccess.getDeliveryRecordsToRollup('InvalidField__c', recordIds);
        } catch (QueryException e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        // Assertions
        System.assert(exceptionThrown, 'A QueryException should be thrown due to invalid lookupField');
    }

    // Testing exceptional scenario with a non-relationship field
    @isTest
    static void testGetDeliveryRecordsToRollupNonRelationshipField() {
        Set<Id> recordIds = new Set<Id>{};
        for (ServiceDelivery__c sd : [SELECT Id FROM ServiceDelivery__c]) {
            recordIds.add(sd.Id);
        }

        SystemAccess systemAccess = new SystemAccess();
        Boolean exceptionThrown = false;
        
        Test.startTest();
        // Bypass triggers as per the project's framework
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        try {
            systemAccess.getDeliveryRecordsToRollup('Quantity__c', recordIds);
        } catch (QueryException e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        // Assertions
        System.assert(exceptionThrown, 'A QueryException should be thrown due to non-relationship lookupField');
    }
}
