
@isTest
private class PermissionValidator_3_Tests {

    @testSetup
    static void setup() {
        // Setup test data if necessary for checking field-level security
        // No need to insert data unless we are simulating real record interaction.
    }

    @isTest
    static void testHasFLSAccessForFields_HappyPath_StrictMode() {
        // Setup
        String objectName = 'Account';
        List<String> fields = new List<String>{'Name', 'Phone'};
        String operation = 'read';
        Boolean strictMode = true;

        // Execute
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields(objectName, fields, operation, strictMode);

        // Verify
        System.assert(result, 'User should have access to specified fields in strict mode.');
    }

    @isTest
    static void testHasFLSAccessForFields_HappyPath_NonStrictMode() {
        // Setup
        String objectName = 'Account';
        List<String> fields = new List<String>{'Name', 'Phone'};
        String operation = 'insert';
        Boolean strictMode = false;

        // Execute
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields(objectName, fields, operation, strictMode);

        // Verify
        System.assert(result, 'User should have access to specified fields in non-strict mode.');
    }

    @isTest
    static void testHasFLSAccessForFields_SadPath_NoAccess() {
        // Setup
        String objectName = 'Contact';
        List<String> fields = new List<String>{'NonExistingField'};
        String operation = 'update';
        Boolean strictMode = true;

        // Execute
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields(objectName, fields, operation, strictMode);

        // Verify
        System.assert(!result, 'User should not have access to non-existing fields.');
    }

    @isTest
    static void testHasFLSAccessForFields_SadPath_FieldNotExist_StrictMode() {
        // Setup
        String objectName = 'Account';
        List<String> fields = new List<String>{'NonExistingField'};
        String operation = 'read';
        Boolean strictMode = true;

        // Execute
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields(objectName, fields, operation, strictMode);

        // Verify
        System.assert(!result, 'Access should be denied if the field does not exist in strict mode.');
    }

    @isTest
    static void testHasFLSAccessForFields_SadPath_FieldNotExist_NonStrictMode() {
        // Setup
        String objectName = 'Account';
        List<String> fields = new List<String>{'NonExistingField'};
        String operation = 'read';
        Boolean strictMode = false;

        // Execute
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields(objectName, fields, operation, strictMode);

        // Verify
        System.assert(result, 'Access should be allowed if the field does not exist in non-strict mode.');
    }

    @isTest
    static void testHasFLSAccessForFields_ExceptionScenario() {
        // Setup
        String objectName = 'InvalidObjectName';
        List<String> fields = new List<String>{'Name'};
        String operation = 'read';
        Boolean strictMode = true;

        // Execute
        Boolean result = PermissionValidator.getInstance().hasFLSAccessForFields(objectName, fields, operation, strictMode);

        // Verify
        System.assert(!result, 'Access should be denied and handled gracefully on exception.');
    }
}
