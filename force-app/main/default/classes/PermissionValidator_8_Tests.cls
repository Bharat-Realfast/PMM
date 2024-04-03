
@isTest
private class PermissionValidator_8_Tests {

    // Happy Path: User has update access to the field
    @isTest
    static void testHasUpdateAccessTrue() {
        // Use an updateable field from the Salesforce schema
        Schema.DescribeFieldResult fieldDescribe = Account.Name.getDescribe();
        
        PermissionValidator validator = PermissionValidator.getInstance();
        Boolean hasAccess = validator.hasFieldUpdateAccess(fieldDescribe);
        
        System.assertEquals(true, hasAccess, 'Expected update access to be true for updateable field.');
    }
    
    // Sad Path: User does not have update access to the field
    @isTest
    static void testHasUpdateAccessFalse() {
        // Use a non-updateable field from the Salesforce schema
        // Assuming 'CreatedDate' is non-updateable, which is typically true
        Schema.DescribeFieldResult fieldDescribe = Account.CreatedDate.getDescribe();
        
        PermissionValidator validator = PermissionValidator.getInstance();
        Boolean hasAccess = validator.hasFieldUpdateAccess(fieldDescribe);
        
        System.assertEquals(false, hasAccess, 'Expected update access to be false for non-updateable field.');
    }
}
