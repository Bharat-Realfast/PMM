
@isTest
public class RecurrenceRule_10_Tests {

    // Test setup
    @testSetup
    static void setup() {
        // No data setup required for testing this method
    }

    // Test method for a valid day string
    @isTest
    static void testWithByDayValidString() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withByDay('2SU');

        String expected = '+2SU';
        String actual = rule.getByDay();

        System.assertEquals(expected, actual, 'The byDay should be prepended with a + sign');
    }

    // Test method for last day of the month
    @isTest
    static void testWithByDayLastDayOfMonth() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withByDay('LastDayOfMonth');

        String expected = 'LastDayOfMonth';
        String actual = rule.getByDay();

        System.assertEquals(expected, actual, 'The byDay should remain unchanged for LastDayOfMonth');
    }

    // Test method for null input
    @isTest
    static void testWithByDayNull() {
        RecurrenceRule rule = new RecurrenceRule();
        rule.withByDay(null);

        String expected = null;
        String actual = rule.getByDay();

        System.assertEquals(expected, actual, 'The byDay should be null when null is passed');
    }
}
