
@isTest
private class FieldSetService_3_Tests {
    
    // Setup test data - this will run before every test method
    @testSetup
    static void setup() {
        // Since we're testing metadata (field sets), we don't need DML operation for setup
    }
    
    // Happy Path test when allowRelationshipFields is false
    @isTest
    static void testGetFieldSetForLWCWithValidDataNoRelationshipFields() {
        String objectName = 'Account';
        String fieldSetName = 'ValidFieldSet';
        Boolean allowRelationshipFields = false;

        Test.startTest();
        FieldSetService service = new FieldSetService();
        List<Map<String, Object>> fieldSetForLWC = service.getFieldSetForLWC(objectName, fieldSetName, allowRelationshipFields);
        Test.stopTest();

        System.assertNotEquals(null, fieldSetForLWC, 'Field set should not be null.');
        System.assertEquals(false, fieldSetForLWC.isEmpty(), 'Field set should not be empty.');
    }
    
    // Happy Path test when allowRelationshipFields is true
    @isTest
    static void testGetFieldSetForLWCWithValidDataWithRelationshipFields() {
        String objectName = 'Account';
        String fieldSetName = 'ValidFieldSet';
        Boolean allowRelationshipFields = true;

        Test.startTest();
        FieldSetService service = new FieldSetService();
        List<Map<String, Object>> fieldSetForLWC = service.getFieldSetForLWC(objectName, fieldSetName, allowRelationshipFields);
        Test.stopTest();

        System.assertNotEquals(null, fieldSetForLWC, 'Field set should not be null.');
        System.assertEquals(false, fieldSetForLWC.isEmpty(), 'Field set should not be empty.');
    }

    // Sad Path test with non-existent field set
    @isTest
    static void testGetFieldSetForLWCWithNonExistentFieldSet() {
        String objectName = 'Account';
        String fieldSetName = 'NonExistentFieldSet';
        Boolean allowRelationshipFields = false;

        Exception actualException;
        Test.startTest();
        FieldSetService service = new FieldSetService();
        try {
            service.getFieldSetForLWC(objectName, fieldSetName, allowRelationshipFields);
        } catch (Exception e) {
            actualException = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, actualException, 'Exception should have been thrown for non-existent field set.');
        System.assertEquals(true, actualException instanceof FieldSetService.FieldSetException, 'Expected FieldSetException.');
    }

    // Sad Path test with invalid object
    @isTest
    static void testGetFieldSetForLWCWithInvalidObject() {
        String objectName = 'InvalidObject';
        String fieldSetName = 'ValidFieldSet';
        Boolean allowRelationshipFields = false;

        Exception actualException;
        Test.startTest();
        FieldSetService service = new FieldSetService();
        try {
            service.getFieldSetForLWC(objectName, fieldSetName, allowRelationshipFields);
        } catch (Exception e) {
            actualException = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, actualException, 'Exception should have been thrown for invalid object.');
        System.assertEquals(true, actualException instanceof System.QueryException, 'Expected QueryException.');
    }

    // Sad Path test with null object name
    @isTest
    static void testGetFieldSetForLWCWithNullObjectName() {
        String objectName = null;
        String fieldSetName = 'ValidFieldSet';
        Boolean allowRelationshipFields = false;

        Exception actualException;
        Test.startTest();
        FieldSetService service = new FieldSetService();
        try {
            service.getFieldSetForLWC(objectName, fieldSetName, allowRelationshipFields);
        } catch (Exception e) {
            actualException = e;
        }
        Test.stopTest();

        System.assertNotEquals(null, actualException, 'Exception should have been thrown for null object name.');
        System.assertEquals(true, actualException instanceof System.QueryException, 'Expected QueryException.');
    }
}
