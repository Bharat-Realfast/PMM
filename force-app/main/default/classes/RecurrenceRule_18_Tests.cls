
@isTest
private class RecurrenceRule_18_Tests {

    @isTest
    static void testGetByMonthDays_WithSetMonthDays() {
        RecurrenceRule rule = new RecurrenceRule();
        // Assuming that setting the frequency to MONTHLY and invoking withByMonthDays is the happy path
        rule.withFrequency(RecurrenceRule.Frequency.MONTHLY);
        rule.withByMonthDays(DateTime.newInstance(System.today(), Time.newInstance(0, 0, 0, 0)));

        Test.startTest();
        Set<Integer> monthDays = rule.getByMonthDays();
        Test.stopTest();

        // Verify that monthDays contains the expected days indicating the last days of the month
        System.assertNotEquals(null, monthDays, 'monthDays should not be null');
        System.assertEquals(new Set<Integer>{28, 29, 30, 31}, monthDays, 'monthDays should contain the last days of the month');
    }

    @isTest
    static void testGetByMonthDays_WithoutSetMonthDays() {
        RecurrenceRule rule = new RecurrenceRule();
        // Not setting the frequency to MONTHLY or invoking withByMonthDays

        Test.startTest();
        Set<Integer> monthDays = rule.getByMonthDays();
        Test.stopTest();

        // Verify that monthDays is either null or empty since withByMonthDays was not called
        System.assertEquals(null, monthDays, 'monthDays should be null');
    }

    @isTest
    static void testGetByMonthDays_WithNonMonthlyFrequency() {
        RecurrenceRule rule = new RecurrenceRule();
        // Setting the frequency to something other than MONTHLY and invoking withByMonthDays
        rule.withFrequency(RecurrenceRule.Frequency.WEEKLY);
        rule.withByMonthDays(DateTime.newInstance(System.today(), Time.newInstance(0, 0, 0, 0)));

        Test.startTest();
        Set<Integer> monthDays = rule.getByMonthDays();
        Test.stopTest();

        // Verify that monthDays is null since the frequency is not MONTHLY
        System.assertEquals(null, monthDays, 'monthDays should be null as the frequency is not MONTHLY');
    }
}
