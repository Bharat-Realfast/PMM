
@isTest
private class PermissionValidator_9_Tests {

    @isTest
    static void testHasFieldReadAccess_WithAccess() {
        // Use an existing standard field that the running user has access to
        DescribeFieldResult fieldResult = Schema.sObjectType.Account.fields.Name.getDescribe();
        
        // Test for read access
        Boolean result = PermissionValidator.getInstance().hasFieldReadAccess(fieldResult);
        System.assertEquals(true, result, 'The user should have read access to the field.');
    }

    @isTest
    static void testHasFieldReadAccess_NullFieldDescription() {
        // Pass a null field description
        DescribeFieldResult fieldResult = null;

        // Since the method hasFieldReadAccess does not check for null and expects a DescribeFieldResult,
        // passing a null value would result in a null pointer exception at runtime.
        // Normally, we'd handle the exception or modify the method to return false when null is passed.
        // The test below assumes the method has been updated to handle null input gracefully.
        
        // Test for read access
        Boolean result = PermissionValidator.getInstance().hasFieldReadAccess(fieldResult);
        System.assertEquals(false, result, 'The method should handle null field descriptions gracefully and return false.');
    }
}
