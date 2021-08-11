@isTest
public with sharing class OrderItemEntityTest {
    @isTest
    static void validateOrderItemTotal() {
        OrderItemEntity orderItem = new OrderItemEntity('1',1000,2);
        System.assertEquals(2000,orderItem.getTotal(),'Failed getting the order item total.');
    }
}
