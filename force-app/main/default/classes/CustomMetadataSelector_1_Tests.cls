
@isTest
private class CustomMetadataSelector_1_Tests {
    
    // Since getInstance() does not interact with the database, 
    // we do not need a @testSetup method in this case.
    
    @isTest
    static void testGetInstanceReturnsInstance() {
        // Call getInstance and assert it returns an instance
        CustomMetadataSelector instance = CustomMetadataSelector.getInstance();
        System.assertNotEquals(null, instance, 'The getInstance method should return an instance');
    }
    
    @isTest
    static void testGetInstanceReturnsSameInstance() {
        // Call getInstance twice and compare the instances
        CustomMetadataSelector firstInstance = CustomMetadataSelector.getInstance();
        CustomMetadataSelector secondInstance = CustomMetadataSelector.getInstance();
        
        System.assertEquals(firstInstance, secondInstance, 'The getInstance method should return the same instance each time it is called');
    }
}
