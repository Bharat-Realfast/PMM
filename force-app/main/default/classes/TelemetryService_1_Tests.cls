
@isTest
private class TelemetryService_1_Tests {

    @testSetup
    static void setup() {
        // No setup required for the test as no test data is needed and the target method does not perform DML.
    }

    @isTest
    static void testSendUsageMetricsSuccess() {
        // Instantiate the TelemetryService class
        TelemetryService telemetryService = new TelemetryService();

        // Execute the sendUsageMetrics method within a test context
        Test.startTest();
        telemetryService.sendUsageMetrics();
        Test.stopTest();

        // Assert that no DML statements were issued during the test method execution
        System.assertEquals(0, Limits.getDmlStatements(), 'No DML operations should have been performed.');
    }
}
