
@isTest
private class RecurrenceService_3_Tests {
    @testSetup
    static void setup() {
        // This method is intentionally left blank as there is no setup data required for the test scenarios.
    }
    
    // Helper method to create a DateTime object for a Date at midnight UTC
    private static DateTime toDateTimeAtMidnightUTC(Date dateValue) {
        return DateTime.newInstanceGMT(dateValue, Time.newInstance(0, 0, 0, 0));
    }
    
    // Happy Path Test 1: All parameters are provided and valid for DAILY frequency
    @isTest
    static void testCreateRRuleWithAllValidParametersDaily() {
        RecurrenceService service = new RecurrenceService();
        String frequency = 'DAILY';
        Integer interval = 1;
        Date endDate = Date.today().addDays(10);
        DateTime endDateAtMidnightUTC = toDateTimeAtMidnightUTC(endDate);
        String formattedEndDate = endDateAtMidnightUTC.format('yyyyMMdd\'T\'HHmmss\'Z\'');
        Integer count = null; // Since we are using endDate, count should be null
        List<Integer> days = null;
        DateTime dateTimeStart = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
        String byDay = null; // Not used for DAILY frequency
        
        String expectedRRule = 'FREQ=DAILY;INTERVAL=1;UNTIL=' + formattedEndDate;
        
        String resultRRule = service.createRRule(frequency, interval, endDate, count, days, dateTimeStart, byDay);
        
        System.assertEquals(expectedRRule, resultRRule, 'The RRule was not generated as expected for daily frequency.');
    }

    // Additional happy path tests would be similar, varying the frequency and other parameters

    // Sad Path Test 1: Required parameter frequency is null
    @isTest
    static void testCreateRRuleWithNullFrequency() {
        RecurrenceService service = new RecurrenceService();
        Integer interval = 1;
        Date endDate = Date.today().addDays(10);
        Integer count = null;
        List<Integer> days = null;
        DateTime dateTimeStart = DateTime.newInstance(Date.today(), Time.newInstance(0, 0, 0, 0));
        
        String resultRRule;
        Boolean caughtException = false;
        
        try {
            resultRRule = service.createRRule(null, interval, endDate, count, days, dateTimeStart, null);
        } catch (Exception e) {
            caughtException = true;
        }
        
        System.assert(caughtException, 'An exception should have been thrown for null frequency.');
    }

    // Additional sad path and exceptional scenario tests would follow a similar pattern, 
    // varying inputs to trigger different validation errors or exceptions.
}
