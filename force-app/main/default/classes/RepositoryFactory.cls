public interface RepositoryFactory {

    Product2Repository createProductRepository();
    CouponRepository createCouponRepository();
    OrderRepository createOrderRepository();
    
}
