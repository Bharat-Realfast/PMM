
@isTest
private class RecurrenceRule_11_Tests {
    
    @isTest
    static void testWithRuleStringHappyPath() {
        RecurrenceRule rr = new RecurrenceRule();
        String validRRuleString = 'FREQ=DAILY;INTERVAL=1;UNTIL=20230101T000000Z';
        
        Test.startTest();
        RecurrenceRule parsedRule = rr.withRuleString(validRRuleString);
        Test.stopTest();
        
        System.assertEquals(RecurrenceRule.Frequency.DAILY, parsedRule.getFrequency(), 'Frequency should be DAILY');
        System.assertEquals(1, parsedRule.getInterval(), 'Interval should be 1');
    }
    
    @isTest
    static void testWithRuleStringInvalidFrequency() {
        RecurrenceRule rr = new RecurrenceRule();
        String invalidFreqRRuleString = 'FREQ=INVALID;INTERVAL=1;UNTIL=20230101T000000Z';

        Exception actualException;
        try {
            rr.withRuleString(invalidFreqRRuleString);
        } catch (RecurrenceRule.RecurrenceRuleException ex) {
            actualException = ex;
        }
        
        System.assertNotEquals(null, actualException, 'Exception should be thrown due to invalid frequency');
    }
    
    @isTest
    static void testWithRuleStringInvalidRuleKey() {
        RecurrenceRule rr = new RecurrenceRule();
        String invalidKeyRRuleString = 'FREQ=DAILY;INVALIDKEY=1;UNTIL=20230101T000000Z';
        
        Exception actualException;
        try {
            rr.withRuleString(invalidKeyRRuleString);
        } catch (RecurrenceRule.RecurrenceRuleException ex) {
            actualException = ex;
        }
        
        System.assertNotEquals(null, actualException, 'Exception should be thrown due to invalid RRule key');
    }
    
    @isTest
    static void testWithRuleStringPartialString() {
        RecurrenceRule rr = new RecurrenceRule();
        String partialRRuleString = 'FREQ=WEEKLY;COUNT=10';
        
        Test.startTest();
        RecurrenceRule parsedRule = rr.withRuleString(partialRRuleString);
        Test.stopTest();
        
        System.assertEquals(RecurrenceRule.Frequency.WEEKLY, parsedRule.getFrequency(), 'Frequency should be WEEKLY');
        System.assertEquals(null, parsedRule.getEndDate(), 'End date should be null');
        System.assertEquals(10, parsedRule.getCount(), 'Count should be 10');
    }
}
