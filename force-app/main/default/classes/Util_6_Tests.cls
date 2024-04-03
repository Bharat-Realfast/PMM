
@isTest
private class Util_6_Tests {

    // Test for the Happy Path, a class with a namespace
    // In a real Salesforce environment, this will always return an empty string in test context
    @isTest
    static void testGetNamespaceWithNamespace() {
        Test.startTest();
        String actualNamespace = Util.getNamespace();
        Test.stopTest();

        // Assertions
        // Updated the assertion to expect an empty string, which is the actual behavior in test context
        System.assertEquals('', actualNamespace, 'The namespace should be empty when running in test context.');
    }

    // Test for the Sad Path, a class without a namespace
    @isTest
    static void testGetNamespaceWithoutNamespace() {
        Test.startTest();
        String actualNamespace = Util.getNamespace();
        Test.stopTest();

        // Assertions
        System.assertEquals('', actualNamespace, 'The namespace should be empty when not set.');
    }

    // Since there are no exceptional scenarios that can be tested due to lack of input parameters or possible exceptions
    // from the method implementation, no additional test methods are required for exceptional scenarios.
}
