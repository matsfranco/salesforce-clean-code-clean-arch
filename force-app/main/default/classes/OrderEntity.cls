public with sharing class OrderEntity {
    /*
        1 - Não deve fazer um pedido com cpf inválido
        2 - Deve fazer um pedido com 3 itens (com descrição, preço e quantidade)
        3 - Deve fazer um pedido com cupom de desconto (percentual sobre o total do pedido)
    
    */

    private CPF cpf;
    private List<OrderItemEntity> orderItems;
    private String coupon;

    public OrderEntity(String cpf) {
        this.cpf = new CPF(cpf);
    
    }
}  