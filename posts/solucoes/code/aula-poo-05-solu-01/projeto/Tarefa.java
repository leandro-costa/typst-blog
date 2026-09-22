import java.util.ArrayList;
import java.util.List;

public class Tarefa {
    String nome;
    List<Funcionario> funcionarios;

    Tarefa(String nome) {
        this.nome = nome;
        this.funcionarios = new ArrayList<>();
    }

    void atribuir(Funcionario funcionario) {
        this.funcionarios.add(funcionario);
    }

    @Override
    public String toString() {
        return this.nome + " (" + this.funcionarios.size() + " funcionário(s))";
    }
}
