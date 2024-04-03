
@isTest
private class RollupRecord_1_Tests {

    private static void bypassTriggers() {
        // Placeholder for trigger bypass, replace with actual project-specific code
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    @testSetup
    static void makeData() {
        // Initialize the test data for the RollupRecord tests
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
    }

    @isTest
    static void testGetSObjectAllFieldsSet() {
        bypassTriggers();

        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        RollupRecord rr = new RollupRecord(testAccount.Id);
        
        // Simulate setting the fields on RollupRecord
        rr.numPresentField = Account.NumberOfEmployees;
        rr.numAbsentField = Account.AnnualRevenue;
        // Assuming NumberOfLocations__c is a custom field on Account
        rr.consecutiveAbsencesField = Schema.Account.SObjectType.getDescribe().fields.getMap().get('NumberOfLocations__c');
        rr.lastServiceDateField = Account.LastActivityDate;
        
        rr.presentCount = 5;
        rr.absentCount = 3;
        rr.consecutiveCount = 2;
        rr.lastServiceDate = Date.today();
        
        SObject result = rr.getSObject();
        
        // Assertions to verify the SObject has been populated correctly
        System.assertEquals(rr.presentCount, (Integer)result.get(rr.numPresentField), 'The numPresentField should be set correctly');
        System.assertEquals(rr.absentCount, (Decimal)result.get(rr.numAbsentField), 'The numAbsentField should be set correctly');
        System.assertEquals(rr.consecutiveCount, (Integer)result.get(rr.consecutiveAbsencesField), 'The consecutiveAbsencesField should be set correctly');
        System.assertEquals(rr.lastServiceDate, (Date)result.get(rr.lastServiceDateField), 'The lastServiceDateField should be set correctly');
    }

    @isTest
    static void testGetSObjectNoFieldsSet() {
        bypassTriggers();

        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        RollupRecord rr = new RollupRecord(testAccount.Id);
        
        // Call the getSObject method without setting fields
        SObject result = rr.getSObject();
        
        // Assertions to verify no fields should be set
        System.assertNull(result.get(Account.NumberOfEmployees), 'The numPresentField should not be set');
        System.assertNull(result.get(Account.AnnualRevenue), 'The numAbsentField should not be set');
        // Assuming NumberOfLocations__c is a custom field on Account
        System.assertNull(result.get(Schema.Account.SObjectType.getDescribe().fields.getMap().get('NumberOfLocations__c')), 'The consecutiveAbsencesField should not be set');
        System.assertNull(result.get(Account.LastActivityDate), 'The lastServiceDateField should not be set');
    }

    @isTest
    static void testGetSObjectSomeFieldsSet() {
        bypassTriggers();

        Account testAccount = [SELECT Id FROM Account LIMIT 1];
        RollupRecord rr = new RollupRecord(testAccount.Id);
        
        // Set only some fields on the RollupRecord
        rr.numPresentField = Account.NumberOfEmployees;
        // Leave numAbsentField null
        // Assuming NumberOfLocations__c is a custom field on Account
        rr.consecutiveAbsencesField = Schema.Account.SObjectType.getDescribe().fields.getMap().get('NumberOfLocations__c');
        // Leave lastServiceDateField null
        
        rr.presentCount = 5;
        // Leave absentCount null
        rr.consecutiveCount = 2;
        // Leave lastServiceDate null
        
        SObject result = rr.getSObject();
        
        // Assertions to verify only some fields should be set
        System.assertEquals(rr.presentCount, (Integer)result.get(rr.numPresentField), 'The numPresentField should be set correctly');
        System.assertNull(result.get(Account.AnnualRevenue), 'The numAbsentField should not be set');
        System.assertEquals(rr.consecutiveCount, (Integer)result.get(rr.consecutiveAbsencesField), 'The consecutiveAbsencesField should be set correctly');
        System.assertNull(result.get(Account.LastActivityDate), 'The lastServiceDateField should not be set');
    }
}
