
@isTest
private class ServiceDeliverySelector_3_Tests {

    // Assuming Service__c is an object that has a custom field AttendanceFieldSet__c.
    // Assuming ServiceSchedule__c is an object that has a lookup to Service__c.

    @testSetup
    static void makeData() {
        // Create a mock Service__c record with an AttendanceFieldSet__c value
        Service__c testService = new Service__c(
            AttendanceFieldSet__c = 'TestFieldSet'
        );
        insert testService;

        // Create a ServiceSchedule__c record related to the Service__c record
        ServiceSchedule__c testSchedule = new ServiceSchedule__c(
            Service__c = testService.Id
        );
        insert testSchedule;
    }
    
    @isTest
    static void testGetAttendanceFieldSetNameWithValidSchedule() {
        // Retrieve the test data
        ServiceSchedule__c testSchedule = [SELECT Id, Service__r.AttendanceFieldSet__c FROM ServiceSchedule__c LIMIT 1];
        
        // Call the method
        ServiceDeliverySelector selector = new ServiceDeliverySelector();
        String attendanceFieldSetName = selector.getAttendanceFieldSetName(testSchedule.Id);
        
        // Validate the results
        System.assertNotEquals(null, attendanceFieldSetName, 'Attendance field set name should not be null');
        System.assertEquals('TestFieldSet', attendanceFieldSetName, 'Attendance field set name should match expected value');
    }
    
    @isTest
    static void testGetAttendanceFieldSetNameWithNoScheduleFound() {
        // Create a random Id that won't match any ServiceSchedule__c record
        Id randomScheduleId = Id.valueOf('a04500000000000AAA');
        
        // Call the method
        ServiceDeliverySelector selector = new ServiceDeliverySelector();
        String attendanceFieldSetName = selector.getAttendanceFieldSetName(randomScheduleId);
        
        // Validate the results
        System.assertEquals(null, attendanceFieldSetName, 'Attendance field set name should be null for non-existent schedules');
    }
    
    @isTest
    static void testGetAttendanceFieldSetNameWithNullScheduleId() {
        // Call the method with a null Id
        ServiceDeliverySelector selector = new ServiceDeliverySelector();
        String attendanceFieldSetName = selector.getAttendanceFieldSetName(null);
        
        // Validate the results
        System.assertEquals(null, attendanceFieldSetName, 'Attendance field set name should be null when scheduleId is null');
    }
}
