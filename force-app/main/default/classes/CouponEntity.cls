public with sharing class CouponEntity {
    
    public String code;
    public Decimal discountPercentage;
    public Datetime expirationDate;
    
    public virtual class CouponEntityException extends Exception {}

    public CouponEntity(String code, Decimal discountPercentage, Datetime expirationDate) {
        this.code = code;
        this.discountPercentage = discountPercentage;
        this.expirationDate = expirationDate;
    }

    public Boolean isExpired() {
        Date today = Date.Today();
        return this.expirationDate < today;
    }

}
