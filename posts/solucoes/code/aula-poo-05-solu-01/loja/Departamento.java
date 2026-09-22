public class Departamento {
    String nome;

    Departamento(String nome) {
        this.nome = nome;
    }

    @Override
    public String toString() {
        return this.nome;
    }
}
