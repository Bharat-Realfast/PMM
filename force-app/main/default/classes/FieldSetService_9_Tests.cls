
@isTest
private class FieldSetService_9_Tests {

    @isTest
    static void testFieldInfoWithStandardField() {
        // Use a standard field's DescribeFieldResult
        DescribeFieldResult dfr = Account.Name.getDescribe();
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(dfr);
        
        // Assertions to verify the FieldInfo object was created properly
        System.assertEquals(dfr.getName(), fieldInfo.getDescribe().getName(), 'Field name should match');
        System.assertEquals(dfr.getLabel(), fieldInfo.getLabel(), 'Field label should match');
    }
}
