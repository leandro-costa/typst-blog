class Funcionario {
    private int codigo;

    public int getCodigo() {
        return codigo;
    }

    public void setCodigo(int codigo) {
        this.codigo = codigo;
    }
}

class Gerente extends Funcionario {
    private String usuario;
    private String senha;
}

class Telefonista extends Funcionario {
    private int ramal;
}
