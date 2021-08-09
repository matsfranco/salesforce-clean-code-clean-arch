public with sharing class PlaceOrderInput {
    
    public String cpf;
    public String zipcode;
    public List<Item> items;
    public String couponCode;
    
    public PlaceOrderInput(String cpf, String zipCode, List<Item> items, String couponCode) {
        this.cpf = cpf;
        this.zipcode = zipcode;
        this.items = items;
        this.couponCode = couponCode;
    }
}
