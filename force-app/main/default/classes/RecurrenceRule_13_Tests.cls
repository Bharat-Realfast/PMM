
@isTest
private class RecurrenceRule_13_Tests {

    @isTest
    static void testGetIntervalDefault() {
        RecurrenceRule rule = new RecurrenceRule();
        System.assertEquals(1, rule.getInterval(), 'The default interval should be 1');
    }
    
    @isTest
    static void testGetIntervalSetToThree() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withInterval(3);
        System.assertEquals(3, rule.getInterval(), 'The interval should be set to 3');
    }
}
