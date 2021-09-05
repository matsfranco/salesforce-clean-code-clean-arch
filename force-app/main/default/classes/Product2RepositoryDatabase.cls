public with sharing class Product2RepositoryDatabase implements Product2Repository {

    public InfraDatabase database;

    public Product2RepositoryDatabase(InfraDatabase database) {
        this.database = database;
    }

    public Product2Entity getByProductCode(String productCode) {
        String productCodeParameter = '\''+productCode+'\'';
        Product2 productData = (Product2)this.database.one('SELECT Id,Description,ProductCode,Price__c,Width__c, Height__c, Length__c, Weight__c FROM Product2 WHERE ProductCode='+productCodeParameter,'');
        return new Product2Entity(productData.productCode, productData.Description,  productData.Price__c,  productData.Width__c,  productData.Height__c,  productData.Length__c,  productData.Weight__c);
    }

}
