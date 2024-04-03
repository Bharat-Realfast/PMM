
@isTest
private class PermissionValidator_11_Tests {
    
    @testSetup
    static void makeData() {
        // Note: No test data needed for permission checks
    }
    
    @isTest
    static void testHasObjectAccessCreatableTrue() {
        Test.startTest();
        SObjectType sObjectType = Account.sObjectType;
        Boolean hasAccess = PermissionValidator.getInstance().hasObjectAccess(sObjectType, PermissionValidator.CRUDAccessType.CREATEABLE);
        Test.stopTest();
        
        System.assertEquals(true, hasAccess, 'Users should have create access for Account object');
    }
    
    @isTest
    static void testHasObjectAccessReadableTrue() {
        Test.startTest();
        SObjectType sObjectType = Account.sObjectType;
        Boolean hasAccess = PermissionValidator.getInstance().hasObjectAccess(sObjectType, PermissionValidator.CRUDAccessType.READABLE);
        Test.stopTest();
        
        System.assertEquals(true, hasAccess, 'Users should have read access for Account object');
    }
    
    @isTest
    static void testHasObjectAccessUpdateableTrue() {
        Test.startTest();
        SObjectType sObjectType = Account.sObjectType;
        Boolean hasAccess = PermissionValidator.getInstance().hasObjectAccess(sObjectType, PermissionValidator.CRUDAccessType.UPDATEABLE);
        Test.stopTest();
        
        System.assertEquals(true, hasAccess, 'Users should have update access for Account object');
    }
    
    @isTest
    static void testHasObjectAccessDeleteableTrue() {
        Test.startTest();
        SObjectType sObjectType = Account.sObjectType;
        Boolean hasAccess = PermissionValidator.getInstance().hasObjectAccess(sObjectType, PermissionValidator.CRUDAccessType.DELETEABLE);
        Test.stopTest();
        
        System.assertEquals(true, hasAccess, 'Users should have delete access for Account object');
    }
    
    @isTest
    static void testHasObjectAccessWithNullSObjectType() {
        Test.startTest();
        SObjectType sObjectType = null;
        Boolean hasAccess = PermissionValidator.getInstance().hasObjectAccess(sObjectType, PermissionValidator.CRUDAccessType.READABLE);
        Test.stopTest();
        
        System.assertEquals(false, hasAccess, 'Access should be false when SObjectType is null');
    }
    // Additional tests would be created to simulate scenarios where the user does not have access.
    // This would typically involve mocking the responses or using a user with known limited permissions.
}
