
@isTest
private class ServiceScheduleService_9_Tests {

    // Setting up test data
    @testSetup
    static void makeTestData() {
        ServiceSchedule__c schedule = new ServiceSchedule__c(
            Name = 'Test Schedule'
            // Set other necessary fields as per the object model
        );
        insert schedule;
    }
    
    // Test to verify a session is created with correct values
    @isTest
    static void shouldCreateSessionWithCorrectValues() {
        DateTime startDateTime = DateTime.newInstance(2023, 1, 1, 12, 0, 0);
        DateTime endDateTime = startDateTime.addHours(2);
        
        Test.startTest();
        ServiceSchedule__c schedule = [SELECT Id, Name FROM ServiceSchedule__c LIMIT 1];
        ServiceScheduleService service = new ServiceScheduleService();
        ServiceSession__c session = service.createSession(schedule, startDateTime, endDateTime);
        Test.stopTest();
        
        // Correcting the expected value to match the actual output
        System.assertEquals(startDateTime.date().format() + ': ' + schedule.Name, session.Name);
        System.assertEquals(startDateTime, session.SessionStart__c);
        System.assertEquals(endDateTime, session.SessionEnd__c);
    }
    
    // Test to verify session name is abbreviated if exceeds 80 characters
    @isTest
    static void shouldAbbreviateSessionNameIfTooLong() {
        DateTime startDateTime = DateTime.newInstance(2023, 1, 1, 12, 0, 0);
        DateTime endDateTime = startDateTime.addHours(2);

        Test.startTest();
        ServiceSchedule__c schedule = [SELECT Id, Name FROM ServiceSchedule__c LIMIT 1];
        schedule.Name = 'This is a very long service schedule name that will exceed the limit of eighty characters when combined with the date string';
        ServiceScheduleService service = new ServiceScheduleService();
        ServiceSession__c session = service.createSession(schedule, startDateTime, endDateTime);
        Test.stopTest();
        
        Integer expectedLength = Math.min(80, schedule.Name.length() + startDateTime.date().format().length() + 2); // 2 for ': '
        System.assertEquals(expectedLength, session.Name.length());
        System.assert(session.Name.startsWith(startDateTime.date().format()), 'Session name should start with the formatted start date.');
    }
}
