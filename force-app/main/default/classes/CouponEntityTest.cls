@isTest
public with sharing class CouponEntityTest {
    @isTest
    public static void validateNormalCoupon() {
        CouponEntity coupon = new CouponEntity('VALE20', 0.2, Date.newInstance(2021,10,10));
        System.assertEquals(false,coupon.isExpired(), 'Failed to validate an valid coupon.');
    }
    @isTest
    public static void validateExpiredCoupon() {
        CouponEntity coupon = new CouponEntity('VALE20_EXPIRED', 0.2, Date.newInstance(2020,10,10));
        System.assertEquals(true,coupon.isExpired(), 'Failed to validate an expired coupon.');
    }

}
