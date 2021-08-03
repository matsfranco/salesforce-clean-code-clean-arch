public with sharing class CouponEntity {
    
    private String couponCode;
    public Decimal discountPercentage;
    private Datetime expirationDate;
    
    public virtual class CouponEntityException extends Exception {}

    public CouponEntity(String code) {
        this.couponCode = code;
        Coupon__c coupon = getCouponByCode(code);
        if(this.discountPercentage > 1 || this.discountPercentage <= 0) throw new CouponEntityException('Invalid coupon percentage!');
        this.discountPercentage = coupon.DiscountPercentage__c;
        this.expirationDate = coupon.ExpirationDate__c;
    }

    public Coupon__c getCouponByCode(String code) {
        List<Coupon__c> coupons = [SELECT Id,DiscountPercentage__c,ExpirationDate__c FROM Coupon__c WHERE Name =: code AND ExpirationDate__c >=: System.now()];
        if(coupons.isEmpty() || coupons.size() > 1) throw new CouponEntityException('Invalid Coupon!');
        return coupons[0];
    }

}
