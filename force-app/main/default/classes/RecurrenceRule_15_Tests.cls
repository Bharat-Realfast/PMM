
@isTest
public class RecurrenceRule_15_Tests {

    @testSetup
    static void setupTestData() {
        // In this scenario, we do not need to set up any test data as we are testing non-dependent methods.
    }

    // Test to verify that getCount() returns the correct count value when set
    @isTest
    static void testGetCountReturnsCorrectValue() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withCount(10);
        Integer count = rule.getCount();
        
        System.assertEquals(10, count, 'The count should be 10');
    }

    // Test to verify that getCount() returns null when the count is not set
    @isTest
    static void testGetCountReturnsNullInitially() {
        RecurrenceRule rule = new RecurrenceRule();
        Integer count = rule.getCount();
        
        System.assertEquals(null, count, 'The count should be null by default');
    }

    // Test to verify that getCount() returns null after count is explicitly set to null
    @isTest
    static void testGetCountAfterSettingToNull() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withCount(null);
        Integer count = rule.getCount();
        
        System.assertEquals(null, count, 'The count should be null after being set to null');
    }
}
