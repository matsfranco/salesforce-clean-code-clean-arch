@isTest
public with sharing class PlaceOrderTest {

    @TestSetup
    static void makeData(){
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
    }


    @isTest
    static void validatePlaceCommonOrder() {
        String inputJSON = 
        '{'+                                  
            '"cpf": "778.278.412-36",'+         
            '"zipcode": "11.111-11",'+           
            '"items": ['+                        
                '{ "productCode": "1", "quantity": 2.0},'+    
                '{ "productCode": "2", "quantity": 1.0},'+    
                '{ "productCode": "3", "quantity": 3.0}'+     
            '],'+                              
            '"couponCode": "VALE20"'+                
        '}';
        PlaceOrderInput input = (PlaceOrderInput) JSON.deserialize(inputJSON,PlaceOrderInput.class);   
        Product2Repository productRepository = new Product2RepositoryMemory();
        CouponRepository couponRepository = new CouponRepositoryMemory();
        OrderRepository orderRepository = new OrderRepositoryMemory();
        ZipCodeDistanceCalculatorAPI zipCodeCalculator = new ZipCodeDistanceCalculatorAPIMemory();
        PlaceOrder placeOrder = new PlaceOrder(productRepository,couponRepository,orderRepository,zipCodeCalculator);
        PlaceOrderOutput output = placeOrder.execute(input);
        System.assertEquals(5982.0,output.total,'Failed to validate a common place order.');
    }

    @isTest
    static void validatePlaceCommonOrderWithExpiredCoupon() {
        String inputJSON = 
        '{'+                                  
            '"cpf": "778.278.412-36",'+         
            '"zipcode": "11.111-11",'+           
            '"items": ['+                        
                '{ "productCode": "1", "quantity": 2.0},'+    
                '{ "productCode": "2", "quantity": 1.0},'+    
                '{ "productCode": "3", "quantity": 3.0}'+     
            '],'+                              
            '"couponCode": "VALE20_EXPIRED"'+                
        '}';
        PlaceOrderInput input = (PlaceOrderInput) JSON.deserialize(inputJSON,PlaceOrderInput.class);   
        Product2Repository productRepository = new Product2RepositoryMemory();
        CouponRepository couponRepository = new CouponRepositoryMemory();
        OrderRepository orderRepository = new OrderRepositoryMemory();
        ZipCodeDistanceCalculatorAPI zipCodeCalculator = new ZipCodeDistanceCalculatorAPIMemory();
        PlaceOrder placeOrder = new PlaceOrder(productRepository,couponRepository,orderRepository,zipCodeCalculator);
        PlaceOrderOutput output = placeOrder.execute(input);
        System.assertEquals(7400.0,output.total,'Failed to validate a common place order.');
    }

    @isTest
    static void validatePlaceOrderFreightPrice() {
        String inputJSON = 
        '{'+                                  
            '"cpf": "778.278.412-36",'+         
            '"zipcode": "11.111-11",'+           
            '"items": ['+                        
                '{ "productCode": "1", "quantity": 2.0},'+    
                '{ "productCode": "2", "quantity": 1.0},'+    
                '{ "productCode": "3", "quantity": 3.0}'+     
            '],'+                              
            '"couponCode": "VALE20_EXPIRED"'+                
        '}';
        PlaceOrderInput input = (PlaceOrderInput) JSON.deserialize(inputJSON,PlaceOrderInput.class);   
        Product2Repository productRepository = new Product2RepositoryDatabase(new InfraDatabaseSFDC());
        CouponRepository couponRepository = new CouponRepositoryMemory();
        OrderRepository orderRepository = new OrderRepositoryMemory();
        ZipCodeDistanceCalculatorAPI zipCodeCalculator = new ZipCodeDistanceCalculatorAPIMemory();
        PlaceOrder placeOrder = new PlaceOrder(productRepository,couponRepository,orderRepository,zipCodeCalculator);
        PlaceOrderOutput output = placeOrder.execute(input);
        System.assertEquals(310.0,output.freightPrice,'Failed to validate a common place order.');
    }
}
