public interface CouponRepository {
    CouponEntity getByCouponCode(String code);
}