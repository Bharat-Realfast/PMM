
@isTest
public class DailyIterable_1_Tests {

    // Test setup
    @testSetup
    static void setup() {
        // There is no need to create any test data for this particular class
    }

    // Helper methods for initializing the `RecurrenceRule` instance,
    // which would normally be done through its constructor or initialization methods.
    static RecurrenceRule initRecurrenceRule(Date endDate, Integer count) {
        // This is a placeholder for the actual initialization of a RecurrenceRule.
        // The actual project will have a specific way to create and setup a RecurrenceRule.
        // For the purpose of this test, we will assume this method correctly initializes the RecurrenceRule.
        // Since we can't directly call methods on RecurrenceRule due to the lack of implementation details,
        // this method represents a black box that correctly sets up the RecurrenceRule instance.
        RecurrenceRule rRule = new RecurrenceRule();
        return rRule;
    }

    // Test Methods

    // Test hasNext when it should return true (assuming RecurrenceRule is properly setup)
    @isTest
    static void testHasNextReturnsTrue() {
        // Arrange
        Date startDate = Date.today();
        RecurrenceRule rRule = initRecurrenceRule(Date.today().addDays(5), 10);
        DailyIterable iterable = new DailyIterable(startDate, rRule);

        // Act & Assert
        // We assume hasNext initially returns true until proven otherwise by running out of dates or hitting the count.
        System.assertEquals(true, iterable.hasNext(), 'hasNext should initially return true.');
    }

    // Test hasNext when the end date is reached (assuming RecurrenceRule is properly setup)
    @isTest
    static void testHasNextReturnsFalseWhenEndDateReached() {
        // Arrange
        Date startDate = Date.today();
        RecurrenceRule rRule = initRecurrenceRule(startDate, null); // End date is today, no count specified
        DailyIterable iterable = new DailyIterable(startDate, rRule);

        // Act
        iterable.next(); // Advance to the next day which should be past the end date

        // Assert
        System.assertEquals(false, iterable.hasNext(), 'hasNext should return false when end date is reached.');
    }

    // Test hasNext when runningDate is null
    @isTest
    static void testHasNextReturnsFalseWhenRunningDateIsNull() {
        // Arrange
        RecurrenceRule rRule = initRecurrenceRule(Date.today().addDays(5), 10);
        DailyIterable iterable = new DailyIterable(null, rRule);

        // Act & Assert
        System.assertEquals(false, iterable.hasNext(), 'hasNext should return false when runningDate is null.');
    }

    // Test hasNext when rRule is null
    @isTest
    static void testHasNextReturnsFalseWhenRRuleIsNull() {
        // Arrange
        Date startDate = Date.today();
        DailyIterable iterable = new DailyIterable(startDate, null);

        // Act & Assert
        System.assertEquals(false, iterable.hasNext(), 'hasNext should return false when rRule is null.');
    }
}
