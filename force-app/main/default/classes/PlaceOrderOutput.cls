public with sharing class PlaceOrderOutput {
    Decimal freight;
    Decimal total;

    public PlaceOrderOutput(Decimal freight, Decimal total) {
        this.freight = freight;
        this.total = total;
    }
}
