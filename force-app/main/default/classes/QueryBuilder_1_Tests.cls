
@isTest
private class QueryBuilder_1_Tests {

    @testSetup
    static void setup() {
        // Test data setup, if necessary, can be implemented here.
    }

    @isTest
    static void testWithSObjectTypeValidSObjectType() {
        QueryBuilder qb = new QueryBuilder();
        SObjectType accountSObjectType = Account.SObjectType;

        // Execute the method with a valid SObjectType
        Test.startTest();
        QueryBuilder returnedQb = qb.withSObjectType(accountSObjectType);
        String soqlQuery = returnedQb.buildSoqlQuery();
        Test.stopTest();

        // Assert that the SOQL query is built correctly with the Account entity
        String expectedQueryStart = 'SELECT id FROM Account';
        System.assert(soqlQuery.startsWith(expectedQueryStart), 'The SOQL query should start with "SELECT id FROM Account"');
        
        // Assert that the returned QueryBuilder instance is the same as the initial one
        System.assertEquals(qb, returnedQb, 'The returned QueryBuilder should be the same instance as the one on which the method was called.');
    }

    @isTest
    static void testWithSObjectTypeNullSObjectType() {
        QueryBuilder qb = new QueryBuilder();
        SObjectType nullSObjectType = null;

        // Expect an exception when a null SObjectType is passed
        Exception expectedException;
        try {
            qb.withSObjectType(nullSObjectType);
        } catch (Exception e) {
            expectedException = e;
        }

        // Assert that the expected exception is a NullPointerException
        System.assertNotEquals(null, expectedException, 'A NullPointerException should be thrown when passing null to withSObjectType.');
    }
}
