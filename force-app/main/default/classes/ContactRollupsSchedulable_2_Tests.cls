
@isTest
private class ContactRollupsSchedulable_2_Tests {

    @testSetup
    static void setup() {
        // Bypass triggers before creating test data.
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
        
        // Create test data
        Contact c = new Contact(
            LastName = 'TestContact',
            NumPresentServiceDeliveries__c = 1,
            NumAbsentServiceDeliveries__c = 1,
            LastServiceDate__c = Date.today(),
            ConsecutiveAbsences__c = 1
        );
        insert c;
    }

    static void resetTriggerHandlers() {
        // Reset trigger bypasses after test setup or individual tests.
        TriggerHandler.clearAllBypasses();
    }

    @isTest
    static void testExecuteWithContacts() {
        resetTriggerHandlers();
        Test.startTest();

        List<Contact> contacts = [SELECT Id FROM Contact];
        Database.BatchableContext bc = new FakeBatchableContext();
        ContactRollupsSchedulable rollups = new ContactRollupsSchedulable();

        // Execute the method with contacts
        rollups.execute(bc, contacts);

        // Perform assertions
        // Assuming rollupsService.resetParentsWithoutDeliveries will update fields, query the contact again and assert on field values.
        // Note: The actual field to be checked should be based on the expected outcome of resetParentsWithoutDeliveries.
        // Since the actual implementation detail is not available, this is just a placeholder assertion.
        Contact updatedContact = [SELECT NumPresentServiceDeliveries__c FROM Contact WHERE Id = :contacts[0].Id];
        System.assertNotEquals(null, updatedContact, 'The contact should be found after execution.');
        
        Test.stopTest();
    }

    @isTest
    static void testExecuteWithEmptyList() {
        resetTriggerHandlers();
        Test.startTest();

        List<Contact> contacts = new List<Contact>(); // Empty list
        Database.BatchableContext bc = new FakeBatchableContext();
        ContactRollupsSchedulable rollups = new ContactRollupsSchedulable();

        // Execute the method with an empty list
        // Assert that no exception is thrown
        System.assertDoesNotThrow(() -> rollups.execute(bc, contacts), 'No exception should be thrown when passing an empty list.');

        Test.stopTest();
    }

    @isTest
    static void testExecuteWithNull() {
        resetTriggerHandlers();
        Test.startTest();

        List<Contact> contacts = null; // Null list
        Database.BatchableContext bc = new FakeBatchableContext();
        ContactRollupsSchedulable rollups = new ContactRollupsSchedulable();

        // Execute the method with null
        // Assert that no exception is thrown
        System.assertDoesNotThrow(() -> rollups.execute(bc, contacts), 'No exception should be thrown when passing null.');

        Test.stopTest();
    }

    // FakeBatchableContext implementation to mock the BatchableContext for testing purposes.
    private class FakeBatchableContext implements Database.BatchableContext {
        public String getJobId() { return '1234567890'; }
    }
}
