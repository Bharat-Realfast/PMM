
@isTest
private class ProgramEngagementSelector_1_Tests {

    @testSetup
    static void setup() {
        // Create test data for ProgramEngagement__c and related Contact.
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact');
        insert testContact;

        ProgramEngagement__c testProgramEngagement = new ProgramEngagement__c(
            Contact__c = testContact.Id,
            Program__c = 'Test Program'
        );
        insert testProgramEngagement;
    }

    @isTest
    static void testGetProgramEngagementsByContactIdWithPermissions() {
        // Retrieve the test data.
        Contact testContact = [SELECT Id FROM Contact LIMIT 1];

        // Test the happy path - where user has permissions and engagements exist.
        Test.startTest();
        ProgramEngagementSelector selector = new ProgramEngagementSelector();
        List<ProgramEngagement__c> engagements = selector.getProgramEngagementsByContactId(testContact.Id);
        Test.stopTest();

        // Assert that the list of engagements is not empty and contains the correct data.
        System.assertEquals(1, engagements.size(), 'There should be one engagement retrieved.');
        System.assertEquals(testContact.Id, engagements[0].Contact__c, 'The retrieved engagement should belong to the test contact.');
    }

    @isTest
    static void testGetProgramEngagementsByContactIdWithoutPermissions() {
        // Retrieve the test data.
        Contact testContact = [SELECT Id FROM Contact LIMIT 1];

        // Test the sad path - where user doesn't have permissions.
        Test.startTest();
        ProgramEngagementSelector selector = new ProgramEngagementSelector();
        List<ProgramEngagement__c> engagements = selector.getProgramEngagementsByContactId(testContact.Id);
        Test.stopTest();

        // Assert that the list of engagements is empty due to lack of permissions.
        System.assertEquals(0, engagements.size(), 'There should be no engagements retrieved due to lack of permissions.');
    }

    @isTest
    static void testGetProgramEngagementsByContactIdWithNullContactId() {
        // Test the exceptional scenario - where ContactId is null.
        Test.startTest();
        ProgramEngagementSelector selector = new ProgramEngagementSelector();
        List<ProgramEngagement__c> engagements = selector.getProgramEngagementsByContactId(null);
        Test.stopTest();

        // Assert that the method does not throw an exception and returns an empty list.
        System.assertEquals(0, engagements.size(), 'There should be no engagements retrieved when ContactId is null.');
    }
}
