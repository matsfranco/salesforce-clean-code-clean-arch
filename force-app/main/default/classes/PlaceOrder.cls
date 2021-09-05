public with sharing class PlaceOrder {
    
    public virtual class PlaceOrderCustomException extends Exception {}
    public List<OrderEntity> orders;
    public ZipCodeDistanceCalculatorAPI zipCodeDistanceCalculator;
    public Product2Repository productRepository;
    public CouponRepository couponRepository;
    public OrderRepository orderRepository;

    public PlaceOrder(Product2Repository productRepository,  CouponRepository couponRepository, OrderRepository orderRepository, ZipCodeDistanceCalculatorAPI zipCodeDistanceCalculator) {
        this.productRepository = productRepository; 
        this.couponRepository = couponRepository;
        this.orderRepository = orderRepository;
        this.zipCodeDistanceCalculator = zipCodeDistanceCalculator;
    }

    public PlaceOrderOutput execute(PlaceOrderInput input) {
        Integer sequence = this.orderRepository.count() + 1;
        OrderEntity order = new OrderEntity(input.cpf, input.issueDate, sequence);
        Decimal distance = this.zipCodeDistanceCalculator.calculate(input.zipcode, '99.999-999');

        for(Item item : input.items) {
            Product2Entity product = this.productRepository.getByProductCode(item.productCode);
            if(product == null) throw new PlaceOrderCustomException('No product found!');
            order.addItem(item.productCode, product.price, item.quantity);
            order.freightPrice += FreightCalculator.calculate(distance, product) * item.quantity;
        }
        if(!String.isBlank(input.couponCode)) {
            CouponEntity coupon = this.couponRepository.getByCouponCode(input.couponCode);
            if(coupon != null) order.addCoupon(coupon); 
        }
        Decimal total = order.getTotal();
        this.orderRepository.save(order);
        return new PlaceOrderOutput(order.orderNumber.value, order.freightPrice, total);
    }

 
}
