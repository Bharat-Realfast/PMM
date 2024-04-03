
@isTest
private class PermissionValidator_2_Tests {

    // Since we are only testing field-level security (FLS) without DML operations, there is no need for test setup data or bypassing triggers.

    // Happy Path Test: User has access to all fields for the specified operation
    @isTest
    static void testHasFLSAccessForFieldsAllAccess() {
        List<String> fields = new List<String>{'Name', 'Phone'};
        String operation = 'read';
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields('Account', fields, operation);
        System.assert(result, 'User should have access to all specified fields');
    }
    
    // Happy Path Test: User has access to some fields and strictMode is false
    @isTest
    static void testHasFLSAccessForFieldsPartialAccessNonStrict() {
        List<String> fields = new List<String>{'Name', 'NonExistentField'};
        String operation = 'read';
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields('Account', fields, operation, false);
        System.assert(result, 'User should have access to existing fields with non-strict mode');
    }

    // Sad Path Test: User lacks access to one or more fields for the specified operation
    @isTest
    static void testHasFLSAccessForFieldsNoAccess() {
        List<String> fields = new List<String>{'Name', 'NonAccessibleField'};
        String operation = 'insert';
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields('Account', fields, operation);
        System.assert(!result, 'User should not have access to one or more specified fields');
    }

    // Sad Path Test: Field does not exist in object schema and strictMode is true
    @isTest
    static void testHasFLSAccessForFieldsFieldNotExistStrict() {
        List<String> fields = new List<String>{'Name', 'NonExistentField'};
        String operation = 'read';
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields('Account', fields, operation, true);
        System.assert(!result, 'User should not have access when field does not exist in strict mode');
    }

    // Exceptional Scenario Test: Invalid object API name
    @isTest
    static void testHasFLSAccessForFieldsInvalidObject() {
        List<String> fields = new List<String>{'Name', 'Phone'};
        String operation = 'read';
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields('InvalidObject', fields, operation);
        System.assert(!result, 'Invalid object API name should result in false due to exception handling');
    }
}
