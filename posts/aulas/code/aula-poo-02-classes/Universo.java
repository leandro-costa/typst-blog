public class Universo {
    public static void main(String[] args) {
        // 🌅 O Gesto da Criação — uma criatura nasce!
        Criatura fenix = new Criatura();
        fenix.nome = "Fênix";
        fenix.vida = 100;
        fenix.tipo = "Ave de Fogo";

        // Outra criatura do mesmo molde — mas única!
        Criatura smaug = new Criatura();
        smaug.nome = "Smaug";
        smaug.vida = 200;
        smaug.tipo = "Dragão";

        IO.println(fenix.nome + " tem " + fenix.vida + " de vida.");
        IO.println(smaug.nome + " tem " + smaug.vida + " de vida.");
    }
}
