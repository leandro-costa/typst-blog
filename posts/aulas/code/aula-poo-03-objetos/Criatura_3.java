public class Criatura {
    String nome;
    int vida;
    String tipo;
    int forca;

    Criatura(String nome, int vida, String tipo, int forca) {
        this.nome = nome;
        this.vida = vida;
        this.tipo = tipo;
        this.forca = forca;
    }

    // A criatura se apresenta ao universo
    @Override
    public String toString() {
        return this.nome + " [" + this.tipo + "] - Vida: " + this.vida
                + " | Força: " + this.forca;
    }

    public boolean equals(Criatura outra) {
        return this.nome.equals(outra.nome);
    }

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
}
