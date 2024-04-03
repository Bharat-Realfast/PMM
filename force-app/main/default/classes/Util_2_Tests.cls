
@isTest
public class Util_2_Tests {

    // Scenario 1: Happy Path - Check if the method returns correct labels and API name for the Account object.
    @isTest
    static void testGetObjectLabelsHappyPath() {
        SObjectType sObjectType = Account.SObjectType;
        
        Test.startTest();
        Map<String, String> labelsMap = Util.getObjectLabels(sObjectType);
        Test.stopTest();
        
        // Assertions
        System.assertNotEquals(null, labelsMap, 'The labels map should not be null');
        System.assertEquals('Accounts', labelsMap.get('objectPluralLabel'), 'The plural label should match Account object plural label');
        System.assertEquals('Account', labelsMap.get('objectLabel'), 'The label should match Account object label');
    }
    
    // Scenario 2: Sad Path - Since the method does not handle null inputs, we expect it to throw an exception.
    // However, in Salesforce, we can't pass a null SObjectType, which would result in a compile-time error.
    // As such, a test for a null SObjectType is not feasible and should not be included.
    
    // No additional test methods are necessary since the getObjectLabels method does not have any other branching logic
    // or exceptional handling that would require further unit tests.
}
