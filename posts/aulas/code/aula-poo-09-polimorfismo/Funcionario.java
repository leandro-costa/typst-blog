class Funcionario {
    protected String nome;
    protected String cpf;
    protected double salario;

    public double getBonificacao() {
        return this.salario * 0.10;
    }

    public void setSalario(double salario) {
        this.salario = salario;
    }
}

class Gerente extends Funcionario {
    private int senha;
    private int numeroDeFuncionariosGerenciados;

    @Override
    public double getBonificacao() {
        return this.salario * 0.15;
    }

    public boolean autentica(int senha) {
        if (this.senha == senha) {
            IO.println("Acesso Permitido!");
            return true;
        }
        IO.println("Acesso Negado!");
        return false;
    }
}
