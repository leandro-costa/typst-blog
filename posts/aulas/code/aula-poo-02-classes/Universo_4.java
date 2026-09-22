public class Universo {
    public static void main(String[] args) {
        Criatura fenix = new Criatura();
        fenix.nome = "Fênix";
        fenix.vida = 100;
        fenix.tipo = "Ave de Fogo";
        fenix.forca = 30;

        Criatura smaug = new Criatura();
        smaug.nome = "Smaug";
        smaug.vida = 200;
        smaug.tipo = "Dragão";
        smaug.forca = 50;

        fenix.exibirStatus();
        smaug.exibirStatus();

        fenix.atacar(smaug); // Fênix ataca Smaug!
        smaug.atacar(fenix); // Smaug contra-ataca!

        fenix.exibirStatus();
        smaug.exibirStatus();
    }
}
