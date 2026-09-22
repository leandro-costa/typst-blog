// Classe Pai
class Pessoa {
    String nome;

    // Construtor com parâmetro
    public Pessoa(String nome) {
        this.nome = nome;
        IO.println("Construtor da classe Pessoa chamado!");
    }
}

// Classe Filha
class Aluno extends Pessoa {
    int matricula;

    // Construtor da classe filha
    public Aluno(String nome, int matricula) {
        super(nome); // Chama o construtor da classe Pai (Pessoa)
        this.matricula = matricula;
        IO.println("Construtor da classe Aluno chamado!");
    }
}

// Classe Principal para Teste
public class Main {
    public static void main(String[] args) {
        Aluno aluno = new Aluno("Carlos", 12345);
    }
}
