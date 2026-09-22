public class Criatura {
    String nome;
    int vida;
    String tipo;

    // ⚡ Poder com resposta: sacar vida com validação
    boolean receberDano(int dano) {
        if (dano > vida) {
            return false; // Dano excessivo — recusado
        }
        vida -= dano;
        return true; // Dano aplicado com sucesso
    }

    // ⚡ Poder com resposta: verificar se está viva
    boolean estaViva() {
        return vida > 0;
    }

    void exibirStatus() {
        IO.println(nome + " [" + tipo + "] - Vida: " + vida);
    }
}
