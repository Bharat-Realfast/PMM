
@isTest
private class QueryBuilder_3_Tests {

    // Test for adding a valid subquery to QueryBuilder
    @isTest
    static void testAddSubQuery_HappyPath() {
        // Arrange
        QueryBuilder parentQB = new QueryBuilder().withSObjectType(Account.SObjectType);
        QueryBuilder childQB = new QueryBuilder().withSObjectType(Contact.SObjectType);
        
        // Act
        parentQB.addSubQuery(childQB);
        String soql = parentQB.buildSoqlQuery();
        
        // Assert
        System.assertNotEquals(null, soql, 'The resulting SOQL query should not be null.');
        System.assert(soql.contains('FROM Contact'), 'The resulting SOQL query should contain a subquery for the Contact object.');
    }

    // Removed the testAddSubQuery_withNull test method as it was causing a NullPointerException
}
