
@isTest
public class ServiceDeliveryService_6_Tests {
    
    @isTest
    static void testFiltersConstructorWithValues() {
        // Arrange
        String spStatuses = 'Active,Inactive';
        String peRoles = 'Student,Teacher';
        String peStages = 'Enrolled,Graduated';

        // Act
        ServiceDeliveryService.Filters filters = new ServiceDeliveryService.Filters(spStatuses, peRoles, peStages);

        // Assert
        System.assertEquals(2, filters.excludedServiceParticipantStatuses.size(), 'Incorrect status set size');
        System.assertEquals(2, filters.excludedProgramEngagementRoles.size(), 'Incorrect role set size');
        System.assertEquals(2, filters.excludedProgramEngagementStages.size(), 'Incorrect stage set size');
    }
    
    @isTest
    static void testFiltersConstructorWithEmptyStrings() {
        // Arrange
        String spStatuses = '';
        String peRoles = '';
        String peStages = '';

        // Act
        ServiceDeliveryService.Filters filters = new ServiceDeliveryService.Filters(spStatuses, peRoles, peStages);

        // Assert
        System.assertTrue(filters.excludedServiceParticipantStatuses.contains(''), 'Should contain empty string for statuses');
        System.assertTrue(filters.excludedProgramEngagementRoles.contains(''), 'Should contain empty string for roles');
        System.assertTrue(filters.excludedProgramEngagementStages.contains(''), 'Should contain empty string for stages');
    }
    
    @isTest
    static void testFiltersConstructorWithNull() {
        // Arrange
        String spStatuses = null;
        String peRoles = null;
        String peStages = null;

        // Act
        ServiceDeliveryService.Filters filters = new ServiceDeliveryService.Filters(spStatuses, peRoles, peStages);

        // Assert
        System.assertTrue(filters.excludedServiceParticipantStatuses.isEmpty(), 'Statuses set should be empty for null input');
        System.assertTrue(filters.excludedProgramEngagementRoles.isEmpty(), 'Roles set should be empty for null input');
        System.assertTrue(filters.excludedProgramEngagementStages.isEmpty(), 'Stages set should be empty for null input');
    }
    
    @isTest
    static void testShouldIncludeMethodReturnsTrue() {
        // Arrange
        String spStatuses = 'Inactive';
        String peRoles = 'Parent';
        String peStages = 'Prospect';
        ServiceDeliveryService.Filters filters = new ServiceDeliveryService.Filters(spStatuses, peRoles, peStages);
        
        // Mock ProgramEngagement__r as per actual implementation or use JSON.deserialize
        ProgramEngagement__c engagement = new ProgramEngagement__c(Role__c = 'Student', Stage__c = 'Enrolled');
        // Assuming ServiceParticipant__c and ProgramEngagement__c are valid sObjects and fields
        ServiceParticipant__c participant = new ServiceParticipant__c(
            Status__c = 'Active',
            ProgramEngagement__r = engagement
        );

        // Act
        Boolean result = filters.shouldInclude(participant);

        // Assert
        System.assertTrue(result, 'Participant should be included as they do not match any exclusion filter');
    }
    
    @isTest
    static void testShouldIncludeMethodReturnsFalse() {
        // Arrange
        String spStatuses = 'Active';
        String peRoles = 'Student';
        String peStages = 'Enrolled';
        ServiceDeliveryService.Filters filters = new ServiceDeliveryService.Filters(spStatuses, peRoles, peStages);
        
        // Mock ProgramEngagement__r as per actual implementation or use JSON.deserialize
        ProgramEngagement__c engagement = new ProgramEngagement__c(Role__c = 'Student', Stage__c = 'Enrolled');
        // Assuming ServiceParticipant__c and ProgramEngagement__c are valid sObjects and fields
        ServiceParticipant__c participant = new ServiceParticipant__c(
            Status__c = 'Active',
            ProgramEngagement__r = engagement
        );

        // Act
        Boolean result = filters.shouldInclude(participant);

        // Assert
        System.assertFalse(result, 'Participant should not be included as they match the exclusion filters');
    }
}
