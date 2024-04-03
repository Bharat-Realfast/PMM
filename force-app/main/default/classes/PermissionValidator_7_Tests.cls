
@isTest
private class PermissionValidator_7_Tests {

    @testSetup
    static void setup() {
        // Any required setup data
    }

    // Disabling triggers is not necessary for these tests as we are not doing any DML operations
    // However, if you had to disable triggers for DML operations, you would use:
    // TriggerHandler.bypass('AccountTriggerHandler');
    // TriggerHandler.bypass('MDTAccountTriggerHandler');

    @isTest
    static void testHasFieldUpsertAccess_True() {
        // Scenario: The field is both creatable and updateable

        // Mock DescribeFieldResult with both isCreateable and isUpdateable returning true
        Schema.DescribeFieldResult mockFieldResult = createMockDescribeFieldResult(true, true);

        Boolean hasAccess = PermissionValidator.getInstance().hasFieldUpsertAccess(mockFieldResult);
        
        System.assertEquals(true, hasAccess, 'Field should be upsertable when it is both creatable and updateable.');
    }

    @isTest
    static void testHasFieldUpsertAccess_False_CreatableOnly() {
        // Scenario: Field is creatable but not updateable

        // Mock DescribeFieldResult with isCreateable returning true and isUpdateable returning false
        Schema.DescribeFieldResult mockFieldResult = createMockDescribeFieldResult(true, false);

        Boolean hasAccess = PermissionValidator.getInstance().hasFieldUpsertAccess(mockFieldResult);
        
        System.assertEquals(false, hasAccess, 'Field should not be upsertable when it is only creatable and not updateable.');
    }

    @isTest
    static void testHasFieldUpsertAccess_False_UpdateableOnly() {
        // Scenario: Field is updateable but not creatable

        // Mock DescribeFieldResult with isCreateable returning false and isUpdateable returning true
        Schema.DescribeFieldResult mockFieldResult = createMockDescribeFieldResult(false, true);

        Boolean hasAccess = PermissionValidator.getInstance().hasFieldUpsertAccess(mockFieldResult);
        
        System.assertEquals(false, hasAccess, 'Field should not be upsertable when it is only updateable and not creatable.');
    }

    @isTest
    static void testHasFieldUpsertAccess_False_Neither() {
        // Scenario: Field is neither creatable nor updateable

        // Mock DescribeFieldResult with both isCreateable and isUpdateable returning false
        Schema.DescribeFieldResult mockFieldResult = createMockDescribeFieldResult(false, false);

        Boolean hasAccess = PermissionValidator.getInstance().hasFieldUpsertAccess(mockFieldResult);
        
        System.assertEquals(false, hasAccess, 'Field should not be upsertable when it is neither creatable nor updateable.');
    }

    private static Schema.DescribeFieldResult createMockDescribeFieldResult(Boolean creatable, Boolean updateable) {
        Schema.DescribeFieldResult mockResult = (Schema.DescribeFieldResult) JSON.deserialize('{"createable":' + creatable + ', "updateable":' + updateable + '}', Schema.DescribeFieldResult.class);
        return mockResult;
    }
}
