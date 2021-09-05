public with sharing class OrderEntity {

    public virtual class OrderEntityException extends Exception {}

    public OrderNumber orderNumber;
    private Datetime issueDate;
    private Integer sequence;
    private CPF cpf;
    public List<OrderItemEntity> orderItems;
    private CouponEntity coupon;
    public Decimal freightPrice;

    public OrderEntity(String cpf, Datetime issueDate, Integer sequence) {
        this.cpf = new CPF(cpf);
        this.orderItems = new List<OrderItemEntity>();
        this.freightPrice = 0;
        this.issueDate = issueDate;
        this.sequence = sequence; 
        this.orderNumber = new OrderNumber(issueDate,sequence);
    }

    public void addItem(String productCode, Decimal price, Decimal quantity) {
        this.orderItems.add(new OrderItemEntity(productCode,price,quantity));
    }

    public void addCoupon(CouponEntity coupon) {
        if(!coupon.isExpired()) {
            this.coupon = coupon;
        }
    }

    public Decimal getTotal() {
        Decimal total = 0;
        System.debug(orderItems);
        for(OrderItemEntity orderItem : orderItems) {
            System.debug(orderItem);
            total += orderItem.getTotal(); 
        }
        if(this.coupon != null) {
            System.debug('Coupon: '+coupon);
            total -= (total * this.coupon.discountPercentage);
        }
        total += this.freightPrice;
        return total;
    }

}  