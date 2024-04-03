
@isTest
private class RecurrenceRule_4_Tests {

    // No setup data required for testing RecurrenceRule withInterval method

    // Test the happy path where a valid interval is set
    @isTest
    static void testWithValidInterval() {
        RecurrenceRule rule = new RecurrenceRule();

        // Set and test a valid interval
        rule.withInterval(5);
        System.assertEquals(5, rule.getInterval(), 'The interval should be set to 5.');
    }

    // Test the sad path where null is passed
    @isTest
    static void testWithNullInterval() {
        RecurrenceRule rule = new RecurrenceRule();

        // The default interval should remain unaffected
        rule.withInterval(null);
        System.assertEquals(1, rule.getInterval(), 'The interval should remain as the default value 1.');
    }

    // Test the edge case of setting a negative interval
    @isTest
    static void testWithNegativeInterval() {
        RecurrenceRule rule = new RecurrenceRule();

        // Set and test a negative interval
        rule.withInterval(-1);
        System.assertEquals(-1, rule.getInterval(), 'The interval should be set to -1.');
    }

    // Test the edge case of setting a zero interval
    @isTest
    static void testWithZeroInterval() {
        RecurrenceRule rule = new RecurrenceRule();

        // Set and test a zero interval
        rule.withInterval(0);
        System.assertEquals(0, rule.getInterval(), 'The interval should be set to 0.');
    }

    // Test the edge case of setting a very high interval
    @isTest
    static void testWithHighInterval() {
        RecurrenceRule rule = new RecurrenceRule();
        Integer maxInt = 2147483647;

        // Set and test a very high interval
        rule.withInterval(maxInt);
        System.assertEquals(maxInt, rule.getInterval(), 'The interval should be set to the maximum integer value.');
    }
}
