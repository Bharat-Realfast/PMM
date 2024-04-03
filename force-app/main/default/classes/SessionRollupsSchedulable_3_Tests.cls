
@isTest
private class SessionRollupsSchedulable_3_Tests {

    @testSetup
    static void makeData() {
        // Setup test data
        List<ServiceSession__c> sessions = new List<ServiceSession__c>();
        for (Integer i = 0; i < 5; i++) {
            sessions.add(new ServiceSession__c(
                NumPresentServiceDeliveries__c = 0,
                NumAbsentServiceDeliveries__c = 0
            ));
        }
        // Assuming the `ServiceSession__c` object does not require trigger handling or it's already handled in the test context
        // TriggerHandler.bypass('AccountTriggerHandler');
        // TriggerHandler.bypass('MDTAccountTriggerHandler');
        insert sessions;
    }

    @isTest
    static void testStartMethodReturnsCorrectQuery() {
        // Execute the start method
        Test.startTest();
        SessionRollupsSchedulable batchJob = new SessionRollupsSchedulable();
        Database.QueryLocator locator = batchJob.start(null);
        Test.stopTest();

        // Verify the query is correct
        String expectedQuery = 'SELECT Id FROM ServiceSession__c WHERE NumPresentServiceDeliveries__c >= 0 OR NumAbsentServiceDeliveries__c >= 0';
        String actualQuery = locator.getQuery();
        
        // Assertions
        System.assertEquals(expectedQuery.toLowerCase(), actualQuery.toLowerCase(), 'The query should match the expected query.');
    }
}
