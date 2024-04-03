
@isTest
private class PermissionValidator_4_Tests {

    @isTest
    static void testHasFLSAccessForFieldInsertAccessGranted() {
        Schema.SObjectField field = Account.Name;
        String operation = 'insert';

        Boolean hasAccess = PermissionValidator.getInstance().hasFLSAccessForFields(field, operation);
        
        System.assert(hasAccess, 'User should have insert access on the field.');
    }
    
    @isTest
    static void testHasFLSAccessForFieldReadAccessGranted() {
        Schema.SObjectField field = Account.Industry;
        String operation = 'read';

        Boolean hasAccess = PermissionValidator.getInstance().hasFLSAccessForFields(field, operation);
        
        System.assert(hasAccess, 'User should have read access on the field.');
    }
    
    @isTest
    static void testHasFLSAccessForFieldUpdateAccessGranted() {
        Schema.SObjectField field = Account.Industry;
        String operation = 'update';

        Boolean hasAccess = PermissionValidator.getInstance().hasFLSAccessForFields(field, operation);
        
        System.assert(hasAccess, 'User should have update access on the field.');
    }
    
    @isTest
    static void testHasFLSAccessForFieldUpsertAccessGranted() {
        Schema.SObjectField field = Account.Industry;
        String operation = 'upsert';

        Boolean hasAccess = PermissionValidator.getInstance().hasFLSAccessForFields(field, operation);
        
        System.assert(hasAccess, 'User should have upsert access on the field.');
    }
}
