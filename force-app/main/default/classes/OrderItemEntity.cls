public with sharing class OrderItemEntity {
    
    public virtual class OrderItemEntityException extends Exception {}
    public String productCode;
    public Decimal price;
    public Decimal quantity; 
    
    public OrderItemEntity(String productCode, Decimal price, Decimal quantity) {
        this.productCode = productCode;
        this.price = price;
        this.quantity = quantity;
    }

    public Decimal getTotal() {
        return this.price * this.quantity;
    }

}
