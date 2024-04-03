
@isTest
private class FieldSetService_14_Tests {

    @testSetup
    static void setup() {
        // Create test data necessary for the tests
        Account testAccount = new Account(Name='Test Account');
        insert testAccount;
        // Use your project-specific trigger bypassing method here
    }

    @isTest
    static void testGetRegularFieldLabel() {
        // Test the label for a regular field
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(Schema.Account.Industry.getDescribe());
        String label = fieldInfo.getLabel();
        
        System.assertEquals(Schema.Account.Industry.getDescribe().getLabel(), label, 'The label for a regular field did not match the expected value.');
    }
    
    @isTest
    static void testGetSpecialFieldLabel_AccountId() {
        // Test the label for the AccountId field
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(Schema.Opportunity.AccountId.getDescribe());
        String label = fieldInfo.getLabel();
        
        System.assertEquals(Schema.Account.Name.getDescribe().getLabel(), label, 'The label for the AccountId field did not match the expected special value.');
    }

    @isTest
    static void testGetSpecialFieldLabel_OwnerId() {
        // Test the label for the OwnerId field
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(Schema.Account.OwnerId.getDescribe());
        String label = fieldInfo.getLabel();
        
        System.assertEquals(System.Label.Owner_Field, label, 'The label for the OwnerId field did not match the expected special value.');
    }

    // Additional test methods for 'ContactId', following the same pattern as testGetSpecialFieldLabel_AccountId()
    // Note: The actual label comparison for 'ContactId' would need to be determined based on your org's specific setup or label overrides.
    
    // There's no straightforward way to test an invalid field scenario as Salesforce ensures field validity before reaching the getLabel method.
}
