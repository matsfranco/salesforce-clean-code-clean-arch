public with sharing class PlaceOrder {
    
    public virtual class PlaceOrderCustomException extends Exception {}
    public List<OrderEntity> orders;
    public ZipCodeDistanceCalculatorAPIMemory zipCodeDistanceCalculator;
    public Product2Repository productRepository;
    public CouponRepository couponRepository;
    public OrderRepository orderRepository;

    public PlaceOrder(Product2Repository productRepository,  CouponRepository couponRepository, OrderRepository orderRepository) {
        this.productRepository = productRepository; 
        this.couponRepository = couponRepository;
        this.orderRepository = orderRepository;
        this.zipCodeDistanceCalculator = new ZipCodeDistanceCalculatorAPIMemory();
    }

    public PlaceOrderOutput execute(PlaceOrderInput input) {
        OrderEntity order = new OrderEntity(input.cpf);
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
        return new PlaceOrderOutput(order.freightPrice, total);
    }

 
}
