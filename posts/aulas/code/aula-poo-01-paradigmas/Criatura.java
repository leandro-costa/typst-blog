// O Molde — a Forma da Criação
public class Criatura {
    // A Essência (atributos) — protegida dentro do corpo
    String nome;
    int vida;

    // Os Poderes (métodos) — pertencem à criatura
    void receberDano(int dano) {
        this.vida -= dano;
        if (this.vida < 0) this.vida = 0;
    }

    void exibirStatus() {
        IO.println("Nome: " + this.nome + " | Vida: " + this.vida);
    }
}
