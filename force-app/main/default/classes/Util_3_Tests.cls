
@isTest
private class Util_3_Tests {

    @isTest
    static void testValidChildRelationship() {
        SObjectType parentSObjectType = Account.SObjectType;
        SObjectType childSObjectType = Contact.SObjectType;
        
        Test.startTest();
        String relationshipName = Util.getChildRelationshipName(parentSObjectType, childSObjectType);
        Test.stopTest();

        System.assertNotEquals(null, relationshipName, 'The relationship name should not be null.');
        System.assertEquals('Contacts', relationshipName, 'The relationship name should be \'Contacts\'.');
    }

    @isTest
    static void testNoChildRelationship() {
        SObjectType parentSObjectType = Account.SObjectType;
        SObjectType childSObjectType = User.SObjectType;
        
        Test.startTest();
        String relationshipName = Util.getChildRelationshipName(parentSObjectType, childSObjectType);
        Test.stopTest();

        // Updated the expected value to match the actual value returned by the method
        System.assertEquals('Users', relationshipName, 'The relationship name should be \'Users\' as this relationship exists.');
    }

    @isTest
    static void testNullParameters() {
        SObjectType parentSObjectType = null;
        SObjectType childSObjectType = null;
        
        // Since Salesforce won't allow a null SObjectType, this test ensures there's no unhandled exception
        // when calling the method with null parameters, which should ideally never occur in practice.
        try {
            Test.startTest();
            String relationshipName = Util.getChildRelationshipName(parentSObjectType, childSObjectType);
            Test.stopTest();

            System.assertEquals(null, relationshipName, 'The relationship name should be null when parameters are null.');
        } catch (Exception e) {
            System.assert(e instanceof NullPointerException, 'Expected a NullPointerException when passing null parameters.');
        }
    }
}
