public with sharing class PlaceOrderOutput {
    public String orderNumber;
    public Decimal freightPrice;
    public Decimal total;

    public PlaceOrderOutput(String orderNumber, Decimal freightPrice, Decimal total) {
        this.orderNumber = orderNumber;
        this.freightPrice = freightPrice;
        this.total = total;
    }
}
