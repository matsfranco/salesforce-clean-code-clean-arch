public with sharing class DatabaseRepositoryFactory implements RepositoryFactory {
    

    public Product2Repository createProductRepository() {
        return new Product2RepositoryDatabase(new InfraDatabaseSFDC());
    }
    
    public CouponRepository createCouponRepository() {
        return new CouponRepositoryDatabase(new InfraDatabaseSFDC());
    }
    
    public OrderRepository createOrderRepository() {
        return new OrderRepositoryDatabase(new InfraDatabaseSFDC());
    }

}
