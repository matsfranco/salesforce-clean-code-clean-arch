public with sharing class CouponRepositoryDatabase implements CouponRepository{

    public InfraDatabase database;

    public CouponRepositoryDatabase(InfraDatabase database) {
        this.database = database;
    }

    public CouponEntity getByCouponCode(String couponCode) {
        String couponCodeParameter = '\''+couponCode+'\'';
        Coupon__c couponData = (Coupon__c)this.database.one('SELECT Id,Name,DiscountPercentage__c,ExpirationDate__c FROM Coupon__c WHERE Name ='+couponCodeParameter,'');
        return new CouponEntity(couponData.Name,couponData.DiscountPercentage__c,couponData.ExpirationDate__c);
    }

}
