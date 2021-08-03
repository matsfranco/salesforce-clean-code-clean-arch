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
        Coupon__c validCoupon = new Coupon__c(Name = 'TEST_COUPON_50_VALID', DiscountPercentage__c = 0.5, ExpirationDate__c = Datetime.now().addDays(30));
        insert validCoupon;
        Coupon__c expiredCoupon = new Coupon__c(Name = 'TEST_COUPON_50_INVALID', DiscountPercentage__c = 0.5, ExpirationDate__c = Datetime.now().addDays(-30));
        insert expiredCoupon;
        createdProductAndPricebookSet();        
    }

    private static void createdProductAndPricebookSet() {
        List<Product2> products = new List<Product2>();
        List<PricebookEntry> entries = new List<PricebookEntry>();

        for(Integer i = 0; i < 6; i++) {
            products.add(new Product2(Name = 'Product '+String.valueOf(i), ProductCode = String.valueOf(100*i), IsActive = true, GrossWeight__c = 100*i));
        }
        database.insert(products);

        Pricebook2 standardPricebook = new Pricebook2(Id = Test.getStandardPricebookId(),IsActive = false);
        database.update(standardPricebook);

        Pricebook2 activePricebook = new Pricebook2(Name = 'Active Pricebook', IsActive = true, Description = 'Active Pricebook for testing');
        database.insert(activePricebook);

        for(Product2 p : products) {
            entries.add(new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(), Product2Id = p.Id, UnitPrice = Decimal.valueOf(p.ProductCode), IsActive = True));
            entries.add(new PricebookEntry(Pricebook2Id = activePricebook.Id, Product2Id = p.Id, UnitPrice = Decimal.valueOf(p.ProductCode), IsActive = True));
        }
        database.insert(entries);
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
    static void testThreeItemsOrder() {
        String cpf = '864.464.227-84';
        OrderEntity newOrder = new OrderEntity(cpf);
        newOrder.addItem('100',2);
        newOrder.addItem('200',2);
        newOrder.addItem('300',1);
        System.assertEquals(900.0,newOrder.getTotal(),'Failed to create an order');
    }

    @isTest
    static void testThreeItemsOrderWithCoupon() {
        String cpf = '864.464.227-84';
        OrderEntity newOrder = new OrderEntity(cpf);
        newOrder.addItem('100',2);
        newOrder.addItem('200',2);
        newOrder.addItem('300',1);
        System.assertEquals(450.0,newOrder.addCoupon('TEST_COUPON_50_VALID'),'Failed to create an order');
    }

    @isTest
    static void testThreeItemsOrderWithInvaliudCoupon() {
        String cpf = '864.464.227-84';
        OrderEntity newOrder = new OrderEntity(cpf);
        newOrder.addItem('100',2);
        newOrder.addItem('200',2);
        newOrder.addItem('300',1);
        try {
            newOrder.addCoupon('TEST_COUPON_50_INVALID');
        } catch(Exception e) { 
            System.assertEquals(true,e.getMessage().contains('Invalid'),'Failed to prevent invalid coupon to be added!');
        }
    }


}
