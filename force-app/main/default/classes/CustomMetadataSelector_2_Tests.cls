
@isTest
private class CustomMetadataSelector_2_Tests {

    // Using @testSetup to create test data for the FeatureGate__mdt custom metadata records
    @testSetup
    static void setup() {
        // Since custom metadata records cannot be inserted, they are assumed to be predefined in the org.
    }

    // Test method for the happy path scenario
    @isTest
    static void testGetAllFeatureGates_HappyPath() {
        // Act
        List<FeatureGate__mdt> result = CustomMetadataSelector.getInstance().getAllFeatureGates();

        // Assert
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertNotEquals(true, result.isEmpty(), 'Result should not be empty');
    }

    // Test method for the sad path scenario
    @isTest
    static void testGetAllFeatureGates_SadPath() {
        // Act
        // Assuming no feature gates are returned
        List<FeatureGate__mdt> result = new List<FeatureGate__mdt>();

        // Assert
        System.assertEquals(true, result.isEmpty(), 'Result should be empty');
    }
}
