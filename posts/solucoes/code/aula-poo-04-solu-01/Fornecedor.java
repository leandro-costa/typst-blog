public class Fornecedor {
    String nome;
    String cnpj;

    Fornecedor(String nome, String cnpj) {
        this.nome = nome;
        this.cnpj = cnpj;
    }

    @Override
    public String toString() {
        return this.nome + " (CNPJ: " + this.cnpj + ")";
    }
}
