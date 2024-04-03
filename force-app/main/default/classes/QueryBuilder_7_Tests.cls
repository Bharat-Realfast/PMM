
@isTest
private class QueryBuilder_7_Tests {
    
    @testSetup
    static void setup() {
        // Since this is a unit test for a utility class (QueryBuilder), there may not be a need for test data.
        // However, let's keep the method in case we need to setup common test records in the future.
    }
    
    @isTest
    static void testWithOrderByValidField() {
        // Given
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);

        // When
        qb.withOrderBy('Name');

        // Then
        String soql = qb.buildSoqlQuery();
        System.assert(soql.contains('ORDER BY Name'), 'The SOQL query should contain an ORDER BY clause for Name field');
    }

    @isTest
    static void testWithOrderByEmptyString() {
        // Given
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);

        // When
        qb.withOrderBy('');

        // Then
        String soql = qb.buildSoqlQuery();
        System.assert(!soql.contains('ORDER BY'), 'The SOQL query should not contain an ORDER BY clause when empty string is passed');
    }

    @isTest
    static void testWithOrderByNull() {
        // Given
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);

        // When
        qb.withOrderBy(null);

        // Then
        String soql = qb.buildSoqlQuery();
        System.assert(!soql.contains('ORDER BY'), 'The SOQL query should not contain an ORDER BY clause when null is passed');
    }
    
    // Note: We do not need to disable/bypass triggers as we are not performing any DML operations.
}
