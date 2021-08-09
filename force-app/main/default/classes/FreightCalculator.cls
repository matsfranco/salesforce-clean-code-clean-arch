public with sharing class FreightCalculator {
    
    public static Decimal calculate(Decimal distance, Product2Entity product) {
        Decimal freightPrice = distance * product.getVolume() * (product.getDensity()/100);
        return (freightPrice > 10) ? freightPrice : 10.0;
    }
}
