public with sharing class OrderEntity {

    public virtual class OrderEntityException extends Exception {}

    private CPF cpf;
    private List<OrderItemEntity> orderItems;
    private CouponEntity coupon;

    public OrderEntity(String cpf) {
        this.cpf = new CPF(cpf);
        this.orderItems = new List<OrderItemEntity>();
    }

    public void addItem(String productCode, Integer quantity) {
        this.orderItems.add(new OrderItemEntity(productCode,quantity));
    }

    public Decimal addCoupon(String couponCode) {
        this.coupon = new CouponEntity(couponCode);
         return applyPercentualDiscount(coupon.discountPercentage);
    }

    public Decimal getTotal() {
        Decimal total = 0;
        for(OrderItemEntity orderItem : orderItems) {
            total += orderItem.getTotal(); 
        }
        return total;
    }

    public Decimal applyPercentualDiscount(Decimal percentage) {
        Decimal total = 0;
        for(OrderItemEntity orderItem : orderItems) {
            orderItem.applyPercentualDiscount(percentage);
            total += orderItem.getTotal(); 
        }
        return total;
    }
}  