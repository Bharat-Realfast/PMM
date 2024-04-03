
@isTest
private class RecurrenceRule_2_Tests {

    @testSetup
    static void setup() {
        // Any required setup, if necessary. In this case, we might not need setup as we're not dealing with SObjects
    }

    @isTest
    static void testWithFrequencyDaily() {
        // Arrange
        RecurrenceRule rule = new RecurrenceRule();
        
        // Act
        RecurrenceRule result = rule.withFrequency(RecurrenceRule.Frequency.DAILY);
        
        // Assert
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(RecurrenceRule.Frequency.DAILY, result.getFrequency(), 'The frequency should be set to DAILY.');
    }
    
    @isTest
    static void testWithFrequencyWeekly() {
        // Arrange
        RecurrenceRule rule = new RecurrenceRule();
        
        // Act
        RecurrenceRule result = rule.withFrequency(RecurrenceRule.Frequency.WEEKLY);
        
        // Assert
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(RecurrenceRule.Frequency.WEEKLY, result.getFrequency(), 'The frequency should be set to WEEKLY.');
    }

    @isTest
    static void testWithFrequencyMonthly() {
        // Arrange
        RecurrenceRule rule = new RecurrenceRule();
        
        // Act
        RecurrenceRule result = rule.withFrequency(RecurrenceRule.Frequency.MONTHLY);
        
        // Assert
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assertEquals(RecurrenceRule.Frequency.MONTHLY, result.getFrequency(), 'The frequency should be set to MONTHLY.');
    }
}
