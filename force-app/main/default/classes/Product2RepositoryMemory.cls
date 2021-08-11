public with sharing class Product2RepositoryMemory implements Product2Repository {

    public List<Product2Entity> products;

    public Product2RepositoryMemory() {
        this.products = new List<Product2Entity>{ 
            new Product2Entity('1', 'Guitarra', 1000, 100, 50, 15, 3),
            new Product2Entity('2', 'Amplificador', 5000, 50, 50, 50, 22),
            new Product2Entity('3', 'Cabo', 30, 10, 10, 10, 1)
        };
    }

    public Product2Entity getByProductCode(String productCode) {
        for(Product2Entity product : this.products) {
            if(product.productCode == productCode) return product;
        }
        return null;
    }
}
