public class Funcionario {
    String nome;

    Funcionario(String nome) {
        this.nome = nome;
    }

    @Override
    public String toString() {
        return this.nome;
    }
}
