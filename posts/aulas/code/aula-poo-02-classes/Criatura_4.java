public class Criatura {
    String nome;
    int vida;
    String tipo;
    int forca;

    void atacar(Criatura alvo) {
        IO.println(nome + " ataca " + alvo.nome + "!");
        alvo.receberDano(forca);
    }

    void receberDano(int dano) {
        vida -= dano;
        if (vida < 0) vida = 0;
    }

    void exibirStatus() {
        IO.println(nome + " [" + tipo + "] - Vida: " + vida);
    }
}
