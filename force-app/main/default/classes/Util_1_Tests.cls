
@isTest
private class Util_1_Tests {

    @isTest
    static void testGetAuraHandledExceptionWithoutCause() {
        Exception ex = new DmlException('Test exception');
        AuraHandledException auraEx = Util.getAuraHandledException(ex);
        System.assertEquals('Test exception', auraEx.getMessage(), 'The message should match the exception message.');
    }
    
    @isTest
    static void testGetAuraHandledExceptionWithCause() {
        Exception causeEx = new DmlException('Test cause');
        Exception ex = new DmlException('Test exception');
        ex.initCause(causeEx);
        
        AuraHandledException auraEx = Util.getAuraHandledException(ex);
        System.assertEquals('Test exception: System.DmlException: Test cause', auraEx.getMessage(), 'The message should include the cause.');
    }

    @isTest
    static void testGetAuraHandledExceptionWithNullException() {
        Exception ex = null;
        
        Boolean isExceptionThrown = false;
        try {
            AuraHandledException auraEx = Util.getAuraHandledException(ex);
        } catch (NullPointerException e) {
            isExceptionThrown = true;
        }
        System.assertEquals(true, isExceptionThrown, 'A NullPointerException should be thrown when the input is null.');
    }
}
