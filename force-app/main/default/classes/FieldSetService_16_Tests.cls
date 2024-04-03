
@isTest
private class FieldSetService_16_Tests {

    // Test getReferenceTo for a lookup field
    @isTest
    static void testGetReferenceToWithLookupField() {
        // Given
        // We use the User object and its ProfileId field, which is a standard lookup to the Profile object
        Schema.DescribeFieldResult fieldDescribe = Schema.User.ProfileId.getDescribe();
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(fieldDescribe);
        
        // When
        String referenceTo = fieldInfo.getReferenceTo();
        
        // Then
        System.assertNotEquals(null, referenceTo, 'The referenceTo should not be null for lookup fields.');
        System.assertEquals('Profile', referenceTo, 'The referenceTo should match the referenced object API name.');
    }
}
