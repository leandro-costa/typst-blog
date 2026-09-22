public class Criatura {
    String nome;
    int vida;
    String tipo;

    // ⚡ Poder: receber dano
    void receberDano(int dano) {
        vida -= dano;
        if (vida < 0) vida = 0;
    }

    // ⚡ Poder: exibir seu status
    void exibirStatus() {
        IO.println(nome + " [" + tipo + "] - Vida: " + vida);
    }

    // ⚡ Poder: curar-se
    void curar(int cura) {
        vida += cura;
    }
}
