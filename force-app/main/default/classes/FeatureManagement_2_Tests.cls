
@isTest
private class FeatureManagement_2_Tests {

    // Test method for setting a package integer with a null value.
    @isTest
    static void testSetPackageIntegerValueWithNullValue() {
        // Arrange
        String apiName = 'TestIntegerValue';
        Integer value = null;

        // Act and assert
        Test.startTest();
        try {
            FeatureManagement.getInstance().setPackageIntegerValue(apiName, value);
            System.assert(false, 'An exception should have been thrown due to null value.');
        } catch (Exception e) {
            System.assert(true, 'An exception was expected due to null value.');
        } finally {
            Test.stopTest();
        }
    }
}
