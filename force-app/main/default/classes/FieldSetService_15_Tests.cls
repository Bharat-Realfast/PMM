
@isTest
public class FieldSetService_15_Tests {

    @testSetup
    static void setup() {
        // Test data setup is not required for the methods being tested here
    }

    @isTest
    static void testGetNameFieldForLookupFieldWithReference() {
        // Test the happy path where the field is a lookup field with a name field
        Schema.DescribeFieldResult fieldDescribe = Schema.sObjectType.Contact.fields.AccountId.getDescribe();
        
        // Using mocked FieldSetMember since we cannot instantiate this directly
        Schema.FieldSetMember fieldSetMember = new Schema.FieldSetMember(AccountId, true, false);
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(fieldDescribe, fieldSetMember);

        String nameField = fieldInfo.getNameFieldForReferenceField();

        // Expect the 'Name' field from Account object since AccountId is a lookup to Account
        System.assertEquals('Name', nameField, 'The name field for the AccountId lookup should be \'Name\'.');
    }

    @isTest
    static void testGetNameFieldForNonLookupField() {
        // Test the exceptional scenario where the field is not a lookup field
        Schema.DescribeFieldResult fieldDescribe = Schema.sObjectType.Contact.fields.Email.getDescribe();
        
        // Using mocked FieldSetMember since we cannot instantiate this directly
        Schema.FieldSetMember fieldSetMember = new Schema.FieldSetMember(Email, false, true);
        FieldSetService.FieldInfo fieldInfo = new FieldSetService.FieldInfo(fieldDescribe, fieldSetMember);

        String nameField = fieldInfo.getNameFieldForReferenceField();

        // Expect null since Email is not a lookup field
        System.assertEquals(null, nameField, 'The name field for a non-lookup field should be null.');
    }
}
