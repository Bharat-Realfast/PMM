
@isTest
private class QueryBuilder_11_Tests {

    @isTest
    static void testResetMethodClearsAllFields() {
        // Given a QueryBuilder instance with some state
        QueryBuilder qb = new QueryBuilder();
        qb.withSObjectType(Account.SObjectType)
          .withSelectFields(new List<String>{'Name', 'BillingCity'})
          .addCondition('Name = \'Salesforce\'')
          .withOrderBy('CreatedDate')
          .withLimit(50);
          
        // When reset method is called
        qb.reset();
        
        // Then an exception should be thrown when trying to build a query
        Boolean exceptionThrown = false;
        Test.startTest();
        try {
            qb.buildSoqlQuery();
        } catch (QueryBuilder.QueryBuilderException e) {
            exceptionThrown = true;
        }
        Test.stopTest();
        
        // Assert that an exception is thrown
        System.assert(exceptionThrown, 'An exception should be thrown when trying to build a query after reset');
    }

    @isTest
    static void testResetMethodOnAlreadyResetInstance() {
        // Given a QueryBuilder instance that is already reset
        QueryBuilder qb = new QueryBuilder();
        qb.reset();
        
        // When reset method is called again
        qb.reset();
        
        // Then there should be no change in state
        Test.startTest();
        String query;
        try {
            query = qb.buildSoqlQuery(); // This should throw an exception since entity is null after reset
        } catch (QueryBuilder.QueryBuilderException e) {
            query = null;
        }
        Test.stopTest();
        
        // Assert that an exception is thrown due to the QueryBuilder being in a reset (invalid) state
        System.assert(query == null, 'Query should be null as the QueryBuilder should throw an exception when building a query with no entity set');
    }
}
