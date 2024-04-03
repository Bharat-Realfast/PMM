
@isTest
private class RecurrenceRule_9_Tests {

    // Utilize test setup to create initial data
    @testSetup
    static void setup() {
        // In this case, there's no need for setup data as we're testing a standalone class
    }

    // Happy path test when frequency is MONTHLY
    @isTest
    static void testWithByMonthDaysWhenFrequencyIsMonthly() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withFrequency(RecurrenceRule.Frequency.MONTHLY);
        rule = rule.withByMonthDays(DateTime.now());

        Set<Integer> expectedDays = new Set<Integer>{28, 29, 30, 31};
        System.assertEquals(expectedDays, rule.getByMonthDays(), 'The byMonthDays should contain {28, 29, 30, 31}.');
    }

    // Happy path test when frequency is not MONTHLY
    @isTest
    static void testWithByMonthDaysWhenFrequencyIsNotMonthly() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withFrequency(RecurrenceRule.Frequency.WEEKLY);
        rule = rule.withByMonthDays(DateTime.now());

        System.assertEquals(null, rule.getByMonthDays(), 'The byMonthDays should remain null.');
    }

    // Sad path test without setting frequency
    @isTest
    static void testWithByMonthDaysWithoutFrequency() {
        RecurrenceRule rule = new RecurrenceRule();
        rule = rule.withByMonthDays(DateTime.now());

        System.assertEquals(null, rule.getByMonthDays(), 'The byMonthDays should remain null.');
    }

    // Sad path test when frequency is WEEKLY
    @isTest
    static void testWithByMonthDaysWhenFrequencyIsWeekly() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withFrequency(RecurrenceRule.Frequency.WEEKLY);
        rule = rule.withByMonthDays(DateTime.now());

        System.assertEquals(null, rule.getByMonthDays(), 'The byMonthDays should not be set.');
    }
}
