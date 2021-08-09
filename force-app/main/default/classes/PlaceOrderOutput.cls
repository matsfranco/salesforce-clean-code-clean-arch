public with sharing class PlaceOrderOutput {
    public Decimal freightPrice;
    public Decimal total;

    public PlaceOrderOutput(Decimal freightPrice, Decimal total) {
        this.freightPrice = freightPrice;
        this.total = total;
    }
}
