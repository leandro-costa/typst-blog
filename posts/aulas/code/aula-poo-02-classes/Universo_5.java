public class Universo {
    public static void main(String[] args) {
        // 🌅 Criaturas nascem completas — o Ritual garante!
        Criatura fenix = new Criatura("Fênix", 100, "Ave de Fogo", 30);
        Criatura smaug = new Criatura("Smaug", 200, "Dragão", 50);
        Criatura arthas = new Criatura("Arthas", 150, "Guerreiro", 40);

        fenix.exibirStatus();
        smaug.exibirStatus();
        arthas.exibirStatus();

        IO.println("--- A Batalha Começa ---");
        fenix.atacar(smaug);
        smaug.atacar(arthas);
        arthas.atacar(fenix);

        fenix.exibirStatus();
        smaug.exibirStatus();
        arthas.exibirStatus();
    }
}
