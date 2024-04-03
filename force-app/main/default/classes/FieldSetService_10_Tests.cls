
@isTest
private class FieldSetService_10_Tests {

    @testSetup
    static void setup() {
        // Set up a test FieldSet and FieldSetMember for Account object
        // As we are testing with schema information and not performing DML operations,
        // we do not need to set up test data or bypass triggers.
    }

    @isTest
    static void testNullFieldSetMember() {
        Schema.FieldSetMember fsm = null;
        Exception expectedException;

        try {
            // Execute the target constructor with null fsm
            FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(fsm);
        } catch (Exception e) {
            // Capture the expected exception
            expectedException = e;
        }
        
        // Assertions
        System.assertNotEquals(null, expectedException, 'An exception should have been thrown');
        System.assertEquals('Attempt to de-reference a null object', expectedException.getMessage(), 'Expected a NullPointerException with the correct message.');
    }
    
    // Additional test methods could be added if there were more scenarios to cover.
}
