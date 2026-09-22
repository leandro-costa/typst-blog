public abstract class Funcionario {
    protected String nome;
    protected String cpf;
    protected double salario;

    public Funcionario(String nome, String cpf, double salario) {
        this.nome = nome;
        this.cpf = cpf;
        this.salario = salario;
    }

    public double getSalario() {
        return salario;
    }

    // Método abstrato: cada cargo tem sua própria regra de bonificação
    public abstract double getBonificacao();
}

class Gerente extends Funcionario {
    private int senha;

    public Gerente(String nome, String cpf, double salario, int senha) {
        super(nome, cpf, salario);
        this.senha = senha;
    }

    @Override
    public double getBonificacao() {
        return salario * 0.15;
    }
}

class Diretor extends Funcionario {
    public Diretor(String nome, String cpf, double salario) {
        super(nome, cpf, salario);
    }

    @Override
    public double getBonificacao() {
        return salario * 0.25 + 2000;
    }
}

class Presidente extends Funcionario {
    public Presidente(String nome, String cpf, double salario) {
        super(nome, cpf, salario);
    }

    @Override
    public double getBonificacao() {
        return salario * 0.30 + 5000;
    }
}
