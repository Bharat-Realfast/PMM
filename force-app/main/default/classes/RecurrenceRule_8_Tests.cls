
@isTest
private class RecurrenceRule_8_Tests {

    @testSetup
    static void setup() {
        // No specific setup is required as the testing does not interact with the database.
    }

    @isTest
    static void testWithDaysValidInput() {
        // Given
        RecurrenceRule rule = new RecurrenceRule();
        List<Integer> validDays = new List<Integer>{1, 2, 3}; // Sunday, Monday, Tuesday

        // When
        rule.withDays(validDays);

        // Then
        List<RecurrenceRule.Day> expectedDays = new List<RecurrenceRule.Day>{
            RecurrenceRule.Day.SU, RecurrenceRule.Day.MO, RecurrenceRule.Day.TU
        };
        System.assertEquals(expectedDays, rule.getDays(), 'The days should be set correctly.');
    }

    @isTest
    static void testWithDaysEmptyInput() {
        // Given
        RecurrenceRule rule = new RecurrenceRule();
        List<Integer> emptyDays = new List<Integer>();

        // When
        rule.withDays(emptyDays);

        // Then
        System.assert(rule.getDays() == null || rule.getDays().isEmpty(), 'The days should not be set or modified.');
    }

    @isTest
    static void testWithDaysInvalidInput() {
        // Given
        RecurrenceRule rule = new RecurrenceRule();
        List<Integer> invalidDays = new List<Integer>{0, 8}; // Invalid days, outside of 1-7

        // When
        Boolean didThrowException = false;
        String exceptionMessage = '';
        try {
            rule.withDays(invalidDays);
        } catch (Exception e) {
            didThrowException = true;
            exceptionMessage = e.getMessage();
        }

        // Then
        System.assert(didThrowException, 'An exception should be thrown for invalid day numbers.');
        System.assertEquals('List index out of bounds: -1', exceptionMessage, 'The exception message should match the actual message.');
    }
}
