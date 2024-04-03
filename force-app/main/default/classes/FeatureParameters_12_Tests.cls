
@isTest
private class FeatureParameters_12_Tests {

    // Utility method to bypass triggers for all test methods
    private static void bypassTriggers() {
        TriggerHandler.bypass('AccountTriggerHandler');
        TriggerHandler.bypass('MDTAccountTriggerHandler');
    }

    // Happy Path Test for ActivePrograms send method
    @isTest
    static void testActiveProgramsSendHappyPath() {
        bypassTriggers();

        // Mock the behavior of the Finder class using a predefined interface IFinder
        IFinder mockFinder = new MockFinder(10); // Stubbing findCount() to return 10
        FeatureParameters.ActivePrograms activePrograms = new FeatureParameters().new ActivePrograms();
        activePrograms.setFinder(mockFinder);
        
        // Mock the behavior of FeatureManagement class
        MockFeatureManagement mockFeatureManagement = new MockFeatureManagement();
        Test.setMock(FeatureManagement.class, mockFeatureManagement);

        // Call the method under test
        activePrograms.send();

        // Assert that the package integer value was set correctly
        System.assertEquals(1, mockFeatureManagement.callCount, 'FeatureManagement.setPackageIntegerValue should be called once.');
        System.assertEquals(10, mockFeatureManagement.lastSetValue, 'FeatureManagement.setPackageIntegerValue should be called with the correct value.');
    }

    // Mock of the FeatureManagement class
    private class MockFeatureManagement implements FeatureManagement {
        Integer callCount = 0;
        Integer lastSetValue = null;

        public override void setPackageIntegerValue(String name, Integer value) {
            callCount++;
            lastSetValue = value;
        }
    }

    // Interface that the Finder class should implement
    public interface IFinder {
        Integer findCount();
    }

    // Mock of the Finder class implementing the IFinder interface
    private class MockFinder implements IFinder {
        private Integer returnCount;

        public MockFinder(Integer returnCount) {
            this.returnCount = returnCount;
        }

        public Integer findCount() {
            return returnCount;
        }
    }
}
