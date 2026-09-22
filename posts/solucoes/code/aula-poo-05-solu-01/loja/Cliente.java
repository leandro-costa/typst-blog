import java.util.ArrayList;
import java.util.List;

public class Cliente {
    String nome;
    List<Carrinho> carrinhos;

    Cliente(String nome) {
        this.nome = nome;
        this.carrinhos = new ArrayList<>();
    }

    Carrinho novoCarrinho() {
        Carrinho carrinho = new Carrinho();
        this.carrinhos.add(carrinho);
        return carrinho;
    }

    @Override
    public String toString() {
        return this.nome + " (" + this.carrinhos.size() + " carrinho(s))";
    }
}
