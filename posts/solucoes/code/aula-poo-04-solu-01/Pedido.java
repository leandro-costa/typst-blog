import java.util.ArrayList;
import java.util.List;

public class Pedido {
    int numero;
    String cliente;
    List<ItemPedido> itens;

    Pedido(int numero, String cliente) {
        this.numero = numero;
        this.cliente = cliente;
        this.itens = new ArrayList<>();
    }

    void adicionarProduto(Produto produto, int quantidade) {
        ItemPedido item = new ItemPedido(produto, quantidade);
        this.itens.add(item);
    }

    double calcularTotal() {
        double total = 0;
        for (ItemPedido item : this.itens) {
            total += item.getSubtotal();
        }
        return total;
    }

    @Override
    public String toString() {
        String texto = "Pedido " + this.numero + " - Cliente: " + this.cliente + "\n";
        for (ItemPedido item : this.itens) {
            texto += "  " + item + "\n";
        }
        texto += "Total: R$ " + calcularTotal();
        return texto;
    }
}
