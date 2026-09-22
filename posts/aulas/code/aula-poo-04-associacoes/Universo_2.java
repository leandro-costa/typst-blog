public class Universo {
    public static void main(String[] args) {
        // O fornecedor existe ANTES de qualquer produto
        Fornecedor samsung = new Fornecedor("Samsung", "12.345.678/0001-99");

        // Vários produtos compartilham o MESMO fornecedor
        Produto tv = new Produto("Smart TV 55\"", 2500.0, samsung);
        Produto celular = new Produto("Galaxy S24", 4200.0, samsung);

        System.out.println(tv);
        System.out.println(celular);

        // Se o produto "tv" fosse destruído, samsung continua vivo!
    }
}
