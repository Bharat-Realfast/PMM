
@isTest
private class RecurrenceService_1_Tests {

    @testSetup
    static void setup() {
        // Setup code here if necessary, though for this specific case, no DML setup seems required.
    }

    @isTest
    static void testGenerate_HappyPath() {
        // Arrange
        DateTime dateTimeStart = DateTime.newInstanceGmt(2023, 1, 1, 12, 0, 0);
        String rRule = 'FREQ=DAILY;INTERVAL=1'; // A simple daily recurrence rule
        Integer maxSessions = 5;

        // Act
        List<DateTime> generatedDates = new RecurrenceService().generate(dateTimeStart, rRule, maxSessions);

        // Assert
        System.assertEquals(5, generatedDates.size(), 'There should be exactly 5 sessions');
        System.assertEquals(dateTimeStart, generatedDates[0], 'The first session should match the start date and time');
    }

    @isTest
    static void testGenerate_InvalidRRule() {
        // Arrange
        DateTime dateTimeStart = DateTime.newInstanceGmt(2023, 1, 1, 12, 0, 0);
        String invalidRRule = 'INVALID'; // An invalid recurrence rule
        Integer maxSessions = 5;

        // Act & Assert
        try {
            new RecurrenceService().generate(dateTimeStart, invalidRRule, maxSessions);
            System.assert(false, 'Method should not succeed with invalid rRule');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('INVALID'), 'Expected exception to be related to invalid rRule');
        }
    }

    @isTest
    static void testGenerate_NullDateTimeStart() {
        // Arrange
        DateTime dateTimeStart = null;
        String rRule = 'FREQ=DAILY;INTERVAL=1';
        Integer maxSessions = 5;

        // Act & Assert
        try {
            new RecurrenceService().generate(dateTimeStart, rRule, maxSessions);
            System.assert(false, 'Method should not succeed with null dateTimeStart');
        } catch (Exception e) {
            System.assert(e.getMessage().contains('dateTimeStart'), 'Expected exception to be related to null dateTimeStart');
        }
    }

    @isTest
    static void testGenerate_NullOrEmptyRRule() {
        // Arrange
        DateTime dateTimeStart = DateTime.newInstanceGmt(2023, 1, 1, 12, 0, 0);
        String nullRRule = null;

        // Act
        List<DateTime> generatedDatesWithNull = new RecurrenceService().generate(dateTimeStart, nullRRule, 5);

        // Assert
        System.assert(generatedDatesWithNull.isEmpty(), 'No sessions should be generated with null rRule');

        // Arrange for empty rRule
        String emptyRRule = '';

        // Act
        List<DateTime> generatedDatesWithEmpty = new RecurrenceService().generate(dateTimeStart, emptyRRule, 5);

        // Assert
        System.assert(generatedDatesWithEmpty.isEmpty(), 'No sessions should be generated with empty rRule');
    }

    @isTest
    static void testGenerate_NullMaxSessions() {
        // Arrange
        DateTime dateTimeStart = DateTime.newInstanceGmt(2023, 1, 1, 12, 0, 0);
        String rRule = 'FREQ=WEEKLY;INTERVAL=1';
        Integer maxSessions = null; // Should be handled by the overloaded method

        // Act
        List<DateTime> generatedDates = new RecurrenceService().generate(dateTimeStart, rRule, maxSessions);

        // Assert
        System.assertNotEquals(null, generatedDates, 'Sessions should be generated even if maxSessions is null');
    }
}
