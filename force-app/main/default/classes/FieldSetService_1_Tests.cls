
@isTest
private class FieldSetService_1_Tests {

    @testSetup
    static void setup() {
        // As per project specific details, disable triggers on setup
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // No need for DML as we are only testing describe calls
    }

    @isTest
    static void testGetFieldSetsByNameWithValidObject() {
        FieldSetService service = new FieldSetService();
        Map<String, Object> result = service.getFieldSetsByName('Account');
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertFalse(result.isEmpty(), 'There should be field sets for the Account object.');
    }

    @isTest
    static void testGetFieldSetsByNameWithNoFieldSets() {
        FieldSetService service = new FieldSetService();
        Map<String, Object> result = service.getFieldSetsByName('CustomObject__c');
        System.assertNotEquals(null, result, 'Result should not be null.');
        System.assertTrue(result.isEmpty(), 'There should be no field sets for CustomObject__c.');
    }

    @isTest
    static void testGetFieldSetsByNameWithInvalidObject() {
        FieldSetService service = new FieldSetService();
        Exception caughtException = null;
        try {
            service.getFieldSetsByName('InvalidObject');
        } catch (Exception e) {
            caughtException = e;
        }
        
        System.assertNotEquals(null, caughtException, 'An exception was expected.');
        System.assert(caughtException.getMessage().contains('Invalid'), 'The exception message should indicate an invalid object.');
    }

    @isTest
    static void testGetFieldSetsByNameWithEmptyObjectName() {
        FieldSetService service = new FieldSetService();
        String emptyObjectName = '';
        Exception caughtException = null;
        try {
            service.getFieldSetsByName(emptyObjectName);
        } catch (Exception e) {
            caughtException = e;
        }
        
        System.assertNotEquals(null, caughtException, 'An exception was expected.');
        System.assert(caughtException.getMessage().contains('Invalid'), 'The exception message should indicate an invalid object name.');
    }

    @isTest
    static void testGetFieldSetsByNameWithNullObjectName() {
        FieldSetService service = new FieldSetService();
        String nullObjectName = null;
        Exception caughtException = null;
        try {
            service.getFieldSetsByName(nullObjectName);
        } catch (Exception e) {
            caughtException = e;
        }
        
        System.assertNotEquals(null, caughtException, 'An exception was expected.');
        System.assert(caughtException.getMessage().contains('Invalid'), 'The exception message should indicate an invalid object name.');
    }
}
