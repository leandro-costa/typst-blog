public class Universo {
    public static void main(String[] args) {
        Criatura fenix = new Criatura();
        fenix.nome = "Fênix";
        fenix.vida = 100;
        fenix.tipo = "Ave de Fogo";

        fenix.exibirStatus();      // Fênix [Ave de Fogo] - Vida: 100
        fenix.receberDano(30);     // A criatura sabe se proteger
        fenix.exibirStatus();      // Fênix [Ave de Fogo] - Vida: 70
        fenix.curar(10);           // A criatura sabe se curar
        fenix.exibirStatus();      // Fênix [Ave de Fogo] - Vida: 80
    }
}
