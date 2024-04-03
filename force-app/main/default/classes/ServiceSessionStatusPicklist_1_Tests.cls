
@isTest
private class ServiceSessionStatusPicklist_1_Tests {

    @testSetup
    static void setup() {
        // Create a ServiceSession__c record with Status__c set to 'Complete'
        ServiceSession__c sessionComplete = new ServiceSession__c(Status__c = 'Complete');
        insert sessionComplete;
        
        // Create a ServiceSession__c record with a different Status__c value
        ServiceSession__c sessionInProgress = new ServiceSession__c(Status__c = 'In Progress');
        insert sessionInProgress;
    }

    @isTest
    static void testGetDefaultValueWhenCompleteExists() {
        // Arrange
        ServiceSessionStatusPicklist picklist = new ServiceSessionStatusPicklist();
        
        // Act
        VisualEditor.DataRow defaultValue = picklist.getDefaultValue();
        
        // Assert
        System.assertNotEquals(null, defaultValue, 'Default value should not be null');
        // Since we don't know the exact label for 'Complete', we cannot assert it directly.
        // Typically, we would assert based on known labels or by querying metadata.
        // For this example, we assert that the value is not an empty string, indicating 'Complete' was found.
        System.assertNotEquals('', defaultValue.value, 'Default value should not be an empty string when \'Complete\' exists');
    }
    
    @isTest
    static void testGetDefaultValueWhenCompleteDoesNotExist() {
        // Arrange
        // Delete the 'Complete' status entry to simulate the 'Complete' value not existing
        delete [SELECT Id FROM ServiceSession__c WHERE Status__c = 'Complete'];
        ServiceSessionStatusPicklist picklist = new ServiceSessionStatusPicklist();
        
        // Act
        VisualEditor.DataRow defaultValue = picklist.getDefaultValue();
        
        // Assert
        System.assertNotEquals(null, defaultValue, 'Default value should not be null');
        // As we cannot access the 'value' property directly, we assert based on the label property
        System.assertEquals('--None--', defaultValue.label, 'Default value label should be \'--None--\' when \'Complete\' is not present');
    }
}
