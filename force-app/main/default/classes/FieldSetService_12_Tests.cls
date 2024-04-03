
@isTest
private class FieldSetService_12_Tests {

    private static DescribeFieldResult getMockDescribeFieldResult() {
        return Schema.SObjectType.Account.fields.Name;
    }
    
    @isTest
    static void testSetDescribe_HappyPath() {
        // Given
        DescribeFieldResult mockDfr = getMockDescribeFieldResult();
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(mockDfr);
        
        // When
        fieldInfo.setDescribe(mockDfr);
        
        // Then
        System.assertEquals(mockDfr, fieldInfo.getDescribe(), 'The describe should match the mock DescribeFieldResult');
    }
    
    @isTest
    static void testSetDescribe_NullInput() {
        // Given
        DescribeFieldResult mockDfr = getMockDescribeFieldResult();
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(mockDfr);
        
        // When
        fieldInfo.setDescribe(null);
        
        // Then
        System.assertEquals(null, fieldInfo.getDescribe(), 'The describe should be null after being explicitly set to null');
    }
}
