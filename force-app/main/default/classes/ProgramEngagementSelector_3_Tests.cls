
@isTest
private class ProgramEngagementSelector_3_Tests {
    
    // This should be replaced with actual bypass mechanism
    private static void bypassTriggers() {
        // Insert bypass logic here
    }
    
    @testSetup
    static void makeTestData() {
        // Create test data for Program__c and Service__c
        Program__c testProgram = new Program__c(Name='Test Program');
        insert testProgram;

        Service__c testService = new Service__c(Program__c = testProgram.Id);
        insert testService;
    }

    @isTest
    static void testGetProgramByServiceIdWithPermissions() {
        bypassTriggers(); // Replace with actual logic to bypass triggers
        
        // Retrieve test Service__c ID
        Service__c testService = [SELECT Id, Program__c FROM Service__c LIMIT 1];
        
        Test.startTest();
        
        ProgramEngagementSelector selector = new ProgramEngagementSelector();
        Program__c result = selector.getProgramByServiceId(testService.Id);
        
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, result, 'Program should not be null');
        System.assertEquals(testService.Program__c, result.Id, 'Program ID should match the Service Program ID');
    }

    @isTest
    static void testGetProgramByServiceIdWithoutPermissions() {
        bypassTriggers(); // Replace with actual logic to bypass triggers
        
        // Retrieve test Service__c ID
        Service__c testService = [SELECT Id, Program__c FROM Service__c LIMIT 1];
        
        // Run as a different user with limited permissions
        User limitedPermissionUser = createUserWithLimitedPermissions();
        insert limitedPermissionUser;

        System.runAs(limitedPermissionUser) {
            Test.startTest();
            
            ProgramEngagementSelector selector = new ProgramEngagementSelector();
            Program__c result = selector.getProgramByServiceId(testService.Id);
            
            Test.stopTest();
            
            // Assertions
            System.assertEquals(null, result, 'Program should be null due to insufficient permissions');
        }
    }

    @isTest
    static void testGetProgramByServiceIdNoProgramFound() {
        bypassTriggers(); // Replace with actual logic to bypass triggers
        
        // Generate a dummy Service ID that does not relate to any Program
        Id dummyServiceId = TestingUtils.createUniqueId(Service__c.SObjectType);
        
        Test.startTest();
        
        ProgramEngagementSelector selector = new ProgramEngagementSelector();
        Program__c result = selector.getProgramByServiceId(dummyServiceId);
        
        Test.stopTest();
        
        // Assertions
        System.assertEquals(null, result, 'Program should be null when no Program is related to the Service ID');
    }
    
    private static User createUserWithLimitedPermissions() {
        // Implement the logic to create a user with limited permissions or query for one
        User limitedUser = new User(/* properties to set up a user with limited permissions */);
        // You'll need to fill in the required fields for the User object
        return limitedUser;
    }
    
    // Utility class for common testing utilities, such as generating unique IDs.
    private class TestingUtils {
        public static Id createUniqueId(Schema.SObjectType sot) {
            String s = String.valueOf(sot.getDescribe().getKeyPrefix()) + '000000000000AAA';
            return (Id)s;
        }
    }
}
