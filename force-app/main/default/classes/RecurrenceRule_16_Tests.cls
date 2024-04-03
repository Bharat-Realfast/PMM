
@isTest
private class RecurrenceRule_16_Tests {

    @testSetup
    static void setup() {
        // No setup required for testing non-database functionality
    }

    @isTest
    static void testGetDaysWithIntegersHappyPath() {
        // Test for happy path with a valid list of integers representing days
        RecurrenceRule rule = new RecurrenceRule();
        List<Integer> dayInts = new List<Integer>{1, 2, 3};
        rule.withDays(dayInts);

        List<RecurrenceRule.Day> days = rule.getDays();

        System.assertNotEquals(null, days, 'Days should not be null');
        System.assertEquals(3, days.size(), 'There should be 3 days in the list');
    }

    @isTest
    static void testGetDaysWithEnumListHappyPath() {
        // Test for happy path with a valid list of Day enums
        RecurrenceRule rule = new RecurrenceRule();
        List<RecurrenceRule.Day> enumDays = new List<RecurrenceRule.Day>{
            RecurrenceRule.Day.MO,
            RecurrenceRule.Day.WE,
            RecurrenceRule.Day.FR
        };
        rule.withDays(enumDays);

        List<RecurrenceRule.Day> days = rule.getDays();

        System.assertNotEquals(null, days, 'Days should not be null');
        System.assertEquals(enumDays.size(), days.size(), 'The size of days list should match the input list');
    }

    @isTest
    static void testGetDaysNullList() {
        // Test for the scenario where no days have been set
        RecurrenceRule rule = new RecurrenceRule();

        List<RecurrenceRule.Day> days = rule.getDays();

        System.assertEquals(null, days, 'Days should be null as no days were set');
    }

    @isTest
    static void testGetDaysWithInvalidIntegers() {
        // Test for exceptional scenario with an invalid list of integers
        RecurrenceRule rule = new RecurrenceRule();
        List<Integer> dayInts = new List<Integer>{8};
        
        Boolean didThrow = false;
        try {
            rule.withDays(dayInts);
        } catch (RecurrenceRule.RecurrenceRuleException e) {
            didThrow = true;
            System.assertEquals('Invalid day number.', e.getMessage(), 'Exception message should match expected');
        }

        System.assert(didThrow, 'A RecurrenceRuleException was expected to be thrown');
    }
}
