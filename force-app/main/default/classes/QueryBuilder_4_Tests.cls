
@isTest
public class QueryBuilder_4_Tests {

    @testSetup
    static void setup() {
        // As per the instructions, we are not required to insert any test data
        // for this particular test class
    }
    
    @isTest
    static void testWithSelectFieldsWithValidFields() {
        // Test with a valid list of field names
        List<String> fields = new List<String>{'Name', 'Email', 'Phone'};
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);
        qb = qb.withSelectFields(fields);
        
        // Assertions to check if the fields were added correctly
        String soqlQuery = qb.buildSoqlQuery();
        System.assert(soqlQuery.toLowerCase().contains('name'), 'Name field should be present in the SOQL query');
        System.assert(soqlQuery.toLowerCase().contains('email'), 'Email field should be present in the SOQL query');
    }
    
    @isTest
    static void testWithSelectFieldsWithEmptyList() {
        // Test with an empty list of field names
        List<String> fields = new List<String>();
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);
        qb = qb.withSelectFields(fields);
        
        // Assertions to check if the empty fields do not alter the query
        String soqlQuery = qb.buildSoqlQuery();
        System.assert(soqlQuery.contains('FROM Account'), 'The query should contain FROM Account');
        System.assert(!soqlQuery.contains(','), 'There should be no fields in the SOQL query');
    }
    
    @isTest
    static void testWithSelectFieldsWithNull() {
        // Test with a null list of field names
        QueryBuilder qb = new QueryBuilder().withSObjectType(Account.SObjectType);
        qb = qb.withSelectFields((List<String>)null);
        
        // Assertions to check if null input does not cause any issues
        try {
            String soqlQuery = qb.buildSoqlQuery();
            System.assert(soqlQuery.contains('FROM Account'), 'The query should contain FROM Account');
            System.assert(!soqlQuery.contains(','), 'There should be no fields in the SOQL query');
        } catch (Exception e) {
            System.assert(false, 'Exception should not be thrown when passing null to withSelectFields');
        }
    }
}
