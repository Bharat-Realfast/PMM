
@isTest
private class ServiceSelector_2_Tests {
    
    // Use @testSetup to create test data
    @testSetup
    static void setupTestData() {
        ProgramEngagement__c programEngagement = new ProgramEngagement__c(Name = 'Test Engagement 1');
        insert programEngagement;

        Service__c service = new Service__c(Name = 'Test Service 1', Program__c = programEngagement.Id);
        insert service;
    }

    // Test Method for Happy Path
    @isTest
    static void testGetServicesByProgramEngagementIdHappyPath() {
        // Obtaining test data
        ProgramEngagement__c programEngagement = [SELECT Id FROM ProgramEngagement__c LIMIT 1];

        ServiceSelector selector = new ServiceSelector();
        List<Service__c> services = selector.getServicesByProgramEngagementId(programEngagement.Id);

        // Assertions
        System.assertNotEquals(null, services, 'Services should not be null');
        System.assertEquals(1, services.size(), 'Should return one service record');
    }

    // Test Method for Sad Path (no access to Service__c)
    @isTest
    static void testGetServicesByProgramEngagementIdNoAccess() {
        // Set up test to run as a user with no access to Service__c
        User noAccessUser = [SELECT Id FROM User WHERE Profile.Name = 'Standard User' LIMIT 1];
        System.runAs(noAccessUser) {
            ServiceSelector selector = new ServiceSelector();
            ProgramEngagement__c programEngagement = [SELECT Id FROM ProgramEngagement__c LIMIT 1];

            List<Service__c> services = selector.getServicesByProgramEngagementId(programEngagement.Id);

            // Assertions
            System.assertEquals(0, services.size(), 'Should return an empty list due to lack of access');
        }
    }
}
