
@isTest
public class ServiceSelector_4_Tests {

    @testSetup
    static void setupTestData() {
        // Create test data for ServiceSchedule__c
        ServiceSchedule__c schedule = new ServiceSchedule__c(Name = 'Test Schedule');
        insert schedule;
        
        // Create test ServiceSession__c records
        ServiceSession__c sessionBefore = new ServiceSession__c(
            ServiceSchedule__c = schedule.Id,
            SessionStart__c = Date.today()
        );
        ServiceSession__c sessionAfter = new ServiceSession__c(
            ServiceSchedule__c = schedule.Id,
            SessionStart__c = Date.today().addDays(1)
        );
        insert new List<ServiceSession__c> { sessionBefore, sessionAfter };
    }

    @isTest
    static void testGetSessionsAfter_HappyPath() {
        // Given
        Date startDate = Date.today();
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        
        // When
        Test.startTest();
        List<ServiceSession__c> result = new ServiceSelector().getSessionsAfter(schedule.Id, startDate);
        Test.stopTest();
        
        // Then
        System.assertEquals(1, result.size(), 'Should only find one session after start date');
        System.assert(result[0].SessionStart__c > startDate, 'Found session should be after start date');
    }

    @isTest
    static void testGetSessionsAfter_NoSessionsFound() {
        // Given
        Date startDate = Date.today().addDays(2); // Future date where no sessions would have occurred
        ServiceSchedule__c schedule = [SELECT Id FROM ServiceSchedule__c LIMIT 1];
        
        // When
        Test.startTest();
        List<ServiceSession__c> result = new ServiceSelector().getSessionsAfter(schedule.Id, startDate);
        Test.stopTest();
        
        // Then
        System.assertEquals(0, result.size(), 'Should not find any sessions after future start date');
    }

    @isTest
    static void testGetSessionsAfter_InvalidInput() {
        // Testing the behavior with null or invalid inputs
        // Given
        Date startDate = null;
        Id scheduleId = null;
        
        // When
        List<ServiceSession__c> result = new ServiceSelector().getSessionsAfter(scheduleId, startDate);
        
        // Then
        System.assertEquals(0, result.size(), 'Should not return any sessions due to invalid input');
    }
}
