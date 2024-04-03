
@isTest
private class RecurrenceRule_5_Tests {

    @testSetup
    static void setup() {
        // No setup data required for this test class, as we're testing a utility class method
        // that does not rely on org data.
    }

    @isTest
    static void testWithEndDate_HappyPath() {
        // Given
        RecurrenceRule rule = new RecurrenceRule();
        Date expectedEndDate = Date.newInstance(2023, 12, 31);

        // When
        rule.withEndDate(expectedEndDate);

        // Then
        System.assertEquals(expectedEndDate, rule.getEndDate(), 'The end date should be set correctly.');
    }

    @isTest
    static void testWithEndDate_NullDate() {
        // Given
        RecurrenceRule rule = new RecurrenceRule();
        Date expectedEndDate = null;

        // When
        rule.withEndDate(expectedEndDate);

        // Then
        System.assertEquals(expectedEndDate, rule.getEndDate(), 'The end date should be set to null.');
    }
}
