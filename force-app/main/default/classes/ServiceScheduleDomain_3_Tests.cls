
@isTest
private class ServiceScheduleDomain_3_Tests {

    @testSetup
    static void makeData() {
        // Set up test data, if required by the tests
        // For example, you could create some ServiceSession__c records here
    }
    
    @isTest
    static void testDeleteSessionsWithAccess() {
        // Arrange
        List<ServiceSession__c> sessionsToDelete = new List<ServiceSession__c>{
            new ServiceSession__c(/* initialize required fields */),
            new ServiceSession__c(/* initialize required fields */)
        };
        insert sessionsToDelete;
        
        Test.startTest();
        // Act
        ServiceScheduleDomain domain = new ServiceScheduleDomain();
        domain.deleteSessions(sessionsToDelete);
        Test.stopTest();
        
        // Assert
        List<ServiceSession__c> sessionsQuery = [SELECT Id FROM ServiceSession__c WHERE Id IN :sessionsToDelete];
        System.assertEquals(0, sessionsQuery.size(), 'Sessions should be deleted.');
    }
    
    @isTest
    static void testDeleteSessionsWithEmptyList() {
        // Arrange
        List<ServiceSession__c> sessionsToDelete = new List<ServiceSession__c>(); // Empty list
        Integer beforeDeleteCount = [SELECT count() FROM ServiceSession__c];
        
        Test.startTest();
        // Act
        ServiceScheduleDomain domain = new ServiceScheduleDomain();
        domain.deleteSessions(sessionsToDelete);
        Test.stopTest();
        
        // Assert
        Integer afterDeleteCount = [SELECT count() FROM ServiceSession__c];
        System.assertEquals(beforeDeleteCount, afterDeleteCount, 'The number of ServiceSession__c records should not change when deleting an empty list.');
    }
}
