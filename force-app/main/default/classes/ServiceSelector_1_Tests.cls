
@isTest
private class ServiceSelector_1_Tests {

    @testSetup
    static void setup() {
        List<Program__c> programs = new List<Program__c>();
        for(Integer i = 0; i < 3; i++) {
            Program__c program = new Program__c(Name = 'Test Program ' + i);
            programs.add(program);
        }
        insert programs;

        List<Service__c> services = new List<Service__c>();
        for(Integer i = 0; i < 2; i++) {
            Service__c service = new Service__c(
                Name = 'Test Service ' + i,
                Program__c = programs[i].Id
            );
            services.add(service);
        }
        insert services;
    }

    @isTest
    static void testGetServicesByValidProgramIds() {
        Set<Id> programIds = new Map<Id, Program__c>([SELECT Id FROM Program__c]).keySet();
        ServiceSelector selector = new ServiceSelector();

        Test.startTest();
        List<Service__c> services = selector.getServicesByProgramIds(programIds);
        Test.stopTest();

        System.assertEquals(2, services.size(), 'Should return 2 services for the given program IDs.');
        System.assert(services[0].Program__c != null, 'The service record should be linked to a program.');
    }

    @isTest
    static void testGetServicesByInvalidProgramIds() {
        Set<Id> programIds = new Set<Id>{'a0TestProgram3'}; // Non-existing program ID
        ServiceSelector selector = new ServiceSelector();

        Test.startTest();
        List<Service__c> services = selector.getServicesByProgramIds(programIds);
        Test.stopTest();

        System.assertEquals(0, services.size(), 'Should return 0 services for a non-matching program ID.');
    }

    // We expect that this method will always return an accessible list of services,
    // hence we do not include a test for inaccessible Service__c records.
}
