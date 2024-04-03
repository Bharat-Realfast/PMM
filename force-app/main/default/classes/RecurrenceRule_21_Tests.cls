
@isTest
private class RecurrenceRule_21_Tests {

    @isTest
    static void testGetDayNumWithValidDay() {
        // Test with a valid day abbreviation
        Integer expectedDayNum = 1; // Based on the Day enum, 'MO' should correspond to 1
        Integer dayNum = new RecurrenceRule().getDayNum('MO');
        
        System.assertEquals(expectedDayNum, dayNum, 'The day number for MO should be 1');
    }
    
    @isTest
    static void testGetDayNumWithInvalidDay() {
        // Test with an invalid day abbreviation
        Integer dayNum = new RecurrenceRule().getDayNum('XX');
        
        // Since the method does not assign a value to result for invalid input, it should be null
        System.assertEquals(null, dayNum, 'The day number for an invalid day abbreviation should be null');
    }
    
    @isTest
    static void testGetDayNumWithNull() {
        // Test with null as the day abbreviation
        Integer dayNum = new RecurrenceRule().getDayNum(null);
        
        // The method should return null when the input is null
        System.assertEquals(null, dayNum, 'The day number for a null day abbreviation should be null');
    }
}
