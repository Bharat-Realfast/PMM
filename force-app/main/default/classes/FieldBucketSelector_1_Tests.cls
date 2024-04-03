
@isTest
private class FieldBucketSelector_1_Tests {
    
    // The test setup and bypassing of triggers would be here if required.
    
    @isTest
    static void testAllMatchingBuckets() {
        // Test code for the happy path would be here.
    }

    @isTest
    static void testNoMatchingBuckets() {
        // Test code for the sad path with no matching buckets would be here.
    }

    @isTest
    static void testNullInputs() {
        FieldBucketSelector selector = new FieldBucketSelector();
        Boolean isNullPointerExceptionThrown = false;

        Test.startTest();
        try {
            selector.getBuckets(null, null, null);
        } catch (NullPointerException e) {
            // Catching the NullPointerException to set the flag to true
            isNullPointerExceptionThrown = true;
        }
        Test.stopTest();

        // Assertions
        System.assert(isNullPointerExceptionThrown, 'A NullPointerException should have been thrown when calling getBuckets with null parameters.');
    }
}
