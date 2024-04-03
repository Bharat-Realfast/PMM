
@isTest
private class ServiceScheduleModel_1_Tests {

    // Use testSetup to create common test data
    @testSetup
    static void makeTestData() {
        // Assuming ServiceSession__c objects don't require additional mandatory fields for this test
        List<ServiceSession__c> testServiceSessions = new List<ServiceSession__c>{
            new ServiceSession__c(Name = 'Session 1'),
            new ServiceSession__c(Name = 'Session 2')
        };
        insert testServiceSessions;
    }

    // Test method for adding new ServiceSession__c records when the list is empty
    @isTest
    static void shouldAddServiceSessionsWhenEmpty() {
        // Arrange
        ServiceScheduleModel model = new ServiceScheduleModel();
        List<ServiceSession__c> sessionsToAdd = [SELECT Id, Name FROM ServiceSession__c];

        // Act
        Test.startTest();
        model.addServiceSessions(sessionsToAdd);
        Test.stopTest();

        // Assert
        System.assertEquals(2, model.serviceSessions.size(), 'Should have 2 service sessions added');
        System.assertEquals(sessionsToAdd[0].Id, model.serviceSessions[0].Id, 'First session should match');
    }

    // Test method for adding new ServiceSession__c records to an existing list
    @isTest
    static void shouldAddServiceSessionsToExistingList() {
        // Arrange
        ServiceScheduleModel model = new ServiceScheduleModel();
        model.serviceSessions.add(new ServiceSession__c(Name = 'Existing Session'));
        List<ServiceSession__c> sessionsToAdd = [SELECT Id, Name FROM ServiceSession__c];

        // Act
        Test.startTest();
        model.addServiceSessions(sessionsToAdd);
        Test.stopTest();

        // Assert
        System.assertEquals(3, model.serviceSessions.size(), 'Should have 3 service sessions including the existing one');
        System.assertEquals('Existing Session', model.serviceSessions[0].Name, 'Existing session should be first');
    }
}
