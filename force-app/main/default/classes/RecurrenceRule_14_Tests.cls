
@isTest
private class RecurrenceRule_14_Tests {
    
    // Since getEndDate() does not depend on any injected data or DML, 
    // there is no need for @testSetup or DML operations in this case.
    
    @isTest
    static void testGetEndDateWithDateSet() {
        // Given
        Date expectedEndDate = Date.newInstance(2023, 12, 31);
        RecurrenceRule rule = new RecurrenceRule().withEndDate(expectedEndDate);
        
        // When
        Date actualEndDate = rule.getEndDate();
        
        // Then
        System.assertEquals(expectedEndDate, actualEndDate, 'The end date should match the date that was set.');
    }
    
    @isTest
    static void testGetEndDateWithoutDateSet() {
        // Given
        RecurrenceRule rule = new RecurrenceRule();
        
        // When
        Date actualEndDate = rule.getEndDate();
        
        // Then
        System.assertEquals(null, actualEndDate, 'The end date should be null when not set.');
    }
}
