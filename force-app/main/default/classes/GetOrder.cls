public with sharing class GetOrder {
    
    public virtual class GetOrderCustomException extends Exception {}
    public List<OrderEntity> orders;
    public ZipCodeDistanceCalculatorAPI zipCodeDistanceCalculator;
    public Product2Repository productRepository;
    public CouponRepository couponRepository;
    public OrderRepository orderRepository;

    public GetOrder(RepositoryFactory repositotyFactory) {
        this.productRepository = repositotyFactory.createProductRepository(); 
        this.couponRepository = repositotyFactory.createCouponRepository();
        this.orderRepository = repositotyFactory.createOrderRepository();
    }

    public GetOrderOutput execute(String orderNumber) {
        OrderEntity order = this.orderRepository.getByOrderNumber(orderNumber);
        List<OrderItemOutput> orderItems = new List<OrderItemOutput>();
        for(OrderItemEntity orderItem : order.orderItems) {
            Product2Entity product = productRepository.getByProductCode(orderItem.productCode);
            orderItems.add(new OrderItemOutput(product.description, product.price, product.quantity));
        }
        return new GetOrderOutput(order.OrderNumber.value,order.freightPrice, order.getTotal(), orderItems);
    }
}
