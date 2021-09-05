public with sharing class OrderRepositoryMemory implements OrderRepository {

    List<OrderEntity> orders;

    public OrderRepositoryMemory() {
        this.orders = new List<OrderEntity>();
    }

    public void save(OrderEntity newOrder) {
        this.orders.add(newOrder);
    }

    public Integer count() {
        return this.orders.size();
    }
}
