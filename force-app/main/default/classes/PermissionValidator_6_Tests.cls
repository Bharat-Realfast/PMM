
@isTest
public class PermissionValidator_6_Tests {
    
    private static DescribeFieldResult getFieldDescribeResult(String objectApiName, String fieldApiName) {
        // Utilizing the Schema methods to get the field description
        Map<String, Schema.SObjectField> objectFields = Schema.getGlobalDescribe().get(objectApiName).getDescribe().fields.getMap();
        return objectFields.get(fieldApiName).getDescribe();
    }

    @isTest
    static void testHasFieldCreateAccess_True() {
        // Assuming 'Name' field on 'Account' is creatable for the running user
        DescribeFieldResult fieldDescribe = getFieldDescribeResult('Account', 'Name');
        Boolean hasCreateAccess = PermissionValidator.getInstance().hasFieldCreateAccess(fieldDescribe);
        
        // Assertions
        System.assert(hasCreateAccess, 'Field should be creatable.');
    }
    
    @isTest
    static void testHasFieldCreateAccess_False() {
        // Assuming 'CreatedDate' field on 'Account' is not creatable for the running user
        DescribeFieldResult fieldDescribe = getFieldDescribeResult('Account', 'CreatedDate');
        Boolean hasCreateAccess = PermissionValidator.getInstance().hasFieldCreateAccess(fieldDescribe);
        
        // Assertions
        System.assertNotEquals(true, hasCreateAccess, 'Field should not be creatable.');
    }
}
