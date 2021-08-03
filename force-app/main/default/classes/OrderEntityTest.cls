@isTest
public class OrderEntityTest {
    
    public static Account normalAccount;
    public static Contact normalContact;
    public static Account wrongDataAccount;
    public static Contact wrongDataContact;


    @TestSetup
    static void makeData() {
        normalAccount = new Account(Name = 'Normal Account');
        insert normalAccount;
        normalContact = new Contact(AccountId = normalAccount.Id, FirstName = 'Normal', LastName = 'Account', CPF__c = '864.464.227-84');
        insert normalContact;
        
        wrongDataAccount  = new Account(Name = 'Wrong Data Account');
        insert wrongDataAccount;
        wrongDataContact = new Contact(AccountId = wrongDataAccount.Id, FirstName = 'Wrong Data', LastName = 'Account', CPF__c = '00000000000');
        insert wrongDataContact;

        
        Coupon__c exampleCoupon = new Coupon__c(Name = 'TEST_COUPON', DiscountPercentage__c = 0.2);
        insert exampleCoupon;

    }

    @isTest
    static void testInvalidCPF() {

        String cpf = '111.111.111-11';

        try {
            OrderEntity newOrder = new OrderEntity(cpf);
        } catch(Exception e) { 
            System.assertEquals(true,e.getMessage().contains('Invalid CPF'),'Failed to validate order creation with invalid cpf.');
        }
    
    }

    @isTest
    static void testValidCPF() {

        String cpf = '864.464.227-84';

        OrderEntity newOrder = new OrderEntity(cpf);
    
    }

}
