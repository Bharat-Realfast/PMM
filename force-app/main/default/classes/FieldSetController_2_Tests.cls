
@isTest
private class FieldSetController_2_Tests {
  
    // Since the target method doesn't perform any DML, we do not need to create test data.
    // However, if it would be necessary to test with specific field sets, a @testSetup method would be added here.

    // Test method for the happy path scenario with a valid object and field set
    @isTest
    static void testValidFieldByFieldPath() {
        // Assume that 'Account' object and 'AccountFieldSet' exist in org for test
        // Typical setup would involve creating metadata records here if needed
        Map<String, Map<String, Object>> result = FieldSetController.getFieldByFieldPath('Account', 'AccountFieldSet');

        // Assertions to ensure the method returns a non-null and non-empty map
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertTrue(result.size() > 0, 'Result map should contain field set details.');
    }

    // Test method for the happy path scenario with valid object and empty field set
    @isTest
    static void testValidEmptyFieldByFieldPath() {
        // Assuming 'Account' object and 'EmptyFieldSet' exist and it's empty in org for test
        Map<String, Map<String, Object>> result = FieldSetController.getFieldByFieldPath('Account', 'EmptyFieldSet');
        
        // Assertions to ensure the method returns a non-null but empty map
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertEquals(true, result.isEmpty(), 'Result should be an empty map.');
    }

    // Test method for the sad path scenario with valid object and invalid field set
    @isTest
    static void testInvalidFieldByFieldPath() {
        Exception caughtException = null;
        try {
            FieldSetController.getFieldByFieldPath('Account', 'NonExistentFieldSet');
        } catch (Exception e) {
            caughtException = e;
        }
        
        // Assertion to ensure that an exception is thrown
        System.assertNotEquals(null, caughtException, 'An exception should be thrown for invalid field set name.');
    }

    // Test method for the sad path scenario with invalid object and valid field set
    @isTest
    static void testInvalidObjectFieldByFieldPath() {
        Exception caughtException = null;
        try {
            FieldSetController.getFieldByFieldPath('InvalidObject', 'AccountFieldSet');
        } catch (Exception e) {
            caughtException = e;
        }
        
        // Assertion to ensure that an exception is thrown
        System.assertNotEquals(null, caughtException, 'An exception should be thrown for invalid object name.');
    }

    // Test method for the exceptional scenario with null parameters
    @isTest
    static void testNullParametersFieldByFieldPath() {
        Exception caughtException = null;
        try {
            FieldSetController.getFieldByFieldPath(null, null);
        } catch (Exception e) {
            caughtException = e;
        }
        
        // Assertion to ensure that an exception is thrown
        System.assertNotEquals(null, caughtException, 'An exception should be thrown for null parameters.');
    }
}
