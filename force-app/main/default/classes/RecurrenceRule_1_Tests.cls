
@isTest
private class RecurrenceRule_1_Tests {

    // Since reset() does not involve any DML operations, we do not need to bypass any triggers.
    
    @isTest
    static void testResetRecurrenceRule() {
        // Initialize a RecurrenceRule instance and set some properties
        RecurrenceRule ruleInstance = new RecurrenceRule();
        ruleInstance.withFrequency(RecurrenceRule.Frequency.DAILY)
                    .withInterval(5)
                    .withEndDate(Date.today())
                    .withCount(10)
                    .withDays(new List<RecurrenceRule.Day>{RecurrenceRule.Day.MO, RecurrenceRule.Day.TU})
                    .withByDay('2SU');
        
        // Call the reset method
        ruleInstance.reset();
        
        // Assertions to check if the properties have been reset
        System.assertEquals(null, ruleInstance.getFrequency(), 'Frequency should be reset to null');
        System.assertEquals(1, ruleInstance.getInterval(), 'Interval should be reset to 1');
        System.assertEquals(null, ruleInstance.getEndDate(), 'End Date should be reset to null');
        System.assertEquals(null, ruleInstance.getCount(), 'Count should be reset to null');
        System.assertEquals(null, ruleInstance.getDays(), 'Days should be reset to null');
        System.assertEquals(null, ruleInstance.getByDay(), 'ByDay should be reset to null');
    }
}
