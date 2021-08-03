public with sharing class OrderEntity {
    /*
        1 - Não deve fazer um pedido com cpf inválido
        2 - Deve fazer um pedido com 3 itens (com descrição, preço e quantidade)
        3 - Deve fazer um pedido com cupom de desconto (percentual sobre o total do pedido)
    
    */
    
        public static Boolean createOrder(String cpf, String couponName, String orderItems) {
    
            if(!ValidadeCPF.validate(cpf)) return false;
            List<Contact> contacts = [SELECT Id,AccountId,CPF__c FROM Contact WHERE CPF__c =: cpf];
            if(contacts.isEmpty()) return false;      
            List<Coupon__c> coupons;
            if(!String.isBlank(couponName))  coupons = [SELECT Id FROM Coupon__c WHERE Name =: couponName];
            
            createOrder(contacts[0],coupons[0]);
            createOrderItems(orderItems);
    
    
            return true;
            
        }
    
        private static Order createOrder(Contact contact, Coupon__c coupon) {
            Order newOrder = new Order( AccountId = contact.AccountId,
                                        BillToContactId = contact.Id,
                                        ShipToContactId = contact.Id,
                                        Coupon__c = coupon != null ? coupon.Id : null,
                                        Status = 'Draft',
                                        EffectiveDate = Date.Today());
            database.insert(newOrder);
            return newOrder;  
        }    
    
        private static List<OrderItem> createOrderItems(String orderItems) {
            List<OrderItemDTO> items = new List<OrderItemDTO>();
            items = (List<OrderItemDTO>)JSON.deserialize(orderItems,OrderItemDTO.class);
            System.debug(items);
            return null;
        }
    
        private static OrderItem createOrderItem() {
            return null;
        }
    
        public class OrderItemDTO {
            public String description; 
            public Decimal price;
            public Decimal quantity;
            public String product;
    
        }
    
    }
    