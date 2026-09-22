public class Testa {
    public static void main(String[] args) {
        Fornecedor fornecedor = new Fornecedor("Distribuidora Central", "12.345.678/0001-00");

        Produto teclado = new Produto("Teclado mecânico", 250.0, fornecedor);
        Produto mouse = new Produto("Mouse sem fio", 90.0, fornecedor);
        Produto monitor = new Produto("Monitor 24\"", 800.0, fornecedor);

        IO.println(teclado);
        IO.println(mouse);
        IO.println(monitor);

        Pedido pedido = new Pedido(1, "Ana Beatriz");
        pedido.adicionarProduto(teclado, 1);
        pedido.adicionarProduto(mouse, 2);
        pedido.adicionarProduto(monitor, 1);

        IO.println("");
        IO.println(pedido);
    }
}
