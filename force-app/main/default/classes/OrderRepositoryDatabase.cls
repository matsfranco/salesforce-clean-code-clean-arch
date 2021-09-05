public with sharing class OrderRepositoryDatabase implements OrderRepository {
    
    InfraDatabase sfdcDatabase;

    public OrderRepositoryDatabase(InfraDatabase sfdcDatabase) {
        this.sfdcDatabase = sfdcDatabase;
    }

    public void save(OrderEntity orderData) {
        Order newOrder = createOrder(orderData);
        database.insert(newOrder);
        List<OrderItem> newOrderItems = createOrderItems(newOrder,orderData.orderItems);
        database.insert(newOrderItems);
    }
    
    public Integer count() {
        return [SELECT COUNT() FROM Order];
         
    }
    
    public OrderEntity getByOrderNumber(String orderNumber){
        String orderNumberParameter = '\''+orderNumber+'\'';
        Order orderData = (Order)this.sfdcDatabase.one('SELECT Id,OrderNumber__c,IssueDate__c,Sequence__c,CustomerDocumentNumber__c,CouponCode__c,FreightPrice__c FROM Order WHERE OrderNumber__c = '+orderNumberParameter,'');
        String orderIdParameter = '\''+orderData.Id+'\'';
        List<OrderItem> orderItemsData = (List<OrderItem>)this.sfdcDatabase.many('SELECT Id,ProductCode__c, Price__c, Quantity__c FROM OrderItem WHERE OrderId = '+orderIdParameter,'');
        OrderEntity order = createOrderEntity(orderData);
        List<OrderItemEntity> orderItems = createOrderItemEntities(orderData,orderItemsData);
        order.OrderItems = orderItems;
        if(orderData.CouponCode__c != null) {
            String couponCodeParam = '\''+orderData.CouponCode__c+'\'';
            Coupon__c couponData = (Coupon__c)this.sfdcDatabase.one('SELECT Id,Name,ExpirationDate__c,DiscountPercentage__c FROM Coupon__c WHERE Name = '+couponCodeParam,'');
            CouponEntity coupon = new CouponEntity(couponData.Name,couponData.DiscountPercentage__c,couponData.ExpirationDate__c);
            order.addCoupon(coupon);
        }
        order.freightPrice = orderData.FreightPrice__c;
        return order;
    }
        
    public Order createOrder(OrderEntity orderData) {
        Pricebook2 stdPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = True AND IsActive = True LIMIT 1];
        Order newOrder = new Order();
        newOrder.OrderNumber__c = orderData.OrderNumber.value; 
        newOrder.IssueDate__c = orderData.issueDate;
        newOrder.EffectiveDate = Date.today();
        newOrder.Status = 'Draft';
        newOrder.AccountId = '0015e00000F6FgUAAV';
        //newOrder.CustomerDocumentNumber__c = orderData.cpf.value;
        newOrder.Sequence__c = orderData.sequence;
        newOrder.FreightPrice__c = orderData.freightPrice;
        newOrder.Pricebook2Id = stdPricebook.Id;
        return newOrder;
    }

    public List<OrderItem> createOrderItems(Order order, List<OrderItemEntity> items) {
        
        Pricebook2 stdPricebook = [SELECT Id FROM Pricebook2 WHERE IsStandard = True AND IsActive = True LIMIT 1];

        List<PricebookEntry> pricebookEntries = [SELECT Product2.ProductCode,Id,UnitPrice FROM PricebookEntry WHERE Pricebook2Id =: stdPricebook.Id];
        Map<String,PricebookEntry> productCodeToPbEntry = new Map<String,PricebookEntry>();
        
        for(PricebookEntry entry : pricebookEntries) {
            productCodeToPbEntry.put(entry.Product2.ProductCode,entry);
        }
        
        List<OrderItem> newOrderItems = new List<OrderItem>();
        for(OrderItemEntity item : items) {
            OrderItem newOrderItem = new OrderItem();
            newOrderItem.ProductCode__c = item.productCode;
            newOrderItem.PricebookEntryId = productCodeToPbEntry.get(item.productCode).Id;
            newOrderItem.UnitPrice = productCodeToPbEntry.get(item.productCode).UnitPrice;
            newOrderItem.Price__c = productCodeToPbEntry.get(item.productCode).UnitPrice;
            newOrderItem.Quantity = item.quantity;
            newOrderItem.OrderId = order.Id;
            newOrderItems.add(newOrderItem);
        }
        return newOrderItems;
    }


    public OrderEntity createOrderEntity(Order orderData) {
        OrderEntity order = new OrderEntity(orderData.CustomerDocumentNumber__c,orderData.IssueDate__c,(Integer)orderData.Sequence__c);
        return order;
    }

    public List<OrderItemEntity> createOrderItemEntities(Order orderData, List<OrderItem> orderItemsData) {
        List<OrderItemEntity> orderItems = new List<OrderItemEntity>();
        for(OrderItem orderItemData : orderItemsData) {
            OrderItemEntity orderItem = new OrderItemEntity(orderItemData.ProductCode__c,orderItemData.Price__c,orderItemData.Quantity__c);
            orderItems.add(orderItem);
        }
        return orderItems;
    }


}
