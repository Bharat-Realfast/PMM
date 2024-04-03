
@isTest
private class Util_4_Tests {

    @isTest
    static void testGetTodayHappyPath() {
        // Happy Path scenario
        Date expectedDate = System.today();
        Date actualDate = Util.getToday();
        
        System.assertEquals(expectedDate, actualDate, 'The getToday method should return the current date.');
    }
    
    @isTest
    static void testGetTodayNonNull() {
        // Exceptional scenario - checking for null
        Date actualDate = Util.getToday();
        
        System.assertNotEquals(null, actualDate, 'The getToday method should not return null.');
    }
}
