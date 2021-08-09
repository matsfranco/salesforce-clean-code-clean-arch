@isTest
public with sharing class FreightCalculatorTest {

    @isTest
    public static void validateFreightCalculator() {
        Decimal distance = 1000.0;
        Product2Entity product1 = new Product2Entity('1','Guitarra',1000,100,50,15,3);
        System.assertEquals(30.0, FreightCalculator.calculate(distance, product1), 'Failed to calculate the freight');
        Product2Entity product2 = new Product2Entity('2','Amplificador',5000,50,50,50,22);
        System.assertEquals(220.0, FreightCalculator.calculate(distance, product2), 'Failed to calculate the freight');
        Product2Entity product3 = new Product2Entity('3','Cabo',30,9,9,9,0.1);
        System.assertEquals(10.0, FreightCalculator.calculate(distance, product3), 'Failed to calculate the freight');
    }

}
