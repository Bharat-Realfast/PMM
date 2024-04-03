
@isTest
private class QueryBuilder_9_Tests {

    // Test setup to create any necessary data
    @testSetup
    static void setup() {
        // In this case, there's no need for test data since we are testing query string building functionality
    }
    
    // Test for happy path scenario
    @isTest
    static void testBuildSoqlQueryComplete() {
        QueryBuilder qb = new QueryBuilder()
            .withSObjectType(Account.SObjectType)
            .withSelectFields(new List<String>{'Name', 'BillingCity'})
            .addCondition('Name = \'Acme\'')
            .withOrderBy('Name')
            .withLimit(10);
        
        String soql = qb.buildSoqlQuery();
        
        System.assert(soql.contains('SELECT'), 'Soql should contain SELECT');
        System.assert(soql.contains('FROM Account'), 'Soql should contain FROM Account');
    }
    
    // Additional test methods would go here, following the same pattern
    // Each method would test a different scenario as identified earlier
}
