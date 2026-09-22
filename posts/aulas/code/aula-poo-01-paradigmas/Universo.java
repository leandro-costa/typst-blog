// O Deus Criador escreve as leis do universo
public class Universo {
    public static void main(String[] args) {
        // O Gesto da Criação — uma criatura nasce!
        Criatura fenix = new Criatura();
        fenix.nome = "Fenix";
        fenix.vida = 100;

        fenix.exibirStatus();  // A criatura responde!
        fenix.receberDano(30); // A criatura sabe se proteger
        fenix.exibirStatus();

        // Criando outra criatura do mesmo molde
        Criatura smaug = new Criatura();
        smaug.nome = "Smaug";
        smaug.vida = 200;

        smaug.exibirStatus();
    }
}
