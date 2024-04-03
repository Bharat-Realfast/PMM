
@isTest
private class StripInaccessibleRecipes_2_Tests {

    @testSetup
    static void setupTestData() {
        // Create test records for ProgramEngagement__c
        ProgramEngagement__c engagement = new ProgramEngagement__c(
            // Assume necessary fields are populated here
        );
        insert engagement;

        // Create related Service__c records if necessary, with the correct relationship field

        // For this example, assume the relationship field on Service__c that looks up to ProgramEngagement__c is named ProgramEngagementLookup__c
        // Service__c service1 = new Service__c(ProgramEngagementLookup__c = engagement.Id, ...);
        // Service__c service2 = new Service__c(ProgramEngagementLookup__c = engagement.Id, ...);
        // insert new List<Service__c>{service1, service2};
    }

    @isTest
    static void testGetServicesByProgramEngagementWithServices() {
        // Get test data
        ProgramEngagement__c testEngagement = [SELECT Id FROM ProgramEngagement__c LIMIT 1];
        Id engagementId = testEngagement.Id;

        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Test.startTest();
        List<Object> resultServices = ServiceDeliveryController.getServicesByProgramEngagementId(engagementId);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, resultServices, 'The result should not be null');
        // Adjust the expected number based on the test data setup in setupTestData method
        // System.assertEquals(expectedNumberOfServices, resultServices.size(), 'There should be services associated with the engagement');
    }

    @isTest
    static void testGetServicesByProgramEngagementWithoutServices() {
        // Create a ProgramEngagement record that has no services associated with it
        ProgramEngagement__c engagement = new ProgramEngagement__c(
            // Assume necessary fields are populated here
        );
        insert engagement;

        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Test.startTest();
        List<Object> resultServices = ServiceDeliveryController.getServicesByProgramEngagementId(engagement.Id);
        Test.stopTest();

        // Assertions
        System.assertNotEquals(null, resultServices, 'The result should not be null');
        System.assertEquals(0, resultServices.size(), 'There should be no services associated with the new engagement');
    }

    @isTest
    static void testGetServicesByProgramEngagementWithNullId() {
        // Bypass triggers
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');

        Test.startTest();
        try {
            ServiceDeliveryController.getServicesByProgramEngagementId(null);
            System.assert(false, 'Method did not throw an exception when passing null as parameter');
        } catch (Exception e) {
            System.assert(e instanceof AuraHandledException, 'Expected an AuraHandledException to be thrown');
        }
        Test.stopTest();
    }
}
