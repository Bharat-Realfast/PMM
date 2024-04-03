
@isTest
private class ServiceSessionSelector_2_Tests {

    @testSetup
    static void setupTestData() {
        // Replace the bypass call with the actual framework call if necessary.
        // Assuming custom method to bypass triggers
        // CustomTriggerControl.bypass('AccountTriggerHandler');
        // CustomTriggerControl.bypass('MDTAccountTriggerHandler');

        // Creating test data for ServiceSession__c
        ServiceSession__c session1 = new ServiceSession__c(
            SessionStart__c = Date.today(),
            Status__c = 'Pending'
        );
        ServiceSession__c session2 = new ServiceSession__c(
            SessionStart__c = Date.today().addDays(1),
            Status__c = 'Complete'
        );
        insert new List<ServiceSession__c>{session1, session2};
    }

    @isTest
    static void testGetServiceSessionsByStartDate_WithMatchingDateAndStatus() {
        Test.startTest();
        ServiceSessionSelector selector = new ServiceSessionSelector();
        List<ServiceSession__c> result = selector.getServiceSessionsByStartDate('TODAY');
        Test.stopTest();

        System.assertEquals(1, result.size(), 'Should return exactly one matching session');
        System.assertEquals(Date.today(), result[0].SessionStart__c, 'Session date should match TODAY');
    }

    @isTest
    static void testGetServiceSessionsByStartDate_WithNoMatchingDate() {
        Test.startTest();
        ServiceSessionSelector selector = new ServiceSessionSelector();
        List<ServiceSession__c> result = selector.getServiceSessionsByStartDate('NEXT_YEAR');
        Test.stopTest();

        System.assertEquals(0, result.size(), 'Should return no sessions for a future date with no matches');
    }

    @isTest
    static void testGetServiceSessionsByStartDate_InvalidDateLiteral() {
        Boolean didThrowException = false;
        try {
            Test.startTest();
            ServiceSessionSelector selector = new ServiceSessionSelector();
            selector.getServiceSessionsByStartDate('INVALID_DATE');
            Test.stopTest();
        } catch (Exception e) {
            didThrowException = true;
        }

        System.assert(didThrowException, 'Passing an invalid date literal should have caused an exception.');
    }
}
