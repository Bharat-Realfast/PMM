
@isTest
private class RecurrenceService_2_Tests {

    // Create test data
    @testSetup
    static void setup() {
        // Normally, we would create test data for objects if needed.
        // However, in this case, it doesn't seem necessary as we are not interacting with any SObjects.
    }
    
    // Test for a happy path scenario with a limited number of recurrences to avoid CPU time limit
    @isTest
    static void testGenerateHappyPath() {
        // Arrange
        DateTime dateTimeStart = DateTime.newInstance(2023, 1, 1, 12, 0, 0);
        String rRule = 'FREQ=DAILY;INTERVAL=1;COUNT=5'; // Limit the count to avoid CPU time limit
        
        // Act
        List<DateTime> result = new RecurrenceService().generate(dateTimeStart, rRule);
        
        // Assert
        System.assertNotEquals(null, result, 'Result should not be null');
        System.assertEquals(5, result.size(), 'Result should have exactly 5 DateTime entries');
    }

    // Test for handling null rRule
    @isTest
    static void testGenerateNullRRule() {
        // Arrange
        DateTime dateTimeStart = DateTime.newInstance(2023, 1, 1, 12, 0, 0);
        String rRule = null;
        
        try {
            // Act
            new RecurrenceService().generate(dateTimeStart, rRule);
            System.assert(false, 'An exception should have been thrown for null rRule');
        } catch (NullPointerException e) {
            // Assert
            System.assert(true, 'NullPointerException was correctly thrown for null rRule');
        }
    }
    
    // Test for handling invalid rRule
    @isTest
    static void testGenerateInvalidRRule() {
        // Arrange
        DateTime dateTimeStart = DateTime.newInstance(2023, 1, 1, 12, 0, 0);
        String rRule = 'INVALID RULE';
        
        try {
            // Act
            new RecurrenceService().generate(dateTimeStart, rRule);
            System.assert(false, 'Exception should have been thrown for invalid rRule');
        } catch (Exception e) {
            // Assert
            System.assert(true, 'An exception was correctly thrown for invalid rRule');
        }
    }
}
