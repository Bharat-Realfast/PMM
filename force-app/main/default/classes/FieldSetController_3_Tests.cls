
@isTest
private class FieldSetController_3_Tests {

    @isTest
    static void testGetFieldSetsByNameHappyPath() {
        // Happy path test
        Test.startTest();
        Map<String, Object> result = FieldSetController.getFieldSetsByName('Account');
        Test.stopTest();

        // Assert that the result is not null
        System.assertNotEquals(null, result, 'The result should not be null.');
        // Ideally, we would assert the contents of the result, but that requires access to the expected structure
    }

    @isTest
    static void testGetFieldSetsByNameWithInvalidObject() {
        // Test with an invalid object name
        String invalidObjectName = 'InvalidObject';
        Exception caughtException = null;

        Test.startTest();
        try {
            Map<String, Object> result = FieldSetController.getFieldSetsByName(invalidObjectName);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();

        // Assert that an exception was caught
        System.assertNotEquals(null, caughtException, 'An exception should have been thrown for an invalid object name.');
        // Assert that the caught exception is the expected type
        System.assert(caughtException instanceof AuraHandledException, 'The caught exception should be an AuraHandledException.');
    }

    @isTest
    static void testGetFieldSetsByNameWithNullObject() {
        // Test with a null object name
        Exception caughtException = null;

        Test.startTest();
        try {
            Map<String, Object> result = FieldSetController.getFieldSetsByName(null);
        } catch (Exception e) {
            caughtException = e;
        }
        Test.stopTest();

        // Assert that an exception was caught
        System.assertNotEquals(null, caughtException, 'An exception should have been thrown for a null object name.');
        // Assert that the caught exception is the expected type
        System.assert(caughtException instanceof AuraHandledException, 'The caught exception should be an AuraHandledException.');
    }
}
