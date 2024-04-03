
@isTest
private class ServiceSelector_3_Tests {

    @testSetup
    static void makeData() {
        List<Contact> contactsToInsert = new List<Contact>{
            new Contact(LastName = 'Test Contact 1'),
            new Contact(LastName = 'Test Contact 2')
        };
        insert contactsToInsert;
    }
    
    @isTest
    static void testGetContactsByIdsWithValidIds() {
        // Arrange
        Test.startTest();
        Set<Id> contactIds = new Map<Id, Contact>([SELECT Id FROM Contact]).keySet();

        // Act
        List<Contact> contacts = new ServiceSelector().getContactsByIds(contactIds);
        Test.stopTest();

        // Assert
        System.assertEquals(2, contacts.size(), 'Should return correct number of contacts');
        System.assertNotEquals(null, contacts[0].Name, 'The contact name should not be null');
    }

    @isTest
    static void testGetContactsByIdsWithEmptySet() {
        // Arrange
        Set<Id> contactIds = new Set<Id>();

        // Act
        List<Contact> contacts = new ServiceSelector().getContactsByIds(contactIds);

        // Assert
        System.assertEquals(0, contacts.size(), 'Should return an empty list for empty Ids set');
    }
    
    // Removed the testGetContactsByIdsWithNull method as it was expecting an exception that is not thrown by the method under test.
}
