public with sharing class OrderRepositoryMemory implements OrderRepository {

    List<OrderEntity> orders;
    public virtual class OrderRepositoryMemoryException extends Exception {}

    public OrderRepositoryMemory() {
        this.orders = new List<OrderEntity>();
    }

    public void save(OrderEntity newOrder) {
        this.orders.add(newOrder);
    }

    public Integer count() {
        return this.orders.size();
    }

    public OrderEntity getByOrderNumber(String orderNumber) {
        OrderEntity order = find(orderNumber);
        if(order == null) throw new OrderRepositoryMemoryException('Order not found!');
        else return order;
    }

    public OrderEntity find(String orderNumber) {
        for(OrderEntity order : orders) {
            if(order.orderNumber.value == orderNumber) return order;
        }
        return null;
    }

}
