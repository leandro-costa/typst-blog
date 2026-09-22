import java.util.ArrayList;
import java.util.List;

public class Carrinho {
    List<Produto> produtos;

    Carrinho() {
        this.produtos = new ArrayList<>();
    }

    void adicionar(Produto produto) {
        this.produtos.add(produto);
    }

    double calcularTotal() {
        double total = 0;
        for (Produto p : this.produtos) {
            total += p.preco;
        }
        return total;
    }

    @Override
    public String toString() {
        return "Carrinho com " + this.produtos.size() + " item(ns), total R$ " + calcularTotal();
    }
}
