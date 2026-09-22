public interface Usuario {
    boolean autenticar();
}

public class Funcionario {
    // ...
}

public class Gerente extends Funcionario implements Usuario {
    @Override
    public boolean autenticar() {
        return true;
    }
}

public class Cliente {
    // ...
}

public class PessoaJuridica extends Cliente implements Usuario {
    @Override
    public boolean autenticar() {
        return true;
    }
}

public class AutenticadorDeUsuario {
    public boolean autentica(Usuario u) {
        return u.autenticar();
    }
}
