public class Guerreiro {
    String nome;
    int vida;
    int forca;
    String cla;

    Guerreiro(String nome, int vida, int forca, String cla) {
        this.nome = nome;
        this.vida = vida;
        this.forca = forca;
        this.cla = cla;
    }

    void atacar(Guerreiro alvo) {
        IO.println(this.nome + " ataca " + alvo.nome + "!");
        alvo.vida -= this.forca;
        if (alvo.vida < 0) alvo.vida = 0;
    }

    @Override
    public String toString() {
        return "[" + this.cla + "] " + this.nome + " - Vida: " + this.vida + " | Força: " + this.forca;
    }

    public boolean equals(Guerreiro outro) {
        if (outro == null) return false;
        return this.nome.equals(outro.nome) && this.cla.equals(outro.cla);
    }
}
