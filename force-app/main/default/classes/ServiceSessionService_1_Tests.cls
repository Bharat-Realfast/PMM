
@isTest
private class ServiceSessionService_1_Tests {

    @testSetup
    static void makeTestData() {
        // Create some test ServiceSessions
        List<ServiceSession__c> sessions = new List<ServiceSession__c>();
        sessions.add(new ServiceSession__c(SessionStart__c = Date.today()));
        sessions.add(new ServiceSession__c(SessionStart__c = Date.today().addDays(1)));
        
        // Insert the test data
        insert sessions;
    }

    @isTest
    static void testGetServiceSessionsByValidStartDate() {
        // Query for sessions by a valid start date
        ServiceSessionService service = new ServiceSessionService();
        Map<String, List<ServiceSession__c>> sessions = service.getServiceSessionsByStartDate('TODAY');

        // Assertions
        System.assertNotEquals(null, sessions);
        System.assertEquals(1, sessions.size(), 'Should have sessions for one start date');
    }

    @isTest
    static void testGetServiceSessionsByInvalidStartDate() {
        // Query for sessions by a date where there are no sessions
        ServiceSessionService service = new ServiceSessionService();
        Map<String, List<ServiceSession__c>> sessions = service.getServiceSessionsByStartDate('NEXT_YEAR');

        // Assertions
        System.assertNotEquals(null, sessions);
        System.assertEquals(0, sessions.size(), 'Should have no sessions for the given start date');
    }

    @isTest
    static void testGetServiceSessionsByInvalidDateLiteral() {
        // Query for sessions by an invalid date literal
        ServiceSessionService service = new ServiceSessionService();
        Boolean didThrowException = false;
        String expectedMessageContains = 'expecting a colon'; // A substring of the expected message for the assertion

        try {
            service.getServiceSessionsByStartDate('INVALID_DATE');
        } catch (QueryException e) {
            didThrowException = true;
            System.assert(e.getMessage().contains(expectedMessageContains), 'The exception message should indicate a problem with the date format.');
        }

        // Assert that an exception was thrown
        System.assert(didThrowException, 'A QueryException should have been thrown due to an invalid date literal.');
    }
}
