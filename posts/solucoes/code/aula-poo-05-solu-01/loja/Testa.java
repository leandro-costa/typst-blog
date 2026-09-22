public class Testa {
    public static void main(String[] args) {
        Departamento vestuario = new Departamento("Vestuário");
        Departamento calcados = new Departamento("Calçados");

        Produto camisa = new Produto("Camisa azul", 79.9, vestuario);
        Produto calca = new Produto("Calça jeans", 149.9, vestuario);
        Produto tenis = new Produto("Tênis esportivo", 259.9, calcados);

        Cliente cliente = new Cliente("Renata");
        Carrinho carrinho = cliente.novoCarrinho();
        carrinho.adicionar(camisa);
        carrinho.adicionar(calca);
        carrinho.adicionar(tenis);

        IO.println(cliente);
        IO.println(carrinho);
    }
}
