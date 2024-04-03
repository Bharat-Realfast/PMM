
@isTest
private class ServiceScheduleCreatorController_12_Tests {

    @testSetup
    static void setup() {
        // No test data needed for getToday method
    }

    @isTest
    static void testGetToday() {
        Date expectedToday = Date.today();
        Date actualToday = ServiceScheduleCreatorController.getToday();

        System.assertEquals(expectedToday, actualToday, "The getToday() method should return the current date.");
    }
}
