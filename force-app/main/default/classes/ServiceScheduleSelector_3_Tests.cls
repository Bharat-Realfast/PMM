
@isTest
private class ServiceScheduleSelector_3_Tests {
    @testSetup
    static void makeTestData() {
        // Setup test data with necessary ServiceSchedule__c and ServiceParticipant__c records
        // We're assuming ServiceSchedule__c and ServiceParticipant__c are custom objects and Status__c is a custom field
        ServiceSchedule__c ss = new ServiceSchedule__c(/*initialize fields as necessary*/);
        insert ss;

        ServiceParticipant__c sp = new ServiceParticipant__c(
            ServiceSchedule__c = ss.Id,
            Status__c = 'Enrolled'
        );
        insert sp;
    }

    @isTest
    static void testWithParticipants() {
        // Query the test data
        ServiceSchedule__c ss = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        
        // Call the method and assert the results
        ServiceScheduleSelector selector = new ServiceScheduleSelector();
        List<ServiceSchedule__c> schedules = selector.getSchedulesWithParticipants(new Set<Id>{ss.Id});
        
        System.assertEquals(1, schedules.size(), 'Should return one schedule');
        System.assertNotEquals(null, schedules[0].ServiceParticipants__r, 'Should have related participants');
    }

    @isTest
    static void testWithoutParticipants() {
        // Query the test data to get a ServiceSchedule__c record with no ServiceParticipant__c records or with non-enrolled participants
        ServiceSchedule__c ss = new ServiceSchedule__c(/*initialize fields*/);
        insert ss; // No participants are enrolled for this schedule in setup

        ServiceScheduleSelector selector = new ServiceScheduleSelector();
        List<ServiceSchedule__c> schedules = selector.getSchedulesWithParticipants(new Set<Id>{ss.Id});

        System.assertEquals(1, schedules.size(), 'Should return one schedule');
        System.assertEquals(true, schedules[0].ServiceParticipants__r.isEmpty(), 'Should have no related participants');
    }

    // Additional test methods for scenarios such as 'testNoPermission' and 'testEmptyInput' remain the same as in the initial code provided.
}
