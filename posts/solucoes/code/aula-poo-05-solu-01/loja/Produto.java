public class Produto {
    String nome;
    double preco;
    Departamento departamento;

    Produto(String nome, double preco, Departamento departamento) {
        this.nome = nome;
        this.preco = preco;
        this.departamento = departamento;
    }

    @Override
    public String toString() {
        return this.nome + " - R$ " + this.preco + " (" + this.departamento + ")";
    }
}
