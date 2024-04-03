
@isTest
private class QueryBuilder_6_Tests {

    // Common test setup data
    @testSetup
    static void setup() {
        // Create test data if necessary
    }

    // Test adding a valid condition
    @isTest
    static void testAddValidCondition() {
        String validCondition = 'Name = \'Salesforce\'';
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);
        qb.addCondition(validCondition);
        
        String query = qb.buildSoqlQuery();
        System.assert(query.contains(validCondition), 'Query should contain the valid condition');
        System.assert(!query.contains('AND AND'), 'Query should not contain consecutive AND operators');
    }

    // Test adding a null condition
    @isTest
    static void testAddNullCondition() {
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);
        qb.addCondition(null);
        
        String query = qb.buildSoqlQuery();
        System.assert(!query.contains('null'), 'Query should not contain the string "null"');
    }

    // Test adding an empty string as a condition
    @isTest
    static void testAddEmptyCondition() {
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);
        qb.addCondition('');
        
        String query = qb.buildSoqlQuery();
        System.assert(!query.toLowerCase().contains(' where '), 'Query should not contain a WHERE clause');
    }

    // Test adding a whitespace string as a condition
    @isTest
    static void testAddWhitespaceCondition() {
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);
        qb.addCondition('  ');
        
        String query = qb.buildSoqlQuery();
        System.assert(!query.toLowerCase().contains(' where '), 'Query should not contain a WHERE clause');
    }

    // As we are not performing any DML operations in these tests, we don't need to bypass triggers.
}
