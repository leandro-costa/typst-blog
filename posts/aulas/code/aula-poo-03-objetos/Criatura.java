public class Criatura {
    String nome;
    int vida;
    String tipo;
    int forca;

    // 🌅 Ritual de Nascimento
    Criatura(String nome, int vida, String tipo, int forca) {
        this.nome = nome;
        this.vida = vida;
        this.tipo = tipo;
        this.forca = forca;
    }

    void atacar(Criatura alvo) {
        IO.println(this.nome + " ataca " + alvo.nome + "!");
        alvo.receberDano(this.forca);
    }

    void receberDano(int dano) {
        this.vida -= dano;
        if (this.vida < 0) this.vida = 0;
    }

    void exibirStatus() {
        IO.println(this.nome + " [" + this.tipo + "] - Vida: " + this.vida);
    }

    boolean estaViva() {
        return this.vida > 0;
    }
}
