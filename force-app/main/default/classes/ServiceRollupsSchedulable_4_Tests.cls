
@isTest
private class ServiceRollupsSchedulable_4_Tests {
    
    @testSetup
    static void setup() {
        // Insert necessary test data for Service__c object (omitted for brevity)
        // ...
    }

    // Test method to verify that another batch job is executed after the finish method
    @isTest
    static void testFinishMethodTriggersBatch() {
        // Arrange
        Test.startTest();
        // Act
        Database.BatchableContext bc = new MockBatchableContext();
        ServiceRollupsSchedulable rollupsSchedulable = new ServiceRollupsSchedulable();
        rollupsSchedulable.finish(bc);
        // Assert
        Integer jobsQueued = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND Status = 'Queued'];
        Test.stopTest();
        
        System.assertEquals(1, jobsQueued, 'There should be one batch job queued after the finish method is called.');
    }

    // Mock BatchableContext implementation for testing purposes
    private class MockBatchableContext implements Database.BatchableContext {
        public String getJobId() {
            return '1234567890abcdef';
        }

        public Id getChildJobId() {
            return '1234567890abcdef';
        }
    }
}
