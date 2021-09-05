@isTest
public class GetOrderTest {
    
    @TestSetup
    static void makeData(){

        List<Account> accounts = new List<Account>();
        Account newAccount1 = new Account(Name = 'Test 1');
        accounts.add(newAccount1);
        Account newAccount2 = new Account(Name = 'Test 2');
        accounts.add(newAccount2);
        Account newAccount3 = new Account(Name = 'Test 3');
        accounts.add(newAccount3);
        Database.insert(accounts);

        List<Product2> products = new List<Product2>();
        Product2 product1 = new Product2(   Name = 'Guitarra',
                                            Description = 'Guitarra',
                                            ProductCode = '1',
                                            Price__c = 1000.0,
                                            Width__c= 100.0, 
                                            Height__c = 50.0,
                                            Length__c = 15.0, 
                                            Weight__c = 3.0);
        products.add(product1);
        Product2 product2 = new Product2(   Name = 'Amplificador',
                                            Description = 'Amplificador',
                                            ProductCode = '2',
                                            Price__c = 5000.0,
                                            Width__c= 50.0, 
                                            Height__c = 50.0,
                                            Length__c = 50.0, 
                                            Weight__c = 22.0);
        products.add(product2);
        Product2 product3 = new Product2(   Name = 'Cabo',
                                            Description = 'Cabo',
                                            ProductCode = '3',
                                            Price__c = 30.0,
                                            Width__c= 10.0, 
                                            Height__c = 10.0,
                                            Length__c = 10.0, 
                                            Weight__c = 1.0);
        products.add(product3);
        database.insert(products);

        Pricebook2 standardPricebook = new Pricebook2(
            Id = Test.getStandardPricebookId(),
            IsActive = true
        );
        database.update(standardPricebook);

        List<PricebookEntry> pricebookEntries = new List<PricebookEntry>();
        for(Product2 product : products) {
            PricebookEntry newPricebookEntry = new PricebookEntry();
            newPricebookEntry.Product2Id = product.Id;
            newPricebookEntry.Pricebook2Id = standardPricebook.Id;
            newPricebookEntry.UnitPrice = product.Price__c;
            newPricebookEntry.IsActive = true;
            pricebookEntries.add(newPricebookEntry);
        }
        database.insert(pricebookEntries);

        List<Coupon__c> coupons = new List<Coupon__c>();
        Coupon__c coupon1 = new Coupon__c(Name = 'VALE20', DiscountPercentage__c = 0.2, ExpirationDate__c = Datetime.newInstance(2021,10,10));
        coupons.add(coupon1);
        Coupon__c coupon2 = new Coupon__c(Name = 'VALE20_EXPIRED', DiscountPercentage__c = 0.2, ExpirationDate__c = Datetime.newInstance(2020,10,10));
        coupons.add(coupon2);
        database.insert(coupons);

    }

    @isTest
    static void validateGetOrder() {
        String inputJSON = 
        '{'+                                  
            '"cpf": "778.278.412-36",'+         
            '"zipcode": "11.111-11",'+           
            '"items": ['+                        
                '{ "productCode": "1", "quantity": 2.0},'+    
                '{ "productCode": "2", "quantity": 1.0},'+    
                '{ "productCode": "3", "quantity": 3.0}'+     
            '],'+   
            '"issueDate": "2021-10-10T00:00:00.000Z",'+                              
            '"couponCode": "VALE20_EXPIRED"'+                
        '}';

        RepositoryFactory repositoryFactory = new DatabaseRepositoryFactory();
        PlaceOrderInput input = (PlaceOrderInput) JSON.deserialize(inputJSON,PlaceOrderInput.class);   
        ZipCodeDistanceCalculatorAPI zipCodeCalculator = new ZipCodeDistanceCalculatorAPIMemory();
        PlaceOrder placeOrder = new PlaceOrder(repositoryFactory,zipCodeCalculator);
        PlaceOrderOutput output = placeOrder.execute(input);
        GetOrder getOrder = new GetOrder(repositoryFactory);
        GetOrderOutput order = getOrder.execute(output.orderNumber);
        System.assertEquals('202100000001', order.orderNumber,'Failed to get Order by Order Number');
        System.assertEquals(3, order.orderItems.size(),'Failed to get Order Items by Order Number');
    }

    @isTest
    static void validateGetOrderWithNotFound() {
        String inputJSON = 
        '{'+                                  
            '"cpf": "778.278.412-36",'+         
            '"zipcode": "11.111-11",'+           
            '"items": ['+                        
                '{ "productCode": "1", "quantity": 2.0},'+    
                '{ "productCode": "2", "quantity": 1.0},'+    
                '{ "productCode": "3", "quantity": 3.0}'+     
            '],'+   
            '"issueDate": "2021-10-10T00:00:00.000Z",'+                              
            '"couponCode": "VALE20_EXPIRED"'+                
        '}';

        RepositoryFactory repositoryFactory = new DatabaseRepositoryFactory();

        PlaceOrderInput input = (PlaceOrderInput) JSON.deserialize(inputJSON,PlaceOrderInput.class);   
        ZipCodeDistanceCalculatorAPI zipCodeCalculator = new ZipCodeDistanceCalculatorAPIMemory();
        PlaceOrder placeOrder = new PlaceOrder(repositoryFactory,zipCodeCalculator);
        PlaceOrderOutput output = placeOrder.execute(input);
        GetOrder getOrder = new GetOrder(repositoryFactory);
         try {
            GetOrderOutput order = getOrder.execute('202100000002');
        } catch (Exception e) {
            System.assertEquals(true,e.getMessage().contains('Order not found'),'Failed to return not fount exception');
        }
    }


}
