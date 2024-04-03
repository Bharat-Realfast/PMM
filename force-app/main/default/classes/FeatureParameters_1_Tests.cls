
@isTest
private class FeatureParameters_1_Tests {
    
    // Test Setup to create necessary data for the tests
    @testSetup
    static void makeTestData() {
        // As there are no specific test data requirements for the getAll method, this setup is empty.
        // Add any specific setup here if required in the future.
    }

    // Test method for verifying the getAll method on happy path
    @isTest
    static void testGetAllHappyPath() {
        // Arrange
        Integer expectedCount = FeatureParameters.DeveloperName.values().size();
        
        // Act
        List<FeatureManagement.FeatureParameter> featureParameters = new FeatureParameters().getAll();

        // Assert
        System.assertNotEquals(null, featureParameters, 'The list of feature parameters should not be null.');
        System.assertEquals(expectedCount, featureParameters.size(), 'The list of feature parameters should have one entry per DeveloperName enum value.');
    }
}
