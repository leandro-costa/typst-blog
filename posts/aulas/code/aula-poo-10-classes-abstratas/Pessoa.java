public abstract class Pessoa {
    protected int matricula;
    protected String nome;

    public Pessoa(int matricula, String nome) {
        this.matricula = matricula;
        this.nome = nome;
    }

    // Método concreto — todas as pessoas entram na faculdade
    public void entrar() {
        IO.println(nome + " entrou na faculdade.");
    }

    // Método abstrato — cada tipo de pessoa estaciona de um jeito
    public abstract void estacionar();
}

class Aluno extends Pessoa {
    private double media;

    public Aluno(int matricula, String nome, double media) {
        super(matricula, nome);
        this.media = media;
    }

    @Override
    public void estacionar() {
        IO.println(nome + " estacionou na área dos estudantes.");
    }
}

class Professor extends Pessoa {
    private double salario;

    public Professor(int matricula, String nome, double salario) {
        super(matricula, nome);
        this.salario = salario;
    }

    @Override
    public void estacionar() {
        IO.println(nome + " estacionou nas vagas de professores.");
    }
}
