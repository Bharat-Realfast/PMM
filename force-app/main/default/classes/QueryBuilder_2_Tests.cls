
@isTest
private class QueryBuilder_2_Tests {

    @isTest
    static void testWithChildRelationshipNameHappyPath() {
        QueryBuilder queryBuilder = new QueryBuilder();
        String expectedChildRelName = 'Contacts';
        queryBuilder.withChildRelationshipName(expectedChildRelName);
        String soqlQuery = queryBuilder.buildSoqlQuery();
        System.assert(soqlQuery.contains('FROM ' + expectedChildRelName), 'The SOQL query should contain the FROM clause with the child relationship name.');
    }
    
    @isTest
    static void testWithChildRelationshipNameNull() {
        QueryBuilder queryBuilder = new QueryBuilder();
        Boolean exceptionThrown = false;
        try {
            queryBuilder.withChildRelationshipName(null).buildSoqlQuery();
        } catch (QueryBuilder.QueryBuilderException e) {
            exceptionThrown = true;
        }
        System.assert(exceptionThrown, 'Passing null as child relationship name should cause a QueryBuilderException.');
    }
    
    @isTest
    static void testWithChildRelationshipNameEmpty() {
        QueryBuilder queryBuilder = new QueryBuilder();
        queryBuilder.withChildRelationshipName('');
        String soqlQuery = queryBuilder.buildSoqlQuery();
        System.assert(soqlQuery.contains('FROM '), 'The SOQL query should contain a FROM clause even if the entity is an empty string.');
    }
    
    @isTest
    static void testWithChildRelationshipNameIntegratedWithBuildSoqlQuery() {
        QueryBuilder queryBuilder = new QueryBuilder().withChildRelationshipName('Contacts');
        String soqlQuery = queryBuilder.buildSoqlQuery();
        System.assert(soqlQuery.contains('FROM Contacts'), 'The SOQL query should contain the child relationship name set previously.');
    }
}
