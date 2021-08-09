public with sharing class PlaceOrder {
    
    public virtual class PlaceOrderCustomException extends Exception {}
    public List<CouponEntity> coupons;
    public List<Product2Entity> items;
    public List<OrderEntity> orders;
    public ZipCodeDistanceCalculatorAPIMemory zipCodeDistanceCalculator;

    public PlaceOrder() {
        this.coupons = new List<CouponEntity>{ 
            new CouponEntity('VALE20', 0.2, date.newInstance(2021,10,10)),
            new CouponEntity('VALE20_EXPIRED', 0.2, date.newInstance(2020,10,10)) 
        };
        this.items = new List<Product2Entity>{ 
            new Product2Entity('1', 'Guitarra', 1000, 100, 50, 15, 3),
            new Product2Entity('2', 'Amplificador', 5000, 50, 50, 50, 22),
            new Product2Entity('3', 'Cabo', 30, 10, 10, 10, 1)
        };
        this.orders = new List<OrderEntity>();
        this.zipCodeDistanceCalculator = new ZipCodeDistanceCalculatorAPIMemory();
    }

    public PlaceOrderOutput execute(PlaceOrderInput input) {
        OrderEntity order = new OrderEntity(input.cpf);
        Decimal distance = this.zipCodeDistanceCalculator.calculate(input.zipcode, '99.999-999');

        for(Item item : input.items) {
            Product2Entity product = findProduct2(this.items, item.productCode);
            if(product == null) throw new PlaceOrderCustomException('No product found!');
            order.addItem(item.productCode, product.price, item.quantity);
            order.freightPrice += FreightCalculator.calculate(distance, product) * item.quantity;
        }
        if(!String.isBlank(input.couponCode)) {
            CouponEntity coupon = findCoupon(this.coupons, input.couponCode);
            if(coupon != null) order.addCoupon(coupon); 
        }
        Decimal total = order.getTotal();
        this.orders.add(order);
        return new PlaceOrderOutput(order.freightPrice, total);
    }

    public Product2Entity findProduct2(List<Product2Entity> items, String productCode) {
        for(Product2Entity item : items) {
            if(item.productCode == productCode) return item;
        }
        return null;
    }

    public CouponEntity findCoupon(List<CouponEntity> coupons, String code) {
        for(CouponEntity coupon : coupons) {
            if(coupon.code == code) return coupon;
        }
        return null;
    }
 
}
