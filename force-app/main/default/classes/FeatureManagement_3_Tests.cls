
@isTest
private class FeatureManagement_3_Tests {
    
    @testSetup
    static void setup() {
        // Normally we would create test data here, but for this scenario, no test data is needed.
    }

    @isTest
    static void testCheckPackageIntegerValue_NotExists() {
        // Given an apiName that does not exist
        String apiName = 'NonexistentFeature';

        // When we call checkPackageIntegerValue, we expect an exception to be thrown
        try {
            Integer actualValue = FeatureManagement.getInstance().checkPackageIntegerValue(apiName);
            System.assert(false, 'Method should have thrown an exception for a non-existing feature parameter.');
        } catch (System.NoDataFoundException e) {
            // Then a NoDataFoundException should be thrown
            System.assert(e.getMessage().contains('No results found'), 'Exception should contain "No results found".');
        }
    }

    @isTest
    static void testCheckPackageIntegerValue_NullApiName() {
        // Given a null apiName
        String apiName = null;

        // When we call checkPackageIntegerValue with a null apiName
        Integer actualValue = FeatureManagement.getInstance().checkPackageIntegerValue(apiName);
        
        // Then the method should handle the null input gracefully and return null
        System.assert(actualValue == null, 'Method should return null when apiName is null.');
    }
}
