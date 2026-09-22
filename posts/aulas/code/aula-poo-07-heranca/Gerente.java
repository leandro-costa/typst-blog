class Gerente extends Funcionario {
    int senha;
    int numeroDeFuncionariosGerenciados;
    public boolean autentica(int senha) {
        if (this.senha == senha) {
            IO.println("Acesso Permitido!");
            return true;
        } else {
            IO.println("Acesso Negado!");
            return false;
        }
    }
    // setter da senha omitido
}
