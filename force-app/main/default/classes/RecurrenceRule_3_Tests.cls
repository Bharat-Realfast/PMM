
@isTest
private class RecurrenceRule_3_Tests {

    @isTest
    static void shouldSetFrequencyWithValidString() {
        // Setup
        String validFrequency = 'DAILY';
        RecurrenceRule rule = new RecurrenceRule();
        
        // Execute
        Test.startTest();
        rule.withFrequency(validFrequency);
        Test.stopTest();

        // Verify
        System.assertEquals(RecurrenceRule.Frequency.DAILY, rule.getFrequency(), 'The frequency should be set to DAILY.');
    }

    @isTest
    static void shouldThrowExceptionWithInvalidString() {
        // Setup
        String invalidFrequency = 'YEARLY';
        RecurrenceRule rule = new RecurrenceRule();
        
        // Execute and Verify
        Boolean didThrow = false;
        try {
            rule.withFrequency(invalidFrequency);
        } catch (RecurrenceRule.RecurrenceRuleException e) {
            didThrow = true;
        }
        
        System.assert(didThrow, 'An exception should be thrown for invalid frequency string.');
    }
    
    @isTest
    static void shouldThrowExceptionWithNullString() {
        // Setup
        String nullFrequency = null;
        RecurrenceRule rule = new RecurrenceRule();
        
        // Execute and Verify
        Boolean didThrow = false;
        try {
            rule.withFrequency(nullFrequency);
        } catch (NullPointerException e) {
            didThrow = true;
        }
        
        System.assert(didThrow, 'A NullPointerException should be thrown for null frequency string.');
    }
}
