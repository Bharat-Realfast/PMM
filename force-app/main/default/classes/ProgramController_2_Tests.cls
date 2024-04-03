
@isTest
private class ProgramController_2_Tests {

    @isTest
    static void testGetFieldSetByObjectKeyHappyPath() {
        // Call the method we want to test
        Map<String, Object> result = ProgramController.getFieldSetByObjectKey();
        
        // Assertions to ensure the method returns the correct keys and not null field sets
        System.assertNotEquals(null, result, 'The result should not be null.');
        System.assert(result.containsKey('engagementFieldSet'), 'Engagement field set key should be present in the result.');
        System.assert(result.containsKey('contactFieldSet'), 'Contact field set key should be present in the result.');
    }

    @isTest
    static void testGetFieldSetByObjectKeyExceptionScenario() {
        // Prepare a mock instance of FieldSetService that throws an exception
        FieldSetService mockFieldSetService = (FieldSetService) Test.createStub(
            FieldSetService.class,
            new FieldSetServiceExceptionMock()
        );

        // Inject the mock instance into the ProgramController's fieldSetService
        ProgramController.fieldSetService = mockFieldSetService;

        // Attempt to call the method and verify that an exception is thrown
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            ProgramController.getFieldSetByObjectKey();
        } catch (Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();
        
        // Assert that an exception was thrown
        System.assert(exceptionThrown, 'An exception should have been thrown.');
    }

    // Mock class for testing the exceptional scenario
    private class FieldSetServiceExceptionMock implements StubProvider {
        public Object handleMethodCall(Object stubbedObject, String methodName, Type returnType, List<Type> paramTypes, List<String> paramNames, List<Object> args) {
            if (methodName.equalsIgnoreCase('getFieldSetForLWC')) {
                throw new DmlException('Simulated exception');
            }
            return null;
        }
    }
}
