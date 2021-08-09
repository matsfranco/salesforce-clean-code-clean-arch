@isTest
public with sharing class FreightCalculatorTest {

    @isTest
    public static void validateFreightCalculator() {
        Product2Entity product = new Product2Entity('1','Guitarra',1000,100,50,15,3);
        Decimal distance = 1000.0;
        System.assertEquals(30.0, FreightCalculator.calculate(distance, product));
    }

}
