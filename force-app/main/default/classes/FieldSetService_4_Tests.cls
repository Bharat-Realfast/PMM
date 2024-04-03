
@isTest
private class FieldSetService_4_Tests {

    @testSetup
    static void makeData() {
        // Since we're only testing the retrieval of field sets, no test data is required.
        // The getFieldSet method does not perform DML operations, so we do not need to bypass triggers here.
    }
    
    @isTest
    static void testGetNonExistingFieldSet() {
        // Arrange
        String objectName = 'Account';
        String fieldSetName = 'NonexistentFieldSet';
        DescribeSObjectResult objectDescribe = Schema.getGlobalDescribe().get(objectName).getDescribe();
        
        // Act
        FieldSetService service = new FieldSetService();
        FieldSet resultFieldSet = service.getFieldSet(objectDescribe, fieldSetName);
        
        // Assert
        System.assertEquals(null, resultFieldSet, 'Field set should be null for non-existing field set name');
    }
}
