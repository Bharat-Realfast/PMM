
@isTest
private class SystemAccess_1_Tests {
    // Use @testSetup to create common test data
    @testSetup
    static void setup() {
        // Create test data if needed
    }

    // Happy Path
    @isTest
    static void testGetDeliveryRollupsQueryWithValidLookupField() {
        // Prepare data & environment
        String validLookupField = 'Contact__c'; // Assuming 'Contact__c' is a valid field on ServiceDelivery__c
        
        // Execute target method
        SystemAccess systemAccess = new SystemAccess();
        String query = systemAccess.getDeliveryRollupsQuery(validLookupField);
        
        // Assert
        System.assertNotEquals(null, query, 'Query should not be null');
        System.assert(query.contains('Contact__c'), 'Query should contain the lookupField');
    }
    
    // Sad Path
    @isTest
    static void testGetDeliveryRollupsQueryWithInvalidLookupField() {
        // Prepare data & environment
        String invalidLookupField = 'InvalidField__c';
        
        // Execute target method
        SystemAccess systemAccess = new SystemAccess();
        String query = systemAccess.getDeliveryRollupsQuery(invalidLookupField);
        
        // Assert
        System.assertNotEquals(null, query, 'Query should not be null');
        System.assert(query.contains('InvalidField__c'), 'Query should contain the invalid lookupField');
    }
    
    // Exceptional Scenario
    @isTest
    static void testGetDeliveryRollupsQueryWithNullLookupField() {
        // Prepare data & environment
        String nullLookupField = null;
        
        // Execute target method and handle the exception
        SystemAccess systemAccess = new SystemAccess();
        
        try {
            String query = systemAccess.getDeliveryRollupsQuery(nullLookupField);
            System.fail('Method did not throw with null lookupField');
        } catch (Exception e) {
            // Assert
            System.assert(e.getMessage().contains('Argument cannot be null'), 'Proper exception message should be thrown');
        }
    }
}
