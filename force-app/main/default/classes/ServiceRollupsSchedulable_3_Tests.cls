
@isTest
private class ServiceRollupsSchedulable_3_Tests {

    @testSetup
    static void makeTestData() {
        // Create a Program__c record with the required Status__c field populated
        Program__c program = new Program__c(
            Name = 'Test Program',
            Status__c = 'Active' // Populate the required Status__c field
        );
        insert program;

        // Create a Service__c record with the required fields populated
        Service__c testService = new Service__c(
            NumPresentServiceDeliveries__c = 1,
            NumAbsentServiceDeliveries__c = 1,
            Program__c = program.Id
        );
        insert testService;
    }

    @isTest
    static void shouldReturnNonEmptyQueryLocator() {
        // Run the start method of the batch class
        ServiceRollupsSchedulable batchInstance = new ServiceRollupsSchedulable();
        Database.QueryLocator locator = batchInstance.start(null);
        String queryString = locator.getQuery();

        // Perform assertions
        Test.startTest();
        List<Service__c> services = Database.query(queryString);
        Test.stopTest();

        System.assertNotEquals(null, locator, 'QueryLocator should not be null.');
        System.assertNotEquals(0, services.size(), 'QueryLocator should return non-empty list of services.');
    }

    @isTest
    static void shouldReturnEmptyQueryLocatorIfNoServiceRecords() {
        // Clear test data to simulate 'no records' scenario
        delete [SELECT Id FROM Service__c];

        // Run the start method of the batch class
        ServiceRollupsSchedulable batchInstance = new ServiceRollupsSchedulable();
        Database.QueryLocator locator = batchInstance.start(null);
        String queryString = locator.getQuery();

        // Perform assertions
        Test.startTest();
        List<Service__c> services = Database.query(queryString);
        Test.stopTest();

        System.assertNotEquals(null, locator, 'QueryLocator should not be null.');
        System.assertEquals(0, services.size(), 'QueryLocator should return an empty list of services.');
    }
}
