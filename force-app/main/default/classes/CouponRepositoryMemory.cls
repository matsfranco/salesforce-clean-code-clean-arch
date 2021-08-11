public with sharing class CouponRepositoryMemory implements CouponRepository {
    
    List<CouponEntity> coupons;

    public CouponRepositoryMemory() {
        this.coupons = new List<CouponEntity>{ 
            new CouponEntity('VALE20', 0.2, date.newInstance(2021,10,10)),
            new CouponEntity('VALE20_EXPIRED', 0.2, date.newInstance(2020,10,10)) 
        };
    }

    public CouponEntity getByCouponCode(String code) {
        for(CouponEntity coupon : coupons) {
            if(coupon.code == code) return coupon;
        }
        return null;
    }
}
