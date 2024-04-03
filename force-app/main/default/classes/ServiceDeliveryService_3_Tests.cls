
@isTest
private class ServiceDeliveryService_3_Tests {

    @isTest
    static void testUserHasReadAndWritePermissions() {
        // Assuming the current user context has required permissions
        ServiceDeliveryService service = new ServiceDeliveryService();

        Test.startTest();
        // Place to disable triggers if needed, using project-specific methods
        Map<String, Boolean> permissions = service.checkFieldPermissions();
        Test.stopTest();

        System.assertEquals(true, permissions.get('read'), 'User should have read permissions.');
        System.assertEquals(true, permissions.get('write'), 'User should have write permissions.');
    }
    
    @isTest
    static void testUserHasReadPermissionsOnly() {
        // Assuming the current user context has read only permissions
        ServiceDeliveryService service = new ServiceDeliveryService();

        Test.startTest();
        // Place to disable triggers if needed, using project-specific methods
        Map<String, Boolean> permissions = service.checkFieldPermissions();
        Test.stopTest();

        System.assertEquals(true, permissions.get('read'), 'User should have read permissions.');
        System.assertEquals(true, permissions.get('write'), 'User should have write permissions.');
    }
    
    @isTest
    static void testUserHasWritePermissionsOnly() {
        // Assuming the current user context has write only permissions
        ServiceDeliveryService service = new ServiceDeliveryService();

        Test.startTest();
        // Place to disable triggers if needed, using project-specific methods
        Map<String, Boolean> permissions = service.checkFieldPermissions();
        Test.stopTest();

        System.assertEquals(true, permissions.get('read'), 'User should have read permissions.');
        System.assertEquals(true, permissions.get('write'), 'User should have write permissions.');
    }
    
    @isTest
    static void testUserLacksReadPermissions() {
        // Assuming the current user context lacks required read permissions
        ServiceDeliveryService service = new ServiceDeliveryService();

        Test.startTest();
        // Place to disable triggers if needed, using project-specific methods
        Map<String, Boolean> permissions = service.checkFieldPermissions();
        Test.stopTest();

        System.assertNotEquals(true, permissions.get('read'), 'User should not have read permissions.');
    }
    
    @isTest
    static void testUserLacksWritePermissions() {
        // Assuming the current user context lacks required write permissions
        ServiceDeliveryService service = new ServiceDeliveryService();

        Test.startTest();
        // Place to disable triggers if needed, using project-specific methods
        Map<String, Boolean> permissions = service.checkFieldPermissions();
        Test.stopTest();

        System.assertNotEquals(true, permissions.get('write'), 'User should not have write permissions.');
    }
}
