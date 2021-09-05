public with sharing class GetOrderOutput {
    public String orderNumber;
    public Decimal freight;
    public Decimal total;
    public List<OrderItemOutput> orderItems; 

    public GetOrderOutput(String OrderNumber, Decimal freight, Decimal total, List<OrderItemOutput> orderItems) {
        this.orderNumber = orderNumber;
        this.freight = freight;
        this.total = total;
        this.orderItems = orderItems;
    }
}
