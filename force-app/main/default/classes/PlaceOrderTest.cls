@isTest
public with sharing class PlaceOrderTest {
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
        PlaceOrder placeOrder = new PlaceOrder(productRepository,couponRepository,orderRepository);
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
        PlaceOrder placeOrder = new PlaceOrder(productRepository,couponRepository,orderRepository);
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
        Product2Repository productRepository = new Product2RepositoryMemory();
        CouponRepository couponRepository = new CouponRepositoryMemory();
        OrderRepository orderRepository = new OrderRepositoryMemory();
        PlaceOrder placeOrder = new PlaceOrder(productRepository,couponRepository,orderRepository);
        PlaceOrderOutput output = placeOrder.execute(input);
        System.assertEquals(310.0,output.freightPrice,'Failed to validate a common place order.');
    }
}
