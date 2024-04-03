
@isTest
private class SystemAccess_6_Tests {

    @testSetup
    static void makeTestData() {
        // Creating test data
        List<Account> accountList = new List<Account>();
        for(Integer i = 0; i < 5; i++) {
            accountList.add(new Account(Name = 'TestAccount' + i));
        }
        insert accountList;
    }

    @isTest
    static void testGetRecordsByIdWithValidParams() {
        List<Account> accounts = [SELECT Id FROM Account];
        Set<Id> accountIds = new Set<Id>();
        for(Account a : accounts) {
            accountIds.add(a.Id);
        }
        List<String> fields = new List<String>{'Id', 'Name'};

        Test.startTest();
        List<SObject> retrievedAccounts = new SystemAccess().getRecordsById(Account.SObjectType, accountIds, fields);
        Test.stopTest();

        System.assertEquals(accounts.size(), retrievedAccounts.size(), 'Should return correct number of records.');
        System.assertEquals(Account.SObjectType, retrievedAccounts[0].getSObjectType(), 'Should return records of type Account.');
    }

    @isTest
    static void testGetRecordsByIdWithEmptyIds() {
        Set<Id> accountIds = new Set<Id>();
        List<String> fields = new List<String>{'Id', 'Name'};

        Test.startTest();
        List<SObject> retrievedAccounts = new SystemAccess().getRecordsById(Account.SObjectType, accountIds, fields);
        Test.stopTest();

        System.assertEquals(0, retrievedAccounts.size(), 'Should return an empty list of records.');
    }

    @isTest
    static void testGetRecordsByIdWithEmptySelectFields() {
        List<Account> accounts = [SELECT Id FROM Account LIMIT 1];
        Set<Id> accountIds = new Set<Id>{accounts[0].Id};
        List<String> fields = new List<String>();

        Test.startTest();
        List<SObject> retrievedAccounts = new SystemAccess().getRecordsById(Account.SObjectType, accountIds, fields);
        Test.stopTest();

        System.assertEquals(0, retrievedAccounts.size(), 'Should return an empty list of records since no fields are selected.');
    }

    @isTest
    static void testGetRecordsByIdWithInvalidSObjectType() {
        Set<Id> accountIds = new Set<Id>{'001XXXXXXXXXXXXXXX'};
        List<String> fields = new List<String>{'Id', 'Name'};
        
        Test.startTest();
        try {
            new SystemAccess().getRecordsById(Task.SObjectType, accountIds, fields);
            System.assert(false, 'Should have thrown a QueryException due to invalid SObjectType');
        } catch (QueryException e) {
            System.assert(true, 'Expected QueryException was thrown');
        }
        Test.stopTest();
    }

    @isTest
    static void testGetRecordsByIdWithNullParams() {
        Test.startTest();
        try {
            new SystemAccess().getRecordsById(null, null, null);
            System.assert(false, 'Should have thrown a NullPointerException due to null parameters');
        } catch (NullPointerException e) {
            System.assert(true, 'Expected NullPointerException was thrown');
        }
        Test.stopTest();
    }
}
