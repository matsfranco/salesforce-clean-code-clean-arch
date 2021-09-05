public interface OrderRepository {

    void save(OrderEntity order);
    Integer count();
    OrderEntity getByOrderNumber(String orderNumber);
}
