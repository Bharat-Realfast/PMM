
@isTest
private class RecentServiceSessionController_2_Tests {

    @isTest
    static void testGetMenuOptions_ReturnsCorrectMap() {
        // Act
        Map<String, String> result = RecentServiceSessionController.getMenuOptions();

        // Assert
        System.assertNotEquals(null, result, 'The result should not be null');
        System.assertEquals(2, result.size(), 'The result map should contain two key-value pairs');
    }

    @isTest
    static void testGetMenuOptions_ContainsCorrectKeys() {
        // Act
        Map<String, String> result = RecentServiceSessionController.getMenuOptions();

        // Assert
        System.assertEquals(true, result.containsKey('THIS_WEEK'), 'The map should contain THIS_WEEK');
        System.assertEquals(true, result.containsKey('LAST_WEEK'), 'The map should contain LAST_WEEK');
    }

    @isTest
    static void testGetMenuOptions_ContainsCorrectLabels() {
        // Prepare
        String expectedThisWeekLabel = System.Label.This_Week;
        String expectedLastWeekLabel = System.Label.Last_Week;

        // Act
        Map<String, String> result = RecentServiceSessionController.getMenuOptions();

        // Assert
        System.assertEquals(expectedThisWeekLabel, result.get('THIS_WEEK'), 'The THIS_WEEK key should map to the correct label');
        System.assertEquals(expectedLastWeekLabel, result.get('LAST_WEEK'), 'The LAST_WEEK key should map to the correct label');
    }
}
