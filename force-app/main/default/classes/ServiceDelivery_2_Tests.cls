
@isTest
public class ServiceDelivery_2_Tests {

    private static final String ABSENT_STATUS = 'Absent'; // Must align with the ABSENT constant in the ServiceDelivery class

    @testSetup
    static void makeTestData() {
        // Set up test data with known absent status value
        ServiceDelivery__c deliveryAbsent = new ServiceDelivery__c(AttendanceStatus__c = ABSENT_STATUS);
        insert deliveryAbsent;

        ServiceDelivery__c deliveryNotAbsent = new ServiceDelivery__c(AttendanceStatus__c = 'On Leave'); // Assuming 'On Leave' is not an absent status
        insert deliveryNotAbsent;

        ServiceDelivery__c deliveryNullStatus = new ServiceDelivery__c(AttendanceStatus__c = null);
        insert deliveryNullStatus;
    }

    @isTest
    static void testIsAbsentTrue() {
        // Given
        ServiceDelivery__c deliveryAbsent = [SELECT AttendanceStatus__c FROM ServiceDelivery__c WHERE AttendanceStatus__c = :ABSENT_STATUS LIMIT 1];
        ServiceDelivery serviceDeliveryObj = new ServiceDelivery(deliveryAbsent);

        // When
        Boolean isAbsent = serviceDeliveryObj.isAbsent();

        // Then
        System.assertEquals(true, isAbsent, 'The isAbsent method should return true for an absent status');
    }

    @isTest
    static void testIsAbsentFalse() {
        // Given
        ServiceDelivery__c deliveryNotAbsent = [SELECT AttendanceStatus__c FROM ServiceDelivery__c WHERE AttendanceStatus__c != :ABSENT_STATUS AND AttendanceStatus__c != null LIMIT 1];
        ServiceDelivery serviceDeliveryObj = new ServiceDelivery(deliveryNotAbsent);

        // When
        Boolean isAbsent = serviceDeliveryObj.isAbsent();

        // Then
        System.assertEquals(false, isAbsent, 'The isAbsent method should return false for a non-absent status');
    }

    @isTest
    static void testIsAbsentWithNullStatus() {
        // Given
        ServiceDelivery__c deliveryNullStatus = [SELECT AttendanceStatus__c FROM ServiceDelivery__c WHERE AttendanceStatus__c = null LIMIT 1];
        ServiceDelivery serviceDeliveryObj = new ServiceDelivery(deliveryNullStatus);

        // When
        Boolean isAbsent = serviceDeliveryObj.isAbsent();

        // Then
        System.assertEquals(false, isAbsent, 'The isAbsent method should return false when AttendanceStatus__c is null');
    }
}
