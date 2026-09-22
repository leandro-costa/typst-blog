public class Testa {
    public static void main(String[] args) {
        Tesouro tesouro = new Tesouro(500, 10);
        IO.println(tesouro);

        tesouro.depositarOuro(200);
        IO.println(tesouro);

        tesouro.depositarOuro(-50);

        tesouro.sacarOuro(300);
        IO.println(tesouro);

        tesouro.sacarOuro(10000);

        tesouro.adicionarDiamantes(3);
        IO.println(tesouro);
    }
}
