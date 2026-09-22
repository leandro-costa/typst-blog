import java.util.ArrayList;
import java.util.List;

public class Carrinho {
    List<ItemCompra> itens; // 🧩 Composição: os itens são CRIADOS aqui

    Carrinho() {
        this.itens = new ArrayList<>(); // O carrinho cria sua própria lista
    }

    // O carrinho CRIA o ItemCompra internamente — composição!
    void adicionarProduto(Produto produto, int quantidade) {
        ItemCompra item = new ItemCompra(produto, quantidade);
        this.itens.add(item);
    }

    double calcularTotal() {
        double total = 0;
        for (ItemCompra item : this.itens) {
            total += item.getSubtotal();
        }
        return total;
    }

    @Override
    public String toString() {
        String resultado = "🛒 Carrinho de Compras:\n";
        for (ItemCompra item : this.itens) {
            resultado += "  - " + item + "\n";
        }
        resultado += "  Total: R$" + this.calcularTotal();
        return resultado;
    }
}
