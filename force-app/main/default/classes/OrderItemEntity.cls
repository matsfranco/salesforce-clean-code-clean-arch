public with sharing class OrderItemEntity {
    
    public virtual class OrderItemEntityException extends Exception {}
    private String productCode;
    private Integer quantity;
    private Decimal unitPrice;
    private Decimal listPrice;
    private Id pricebookId;
    private Product2 product;
    private PricebookEntry item;
    private Decimal totalPrice;
    private Decimal percentualDiscount;
    
    public OrderItemEntity(String productCode, Integer quantity) {
        this.percentualDiscount = 0;
        this.productCode = productCode;
        this.quantity = quantity;
        this.pricebookId = getActivePricebook();
        this.product = getProductByProductCode(productCode);
        this.item = getPricebookEntryByProductAndPricebook(this.pricebookId,this.product.Id);
        this.listPrice = this.item.UnitPrice;
        this.unitPrice = this.item.UnitPrice;
    }

    private Product2 getProductByProductCode(String productCode) {
        List<Product2> products = [SELECT Id FROM Product2 WHERE ProductCode =: productCode];
        if(products.isEmpty() || products.size() > 1) throw new OrderItemEntityException('Failed to find the product by product code.');
        return products[0];
    }

    private Id getActivePricebook() {
        List<Pricebook2> pricebooks = [SELECT Id FROM Pricebook2 WHERE IsActive = true];
        if(pricebooks.isEmpty() || pricebooks.size() > 1) throw new OrderItemEntityException('Failed to find the active pricebook.');
        return pricebooks[0].Id;
    }

    private PricebookEntry getPricebookEntryByProductAndPricebook(Id pricebookId, Id productId) {
        List<PricebookEntry> pricebookEntries = [SELECT Id,UnitPrice FROM PricebookEntry WHERE Product2Id =: productId AND Pricebook2Id =: pricebookId AND IsActive = true];
        if(pricebookEntries.isEmpty() || pricebookEntries.size() > 1) throw new OrderItemEntityException('Failed to find the corresponding pricebook entry.');
        return pricebookEntries[0];
    }

    public Decimal getTotal() {
        return this.unitPrice * this.quantity * (1.0 - this.percentualDiscount);
    }

    public void applyPercentualDiscount(Decimal percentualDiscount) {
        this.percentualDiscount = percentualDiscount;
    }

}
