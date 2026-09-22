public class ItemCompra {
    Produto produto; // 🎒 Agregação: o produto existe fora do item
    int quantidade;

    ItemCompra(Produto produto, int quantidade) {
        this.produto = produto;
        this.quantidade = quantidade;
    }

    double getSubtotal() {
        return this.produto.preco * this.quantidade;
    }

    @Override
    public String toString() {
        return this.quantidade + "x " + this.produto.nome
                + " = R$" + this.getSubtotal();
    }
}
