
@isTest
private class RecurrenceRule_22_Tests {

    @testSetup
    static void setup() {
        // Placeholder for setup code, if necessary.
    }

    @isTest
    static void shouldBuildFreqOnlyRule() {
        RecurrenceRule rule = new RecurrenceRule().withFrequency(RecurrenceRule.Frequency.DAILY);
        String result = rule.build();
        System.assertEquals('FREQ=DAILY', result, 'The build method should return a rule with only FREQ=DAILY.');
    }

    @isTest
    static void shouldBuildFreqAndIntervalRule() {
        RecurrenceRule rule = new RecurrenceRule().withFrequency(RecurrenceRule.Frequency.WEEKLY).withInterval(2);
        String result = rule.build();
        System.assertEquals('FREQ=WEEKLY;INTERVAL=2', result, 'The build method should return a rule with FREQ=WEEKLY and INTERVAL=2.');
    }

    @isTest
    static void shouldBuildFreqAndUntilRule() {
        Date endDate = Date.newInstance(2023, 12, 31);
        RecurrenceRule rule = new RecurrenceRule().withFrequency(RecurrenceRule.Frequency.DAILY).withEndDate(endDate);
        String result = rule.build();
        System.assert(result.contains('UNTIL=20231231T000000Z'), 'The build method should return a rule with UNTIL=20231231T000000Z.');
    }

    @isTest
    static void shouldBuildFreqAndCountRule() {
        RecurrenceRule rule = new RecurrenceRule().withFrequency(RecurrenceRule.Frequency.WEEKLY).withCount(10);
        String result = rule.build();
        System.assertEquals('FREQ=WEEKLY;COUNT=10', result, 'The build method should return a rule with FREQ=WEEKLY and COUNT=10.');
    }

    @isTest
    static void shouldBuildWeeklyFreqByDayRule() {
        List<RecurrenceRule.Day> days = new List<RecurrenceRule.Day>{RecurrenceRule.Day.MO, RecurrenceRule.Day.WE};
        RecurrenceRule rule = new RecurrenceRule().withFrequency(RecurrenceRule.Frequency.WEEKLY).withDays(days);
        String result = rule.build();
        System.assert(result.contains('BYDAY=MO,WE'), 'The build method should return a rule with BYDAY=MO,WE for a weekly frequency.');
    }

    @isTest
    static void shouldBuildMonthlyFreqByDayRule() {
        RecurrenceRule rule = new RecurrenceRule().withFrequency(RecurrenceRule.Frequency.MONTHLY).withByDay('+2SU');
        String result = rule.build();
        System.assert(result.contains('BYDAY=+2SU'), 'The build method should return a rule with BYDAY=+2SU for a monthly frequency.');
    }

    @isTest
    static void shouldBuildMonthlyFreqByMonthDayRule() {
        DateTime dateTimeStart = DateTime.newInstanceGMT(Date.newInstance(2023, 1, 1), Time.newInstance(0, 0, 0, 0));
        RecurrenceRule rule = new RecurrenceRule()
            .withFrequency(RecurrenceRule.Frequency.MONTHLY)
            .withByMonthDays(dateTimeStart);
        String result = rule.build();
        System.assert(result.contains('BYMONTHDAY=28,29,30,31'), 'The build method should return a rule with BYMONTHDAY=28,29,30,31.');
    }

    @isTest(expectedExceptions = RecurrenceRule.RecurrenceRuleException.class)
    static void shouldThrowExceptionForInvalidFrequency() {
        RecurrenceRule rule = new RecurrenceRule().withFrequency('INVALID');
        rule.build();
    }

    // Additional tests for sad paths and exceptional scenarios can be added here.
}
