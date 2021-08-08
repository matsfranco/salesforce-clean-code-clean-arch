public with sharing class PlaceOrderInput {
    
    String cpf;
    String zipcode;
    List<OrderItemEntity> items;
    String coupon;
    
    public PlaceOrderInput(String cpf, String zipCode, List<OrderItemEntity> items, String coupon) {
        this.cpf = cpf;
        this.zipcode = zipcode;
        this.items = items;
        this.coupon = coupon;
    }
}
