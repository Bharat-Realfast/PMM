
@isTest
public class RecurrenceRule_12_Tests {

    // Test setup method to create shared test data
    @testSetup
    static void makeData() {
        // No specific test data required for testing getFrequency() method
    }
    
    // Helper method to create a RecurrenceRule instance with a given Frequency
    private static RecurrenceRule createRecurrenceRule(RecurrenceRule.Frequency frequency) {
        return new RecurrenceRule().withFrequency(frequency);
    }

    // Test method to verify that the getFrequency() method returns the correct Frequency when set
    @isTest
    static void testGetFrequencyWhenSet() {
        // Arrange
        RecurrenceRule rule = createRecurrenceRule(RecurrenceRule.Frequency.DAILY);

        // Act
        RecurrenceRule.Frequency frequency = rule.getFrequency();

        // Assert
        System.assertEquals(RecurrenceRule.Frequency.DAILY, frequency, 'The frequency should be DAILY.');
    }

    // Test method to verify that the getFrequency() method returns null when Frequency is not set
    @isTest
    static void testGetFrequencyWhenNotSet() {
        // Arrange
        RecurrenceRule rule = new RecurrenceRule(); // No frequency set

        // Act
        RecurrenceRule.Frequency frequency = rule.getFrequency();

        // Assert
        System.assertEquals(null, frequency, 'The frequency should be null because it was not set.');
    }
}
