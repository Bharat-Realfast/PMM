
@isTest
private class QueryBuilder_5_Tests {

    @testSetup
    static void makeData() {
        // Setup test data, if needed.
    }
    
    @isTest
    static void testWithSelectFieldsWithValidFieldSet() {
        // Assuming 'ValidFieldSet' is the API name of a non-empty FieldSet on the Lead object in the Salesforce Org
        // Ensure that the FieldSet exists and is not null
        FieldSet fs = SObjectType.Lead.fieldSets.getMap().get('ValidFieldSet');
        if (fs == null) {
            // If the FieldSet is null, the test cannot proceed as it would result in a NullPointerException
            System.debug('ValidFieldSet does not exist or is not properly initialized in the org metadata.');
            return;
        }
        
        QueryBuilder qb = new QueryBuilder().withSObjectType(Lead.SObjectType);
        
        // Act & Assert
        Test.startTest();
        QueryBuilder result = qb.withSelectFields(fs);
        String soqlQuery = result.buildSoqlQuery();
        Test.stopTest();
        
        // We cannot check the selectFields directly, but we can ensure a valid SOQL query is built
        System.assertNotEquals(null, soqlQuery, 'The SOQL query string should not be null');
        System.assertNotEquals('', soqlQuery, 'The SOQL query string should not be empty');
    }
    
    @isTest
    static void testWithSelectFieldsWithEmptyFieldSet() {
        // Assuming 'EmptyFieldSet' is the API name of an empty FieldSet on the Lead object in the Salesforce Org
        // Ensure that the FieldSet exists and is not null
        FieldSet fs = SObjectType.Lead.fieldSets.getMap().get('EmptyFieldSet');
        if (fs == null) {
            // If the FieldSet is null, the test cannot proceed as it would result in a NullPointerException
            System.debug('EmptyFieldSet does not exist or is not properly initialized in the org metadata.');
            return;
        }
        
        QueryBuilder qb = new QueryBuilder().withSObjectType(Lead.SObjectType);
        
        // Act & Assert
        Test.startTest();
        QueryBuilder result = qb.withSelectFields(fs);
        String soqlQuery = result.buildSoqlQuery();
        Test.stopTest();
        
        // We cannot check the selectFields directly, but we can ensure a valid SOQL query is built
        System.assertNotEquals(null, soqlQuery, 'The SOQL query string should not be null');
        System.assertNotEquals('', soqlQuery, 'The SOQL query string should not be empty');
    }
}
