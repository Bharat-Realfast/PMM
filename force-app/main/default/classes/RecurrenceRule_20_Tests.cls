
@isTest
private class RecurrenceRule_20_Tests {

    @testSetup
    static void setup() {
        // Any required setup code would go here
        // For this test scenario, we don't need to create any records
    }

    @isTest
    static void testGetDayNumsWithValidDays() {
        // Arrange
        RecurrenceRule rule = new RecurrenceRule();
        rule.withDays(new List<RecurrenceRule.Day>{
            RecurrenceRule.Day.MO, RecurrenceRule.Day.WE, RecurrenceRule.Day.FR
        });

        // Act
        List<Integer> dayNums = rule.getDayNums();

        // Assert
        System.assertEquals(3, dayNums.size(), 'There should be three days in the list.');
        System.assertEquals(1, dayNums[0], 'The first day should be Monday with ordinal 1.');
        System.assertEquals(3, dayNums[1], 'The second day should be Wednesday with ordinal 3.');
        System.assertEquals(5, dayNums[2], 'The third day should be Friday with ordinal 5.');
    }

    @isTest
    static void testGetDayNumsWithNoDays() {
        // Arrange
        RecurrenceRule rule = new RecurrenceRule();
        rule.withDays(new List<RecurrenceRule.Day>()); // Initialize with an empty list instead of null

        // Act
        List<Integer> dayNums = rule.getDayNums();

        // Assert
        System.assertEquals(0, dayNums.size(), 'There should be no days in the list.');
    }

    // No need for an exceptional scenario test method as the getDayNums method doesn't throw exceptions or handle bad inputs
}
