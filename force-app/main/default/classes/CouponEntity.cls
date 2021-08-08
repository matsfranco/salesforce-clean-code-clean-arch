public with sharing class CouponEntity {
    
    private String code;
    public Decimal discountPercentage;
    private Datetime expirationDate;
    
    public virtual class CouponEntityException extends Exception {}

    public CouponEntity(String code, Decimal percentage, Date expirationDate) {
        this.code = code;
        this.discountPercentage = discountPercentage;
        this.expirationDate = expirationDate;
    }

    public Boolean isExpired() {
        Date today = Date.Today();
        return this.expirationDate < today;
    }

}
