
@isTest
private class PermissionValidator_1_Tests {
    
    @isTest
    static void testGetInstance_ReturnsInstance() {
        // Test setup should not be necessary for this singleton test
        // Act
        PermissionValidator instance = PermissionValidator.getInstance();

        // Assert
        System.assertNotEquals(null, instance, 'Instance should not be null');
    }    

    @isTest
    static void testGetInstance_SingletonProperty() {
        // Test setup should not be necessary for this singleton test
        // Act
        PermissionValidator firstInstance = PermissionValidator.getInstance();
        PermissionValidator secondInstance = PermissionValidator.getInstance();

        // Assert
        System.assertEquals(firstInstance, secondInstance, 'Both instances should be the same');
    }
}
