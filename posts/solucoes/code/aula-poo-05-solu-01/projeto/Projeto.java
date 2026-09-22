import java.util.ArrayList;
import java.util.List;

public class Projeto {
    String nome;
    List<Tarefa> tarefas;

    Projeto(String nome) {
        this.nome = nome;
        this.tarefas = new ArrayList<>();
    }

    void adicionarTarefa(Tarefa tarefa) {
        this.tarefas.add(tarefa);
    }

    @Override
    public String toString() {
        String texto = "Projeto " + this.nome + " (" + this.tarefas.size() + " tarefa(s)):\n";
        for (Tarefa t : this.tarefas) {
            texto += "  - " + t + "\n";
        }
        return texto;
    }
}
