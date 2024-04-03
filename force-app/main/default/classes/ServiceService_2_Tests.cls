
@isTest
private class ServiceService_2_Tests {

    @testSetup
    static void makeData() {
        // Setup test data
        ProgramEngagement__c engagement = new ProgramEngagement__c(Name = 'Test Engagement');
        insert engagement;

        Service__c service1 = new Service__c(Name = 'Service 1', Program__c = engagement.Id);
        Service__c service2 = new Service__c(Name = 'Service 2', Program__c = engagement.Id);
        insert new List<Service__c>{service1, service2};
    }

    @isTest
    static void testGetServicesByValidProgramEngagementIdWithServices() {
        // Test for happy path with valid ProgramEngagement__c Id and related Service__c records
        ProgramEngagement__c engagement = [SELECT Id FROM ProgramEngagement__c LIMIT 1];
        ServiceService serviceService = new ServiceService();
        List<Object> services = serviceService.getServicesByProgramEngagementId(engagement.Id);

        System.assertEquals(2, services.size(), 'Expected two services related to the engagement');
    }

    @isTest
    static void testGetServicesByValidProgramEngagementIdWithoutServices() {
        // Test for sad path with valid ProgramEngagement__c Id but no related Service__c records
        ProgramEngagement__c newEngagement = new ProgramEngagement__c(Name = 'New Engagement');
        insert newEngagement;

        ServiceService serviceService = new ServiceService();
        List<Object> services = serviceService.getServicesByProgramEngagementId(newEngagement.Id);

        System.assertEquals(0, services.size(), 'Expected no services related to the new engagement');
    }

    @isTest
    static void testGetServicesByInvalidProgramEngagementId() {
        // Test for exceptional scenario with invalid ProgramEngagement__c Id
        Id fakeId = Schema.SObjectType.ProgramEngagement__c.getKeyPrefix() + 'FAKE';
        ServiceService serviceService = new ServiceService();
        
        // We wrap the method call in try-catch block to assert that an exception is thrown
        try {
            serviceService.getServicesByProgramEngagementId(fakeId);
            System.assert(false, 'No exception was thrown for an invalid ProgramEngagement__c Id');
        } catch (Exception e) {
            System.assert(e instanceof QueryException, 'An unexpected exception type was thrown.');
        }
    }
}
