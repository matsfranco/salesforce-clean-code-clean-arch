public with sharing class OrderItemOutput {
    
    public String description;
    public Decimal price;
    public Decimal quantity;

    public OrderItemOutput(String description, Decimal price, Decimal quantity) {
        this.description = description;
        this.price = price;
        this.quantity = quantity;
    }
}
