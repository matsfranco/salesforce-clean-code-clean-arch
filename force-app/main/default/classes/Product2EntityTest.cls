@isTest
public class Product2EntityTest {
    
    @isTest
    public static void validateVolume() {
        Product2Entity product = new Product2Entity('1', 'Amplificador', 5000, 50, 50, 50, 22);
        System.assertEquals(0.125,product.getVolume(),'Failed to validate product2 volume');
    }

    @isTest
    public static void validateDensity() {
        Product2Entity product = new Product2Entity('1', 'Amplificador', 5000, 50, 50, 50, 22);
        System.assertEquals(176,product.getDensity(),'Failed to validate product2 volume');
    }

}
