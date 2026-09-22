public class Universo {
    public static void main(String[] args) {
        // Produtos existem independentemente (serão agregados)
        Produto arroz = new Produto("Arroz 5kg", 25.90);
        Produto feijao = new Produto("Feijão 1kg", 8.50);
        Produto leite = new Produto("Leite 1L", 6.30);

        // O carrinho CRIA os itens internamente (composição)
        Carrinho carrinho = new Carrinho();
        carrinho.adicionarProduto(arroz, 2);
        carrinho.adicionarProduto(feijao, 3);
        carrinho.adicionarProduto(leite, 6);

        System.out.println(carrinho);
        // 🛒 Carrinho de Compras:
        //   - 2x Arroz 5kg = R$51.8
        //   - 3x Feijão 1kg = R$25.5
        //   - 6x Leite 1L = R$37.8
        //   Total: R$115.1

        // Se o carrinho for destruído, os ItemCompra morrem junto (composição)
        // Mas os produtos (Arroz, Feijão, Leite) continuam existindo (agregação)
    }
}
