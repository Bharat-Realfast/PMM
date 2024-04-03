
@isTest
public class ProgramService_1_Tests {

    @testSetup
    static void makeData() {
        // Create test contact
        Contact testContact = new Contact(LastName = 'TestContact');
        insert testContact;

        // Create test programs with the required Status__c field populated
        Program__c programOne = new Program__c(Name = 'Program One', Status__c = 'Active');
        Program__c programTwo = new Program__c(Name = 'Program Two', Status__c = 'Active');
        insert new List<Program__c>{programOne, programTwo};

        // Create program engagements for the contact
        ProgramEngagement__c engagementOne = new ProgramEngagement__c(
            Program__c = programOne.Id,
            Contact__c = testContact.Id
        );
        ProgramEngagement__c engagementTwo = new ProgramEngagement__c(
            Program__c = programTwo.Id,
            Contact__c = testContact.Id
        );
        
        insert new List<ProgramEngagement__c>{engagementOne, engagementTwo};
    }

    @isTest
    static void testContactWithMultipleEngagements() {
        // Get test contact
        Contact testContact = [SELECT Id FROM Contact LIMIT 1];
        
        Test.startTest();
        
        // Execute method
        ProgramService service = new ProgramService();
        Map<Id, String> programNamesById = service.getProgramNamesByIdForContact(testContact.Id);
        
        Test.stopTest();

        // Assert the results
        System.assertEquals(2, programNamesById.size(), 'Should have two program engagements');
        System.assert(programNamesById.values().contains('Program One'), 'Program One should be present');
        System.assert(programNamesById.values().contains('Program Two'), 'Program Two should be present');
    }

    @isTest
    static void testContactWithSingleEngagement() {
        // Get test contact and delete one engagement to simulate a single engagement
        Contact testContact = [SELECT Id FROM Contact LIMIT 1];
        List<ProgramEngagement__c> engagements = [SELECT Id FROM ProgramEngagement__c WHERE Contact__c = :testContact.Id];
        delete engagements[0];

        Test.startTest();
        
        // Execute method
        ProgramService service = new ProgramService();
        Map<Id, String> programNamesById = service.getProgramNamesByIdForContact(testContact.Id);
        
        Test.stopTest();

        // Assert the results
        System.assertEquals(1, programNamesById.size(), 'Should have one program engagement');
    }

    @isTest
    static void testContactWithNoEngagements() {
        // Create a new contact with no engagements
        Contact newTestContact = new Contact(LastName = 'NoEngagements');
        insert newTestContact;

        Test.startTest();
        
        // Execute method
        ProgramService service = new ProgramService();
        Map<Id, String> programNamesById = service.getProgramNamesByIdForContact(newTestContact.Id);
        
        Test.stopTest();

        // Assert the results
        System.assert(programNamesById.isEmpty(), 'Map should be empty for contact with no engagements');
    }

    @isTest
    static void testNullContactId() {
        Test.startTest();
        
        // Execute method with null ID
        ProgramService service = new ProgramService();
        Map<Id, String> programNamesById = service.getProgramNamesByIdForContact(null);
        
        Test.stopTest();

        // Assert the results
        System.assert(programNamesById.isEmpty(), 'Map should be empty when null contactId is passed');
    }
}
