
@isTest
private class FieldSetService_6_Tests {

    @isTest
    static void testGetFieldForLWCWithRegularField() {
        // Arrange
        DescribeFieldResult fieldDescribe = Account.Name.getDescribe();
        
        // Act
        Map<String, Object> result = new FieldSetService().getFieldForLWC(fieldDescribe);

        // Assert
        System.assertEquals(fieldDescribe.getName(), result.get('apiName'), 'apiName should match the described field name');
        System.assertEquals(fieldDescribe.getLabel(), result.get('label'), 'label should match the described field label');
        System.assert((Boolean) result.get('isAccessible'), 'isAccessible should be true for accessible fields');
    }

    @isTest
    static void testGetFieldForLWCWithRelationshipField() {
        // Arrange
        DescribeFieldResult fieldDescribe = Contact.AccountId.getDescribe();
        
        // Act
        Map<String, Object> result = new FieldSetService().getFieldForLWC(fieldDescribe);

        // Assert
        System.assertNotEquals(null, result.get('relationshipName'), 'relationshipName should be present for relationship fields');
        System.assertNotEquals(null, result.get('referenceTo'), 'referenceTo should be present for relationship fields');
        System.assert((Boolean) result.get('isAccessible'), 'isAccessible should be true for accessible relationship fields');
    }
}
