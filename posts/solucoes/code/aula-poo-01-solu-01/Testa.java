public class Testa {
    public static void main(String[] args) {
        Guerreiro conan = new Guerreiro("Conan", 100, 25);
        Guerreiro thorin = new Guerreiro("Thorin", 100, 20);

        IO.println("--- Antes do ataque ---");
        conan.exibirStatus();
        thorin.exibirStatus();

        conan.atacar(thorin);

        IO.println("--- Depois do ataque ---");
        conan.exibirStatus();
        thorin.exibirStatus();
    }
}
