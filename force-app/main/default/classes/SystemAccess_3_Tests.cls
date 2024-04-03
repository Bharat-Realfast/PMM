
@isTest
private class SystemAccess_3_Tests {

    @testSetup
    static void setup() {
        // Create test data for various scenarios
        // This setup should create Accounts, Contacts, ServiceSchedule__c, and ServiceDelivery__c records and associate them accordingly.
        // Please replace the placeholders with actual object and field names that exist in your org.

        // Create test accounts
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Create a ServiceSchedule__c record
        ServiceSchedule__c testSchedule = new ServiceSchedule__c(
            // Set necessary fields and associate with Account if needed
        );
        insert testSchedule;
        
        // Create ServiceDelivery__c records associated with the Account and ServiceSchedule
        ServiceDelivery__c serviceDelivery = new ServiceDelivery__c(
            // Set necessary fields
            // Account__c = testAccount.Id,
            // ServiceSchedule__c = testSchedule.Id // Or whatever the lookup field to ServiceSchedule is
        );
        insert serviceDelivery;
    }

    @isTest
    static void testGetParentsHavingDeliveriesForRegularSObjects() {
        List<Account> testAccounts = [SELECT Id FROM Account];
        
        SystemAccess systemAccess = new SystemAccess();
        List<SObject> parents = systemAccess.getParentsHavingDeliveries(
            Account.SObjectType, 'Account__c', testAccounts);
        
        System.assert(!parents.isEmpty(), 'At least one parent account with deliveries should be returned.');
        System.assertEquals(testAccounts.size(), parents.size(), 'Number of parent accounts should match the number of accounts with deliveries.');
    }
    
    @isTest
    static void testGetParentsHavingDeliveriesForServiceSchedule() {
        List<ServiceSchedule__c> testSchedules = [SELECT Id FROM ServiceSchedule__c];
        
        SystemAccess systemAccess = new SystemAccess();
        List<SObject> serviceDeliveries = systemAccess.getParentsHavingDeliveries(
            ServiceSchedule__c.SObjectType, 'RelatedServiceSchedule__c', testSchedules);
        
        System.assert(!serviceDeliveries.isEmpty(), 'At least one service delivery with related service schedule should be returned.');
    }

    @isTest
    static void testGetParentsHavingNoDeliveries() {
        Account noDeliveryAccount = new Account(Name = 'No Delivery Account');
        insert noDeliveryAccount;
        
        List<Account> testAccounts = new List<Account>{noDeliveryAccount};
        
        SystemAccess systemAccess = new SystemAccess();
        List<SObject> parents = systemAccess.getParentsHavingDeliveries(
            Account.SObjectType, 'Account__c', testAccounts);
        
        System.assert(parents.isEmpty(), 'Parents without deliveries should not be returned.');
    }

    @isTest
    static void testGetParentsForServiceScheduleWithNoDeliveries() {
        ServiceSchedule__c noDeliverySchedule = new ServiceSchedule__c(
            // Set necessary fields
        );
        insert noDeliverySchedule;
        
        List<ServiceSchedule__c> testSchedules = new List<ServiceSchedule__c>{noDeliverySchedule};
        
        SystemAccess systemAccess = new SystemAccess();
        List<SObject> serviceDeliveries = systemAccess.getParentsHavingDeliveries(
            ServiceSchedule__c.SObjectType, 'RelatedServiceSchedule__c', testSchedules);
        
        System.assert(serviceDeliveries.isEmpty(), 'Service deliveries without related service schedules should not be returned.');
    }
}
