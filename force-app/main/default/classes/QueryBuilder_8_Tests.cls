
@isTest
private class QueryBuilder_8_Tests {
    
    @testSetup
    static void setup() {
        // Setting up mock data if necessary for the QueryBuilder
        // For this case, no specific setup is required since we are testing the method behavior itself
    }
    
    @isTest
    static void testWithLimitHappyPath() {
        QueryBuilder qb = new QueryBuilder();
        qb.withSObjectType(Account.SObjectType); // Set the SObjectType to Account
        qb.withLimit(10);
        String soql = qb.buildSoqlQuery();
        
        // Assert the query string contains the LIMIT clause
        System.assert(soql.contains('LIMIT 10'), 'Query should contain LIMIT 10');
    }
    
    @isTest
    static void testWithLimitNegativeValue() {
        QueryBuilder qb = new QueryBuilder();
        qb.withSObjectType(Account.SObjectType); // Set the SObjectType to Account
        qb.withLimit(-5);
        String soql = qb.buildSoqlQuery();
        
        // Assert the query does not contain the LIMIT clause
        System.assert(!soql.contains('LIMIT'), 'Negative limit should not add LIMIT clause');
    }
    
    @isTest
    static void testWithLimitNullValue() {
        QueryBuilder qb = new QueryBuilder();
        qb.withSObjectType(Account.SObjectType); // Set the SObjectType to Account
        qb.withLimit(null);
        String soql = qb.buildSoqlQuery();
        
        // Assert the query does not contain the LIMIT clause
        System.assert(!soql.contains('LIMIT'), 'NULL limit should not add LIMIT clause');
    }
    
    @isTest
    static void testWithLimitZeroValue() {
        QueryBuilder qb = new QueryBuilder();
        qb.withSObjectType(Account.SObjectType); // Set the SObjectType to Account
        qb.withLimit(0);
        String soql = qb.buildSoqlQuery();
        
        // Assert the query does not contain the LIMIT clause
        System.assert(!soql.contains('LIMIT'), 'Zero limit should not add LIMIT clause');
    }
}
