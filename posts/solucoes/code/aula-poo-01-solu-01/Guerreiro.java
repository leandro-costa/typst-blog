public class Guerreiro {
    String nome;
    int vida;
    int forca;

    Guerreiro(String nome, int vida, int forca) {
        this.nome = nome;
        this.vida = vida;
        this.forca = forca;
    }

    void atacar(Guerreiro alvo) {
        alvo.vida -= this.forca;
        if (alvo.vida < 0) alvo.vida = 0;
    }

    void exibirStatus() {
        IO.println(this.nome + " | Vida: " + this.vida + " | Forca: " + this.forca);
    }
}
