
@isTest
private class FieldSetService_8_Tests {
    
    // This is a helper method to get actual FieldSetMember from an SObject FieldSet.
    private static Schema.FieldSetMember getFirstFieldSetMember(Schema.SObjectType sObjectType, String fieldSetName) {
        Schema.DescribeSObjectResult describe = sObjectType.getDescribe();
        Map<String, Schema.FieldSet> fieldSets = describe.fieldSets.getMap();
        
        if (fieldSets.containsKey(fieldSetName)) {
            Schema.FieldSet fieldSet = fieldSets.get(fieldSetName);
            if (!fieldSet.getFields().isEmpty()) {
                return fieldSet.getFields().get(0);
            }
        }
        return null;
    }
    
    @isTest
    static void testFieldInfoWithValidInputs() {
        // Retrieve actual DescribeFieldResult and FieldSetMember from an existing SObject
        Schema.DescribeFieldResult dfr = Account.Name.getDescribe();
        Schema.FieldSetMember fsm = getFirstFieldSetMember(Account.SObjectType, 'StandardFieldSet'); // Replace 'StandardFieldSet' with actual field set name

        // Assuming fsm is not null, if it is, this test should be skipped or reworked
        Test.startTest();
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(dfr, fsm);
        Test.stopTest();

        // Assertions
        System.assertEquals(dfr.getName(), fieldInfo.getDescribe().getName(), 'DescribeFieldResult should match the input');
    }

    @isTest
    static void testFieldInfoWithOnlyDescribeFieldResult() {
        // Retrieve actual DescribeFieldResult from a standard field
        Schema.DescribeFieldResult dfr = Account.Name.getDescribe();

        Test.startTest();
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(dfr, null);
        Test.stopTest();

        // Assertions
        System.assertEquals(dfr.getName(), fieldInfo.getDescribe().getName(), 'DescribeFieldResult should match the input');
    }
}
