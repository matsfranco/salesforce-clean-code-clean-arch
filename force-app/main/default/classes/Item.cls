public with sharing class Item {

    public String productCode;
    public Decimal quantity;  
    
    public Item(String productCode, Decimal quantity) {
        this.productCode = productCode;
        this.quantity = quantity;
    }

}
