public interface OrderRepository {

    void save(OrderEntity order);
    Integer count();
}
