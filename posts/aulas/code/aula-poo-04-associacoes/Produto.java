public class Produto {
    String nome;
    double preco;
    Fornecedor fornecedor; // 🎒 Agregação: o fornecedor existe independentemente

    Produto(String nome, double preco, Fornecedor fornecedor) {
        this.nome = nome;
        this.preco = preco;
        this.fornecedor = fornecedor;
    }

    @Override
    public String toString() {
        return this.nome + " - R$" + this.preco
                + " | Fornecedor: " + this.fornecedor;
    }
}
