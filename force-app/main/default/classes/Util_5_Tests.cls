
@isTest
private class Util_5_Tests {

    // Test setup isn't necessary since we're not creating any SObjects or doing DML

    @isTest
    static void testGetDayNumForKnownDate() {
        // Known date: January 1, 2020 was a Wednesday, which should return 4.
        Date testDate = Date.newInstance(2020, 1, 1);
        Integer expectedDayNum = 4; // Wednesday

        Test.startTest();
        Integer actualDayNum = Util.getDayNum(testDate);
        Test.stopTest();

        System.assertEquals(expectedDayNum, actualDayNum, 'The day number should be 4 for Wednesday.');
    }

    @isTest
    static void testGetDayNumForSunday() {
        // Test a known Sunday: August 1, 2021
        Date testDate = Date.newInstance(2021, 8, 1);
        Integer expectedDayNum = 1; // Sunday

        Test.startTest();
        Integer actualDayNum = Util.getDayNum(testDate);
        Test.stopTest();

        System.assertEquals(expectedDayNum, actualDayNum, 'The day number should be 1 for Sunday.');
    }

    @isTest
    static void testGetDayNumForNullDate() {
        // Testing for null date
        Date testDate = null;
        Integer expectedDayNum = null;

        Test.startTest();
        try {
            Integer actualDayNum = Util.getDayNum(testDate);
            System.assert(false, 'An exception should have been thrown for a null date.');
        } catch (NullPointerException e) {
            // Expected exception
            System.assert(true);
        }
        Test.stopTest();

        // No assertion for expectedDayNum since we expected an exception
    }
}
