public class Criatura {
    String nome;
    int vida;
    String tipo;
    int forca;

    // 🌅 Ritual de Nascimento completo
    Criatura(String nome, int vida, String tipo, int forca) {
        this.nome = nome;
        this.vida = vida;
        this.tipo = tipo;
        this.forca = forca;
    }

    // 🌅 Ritual simplificado
    Criatura(String nome) {
        this.nome = nome;
        this.vida = 100;
        this.tipo = "Desconhecido";
        this.forca = 10;
    }

    // ⚡ Poderes
    void atacar(Criatura alvo) {
        IO.println(this.nome + " ataca " + alvo.nome + "!");
        alvo.receberDano(this.forca);
    }

    void receberDano(int dano) {
        this.vida -= dano;
        if (this.vida < 0) this.vida = 0;
    }

    boolean estaViva() {
        return this.vida > 0;
    }

    // 🪪 Identidade: a criatura se apresenta
    @Override
    public String toString() {
        return this.nome + " [" + this.tipo + "] - Vida: " + this.vida
                + " | Força: " + this.forca;
    }

    // ⚖️ Igualdade: critério definido pelo Criador
    public boolean equals(Criatura outra) {
        return this.nome.equals(outra.nome);
    }
}
