
@isTest
public class SSCC13Tests {
    
    // Utility method to create test DateTime instances
    private static DateTime createTestDateTime(Integer year, Integer month, Integer day) {
        return DateTime.newInstance(Date.newInstance(year, month, day), Time.newInstance(0, 0, 0, 0));
    }

    @isTest
    static void testGetDayNumValidDateTime() {
        // Given
        DateTime testDateTime = createTestDateTime(2023, 3, 13);

        // When
        Integer dayNum = ServiceScheduleCreatorController.getDayNum(testDateTime);

        // Then
        System.assertNotEquals(null, dayNum, 'Day number should not be null');
        System.assertEquals(testDateTime.date().day(), dayNum, 'Day number should match the day of the DateTime object');
    }

    @isTest
    static void testGetDayNumNullDateTime() {
        // Given
        DateTime testDateTime = null;
        Boolean isExceptionThrown = false;

        try {
            // When
            Integer dayNum = ServiceScheduleCreatorController.getDayNum(testDateTime);
        } catch(NullPointerException e) {
            // Then
            isExceptionThrown = true;
        }

        System.assertEquals(true, isExceptionThrown, 'Passing null DateTime should throw NullPointerException');
    }
}
