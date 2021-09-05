public with sharing class MemoryRepositoryFactory implements RepositoryFactory {
    
    public Product2Repository createProductRepository() {
        return new Product2RepositoryMemory();
    }
    
    public CouponRepository createCouponRepository() {
        return new CouponRepositoryMemory();
    }
    
    public OrderRepository createOrderRepository() {
        return new OrderRepositoryMemory();
    }
}
