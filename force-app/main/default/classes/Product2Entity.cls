public with sharing class Product2Entity {
    
    String productCode;
    String description;
    Decimal price;
    Decimal width;
    Decimal height;
    Decimal length;
    Decimal weight;    
    
    public Product2Entity(String productCode, String description, Decimal price, Decimal width, Decimal height, Decimal length, Decimal weight) {
        this.productCode = productCode;
        this.description = description;
        this.price = price;
        this.width = width;
        this.height = height;
        this.length = length;
        this.weight = weight;
    }

    public Decimal getVolume() {
        return this.width/100 * this.height/100 * this.length/100;
    }

    public Decimal getDensity() {
        return this.weight / this.getVolume();
    }
}
