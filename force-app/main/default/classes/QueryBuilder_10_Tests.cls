
@isTest
private class QueryBuilder_10_Tests {

    // Since we are not performing any DML operations in buildCountQuery, we don't need testSetup or trigger bypassing.
    
    @isTest
    static void testBuildCountQueryWithoutConditions() {
        // Arrange
        QueryBuilder qb = new QueryBuilder();
        qb.withSObjectType(Account.SObjectType);
        
        // Act
        String soql = qb.buildCountQuery();
        
        // Assert
        System.assert(soql.contains('FROM Account'), 'The query should contain FROM Account');
        System.assert(!soql.contains('WHERE'), 'The query should not contain a WHERE clause');
    }
    
    @isTest
    static void testBuildCountQueryWithConditions() {
        // Arrange
        QueryBuilder qb = new QueryBuilder();
        qb.withSObjectType(Contact.SObjectType);
        qb.addCondition('LastName = \'Doe\'');
        
        // Act
        String soql = qb.buildCountQuery();
        
        // Assert
        System.assert(soql.contains('FROM Contact'), 'The query should contain FROM Contact');
        System.assert(soql.contains('WHERE LastName = \'Doe\''), 'The query should contain a WHERE clause with the condition');
    }
    
    @isTest
    static void testBuildCountQueryNoEntity() {
        // Arrange
        QueryBuilder qb = new QueryBuilder();
        
        // Act
        Boolean didThrowException = false;
        try {
            String soql = qb.buildCountQuery();
        } catch (QueryBuilder.QueryBuilderException e) {
            didThrowException = true;
        }
        
        // Assert
        System.assert(didThrowException, 'An exception should have been thrown due to the missing SObjectType');
    }
}
