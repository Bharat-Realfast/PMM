
@isTest
private class FeatureManagement_1_Tests {

    @isTest
    static void testGetInstanceReturnsInstance() {
        // Call the method and assert it returns an instance
        FeatureManagement instance = FeatureManagement.getInstance();
        System.assertNotEquals(null, instance, 'The getInstance method should return a non-null instance.');
    }

    @isTest
    static void testGetInstanceReturnsSingleInstance() {
        // Call the method twice and assert both calls return the same instance
        FeatureManagement firstInstance = FeatureManagement.getInstance();
        FeatureManagement secondInstance = FeatureManagement.getInstance();
        System.assertEquals(firstInstance, secondInstance, 'Both method calls should return the same instance.');
    }
}
