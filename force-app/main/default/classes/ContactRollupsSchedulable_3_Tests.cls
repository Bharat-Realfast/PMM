
@isTest
private class ContactRollupsSchedulable_3_Tests {

    // Test setup method to create test data
    @testSetup
    static void setup() {
        // Create and insert a list of test Contacts
        List<Contact> testContacts = new List<Contact>();
        for (Integer i = 0; i < 3; i++) {
            testContacts.add(new Contact(
                LastName = 'LastName' + i,
                NumPresentServiceDeliveries__c = Math.floor(Math.random() * 10),
                NumAbsentServiceDeliveries__c = Math.floor(Math.random() * 10),
                LastServiceDate__c = Date.today(),
                ConsecutiveAbsences__c = Math.floor(Math.random() * 10)
            ));
        }
        insert testContacts;
    }

    // Test method for the happy path scenario
    @isTest
    static void testStartMethodHappyPath() {
        Test.startTest();
        // Instantiate the batch class and invoke the start method
        ContactRollupsSchedulable batchInstance = new ContactRollupsSchedulable();
        Database.QueryLocator queryLocator = batchInstance.start(null);
        Test.stopTest();

        // Assert that a QueryLocator is returned and not null
        System.assertNotEquals(null, queryLocator, 'QueryLocator should not be null');
    }
}
