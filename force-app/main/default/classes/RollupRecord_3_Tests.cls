
@isTest
private class RollupRecord_3_Tests {

    // Preparing test data
    @testSetup
    static void setupTestData() {
        // Since the RollupRecord class doesn't require specific setup, we're leaving this empty.
        // Normally, this is where we would insert any required test records.
    }

    // Test when totalProcessed is equal to totalRecords (Processed)
    @isTest
    static void testIsProcessedWhenEqual() {
        RollupRecord rollup = new RollupRecord(null);
        rollup.setTotalRecords(5);
        // We simulate processing 5 records
        for(Integer i = 0; i < 5; i++) {
            rollup.incrementProcessed();
        }
        
        // Assertion
        System.assertEquals(true, rollup.getIsProcessed(), 'The record should be considered processed.');
    }

    // Test when totalProcessed is greater than totalRecords (Processed)
    @isTest
    static void testIsProcessedWhenGreaterThan() {
        RollupRecord rollup = new RollupRecord(null);
        rollup.setTotalRecords(3);
        // We simulate processing 5 records, which is greater than 3 (totalRecords)
        for(Integer i = 0; i < 5; i++) {
            rollup.incrementProcessed();
        }
        
        // Assertion
        System.assertEquals(true, rollup.getIsProcessed(), 'The record should be considered processed.');
    }

    // Test when totalProcessed is less than totalRecords (Not Processed)
    @isTest
    static void testIsProcessedWhenLessThan() {
        RollupRecord rollup = new RollupRecord(null);
        rollup.setTotalRecords(10);
        // We simulate processing only 5 records, which is less than 10 (totalRecords)
        for(Integer i = 0; i < 5; i++) {
            rollup.incrementProcessed();
        }
        
        // Assertion
        System.assertEquals(false, rollup.getIsProcessed(), 'The record should not be considered processed.');
    }

    // Test when totalRecords is null (Processed by default)
    @isTest
    static void testIsProcessedWhenTotalRecordsIsNull() {
        RollupRecord rollup = new RollupRecord(null);
        // No need to set totalRecords as it is null by default
        
        // Assertions
        System.assertEquals(true, rollup.getIsProcessed(), 'The record should be considered processed when totalRecords is null.');
    }
}
