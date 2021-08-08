public with sharing class PlaceOrderInput {
    
    public String cpf;
    public String zipcode;
    public List<OrderItemEntity> items;
    public String coupon;
    
    public PlaceOrderInput(String cpf, String zipCode, List<OrderItemEntity> items, String coupon) {
        this.cpf = cpf;
        this.zipcode = zipcode;
        this.items = items;
        this.coupon = coupon;
    }
}
