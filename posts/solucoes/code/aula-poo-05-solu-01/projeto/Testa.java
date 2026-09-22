public class Testa {
    public static void main(String[] args) {
        Funcionario ana = new Funcionario("Ana");
        Funcionario bruno = new Funcionario("Bruno");
        Funcionario clara = new Funcionario("Clara");

        Tarefa layout = new Tarefa("Desenhar layout");
        layout.atribuir(ana);
        layout.atribuir(bruno);

        Tarefa backend = new Tarefa("Implementar API");
        backend.atribuir(bruno);
        backend.atribuir(clara);

        Projeto projeto = new Projeto("Site novo do curso");
        projeto.adicionarTarefa(layout);
        projeto.adicionarTarefa(backend);

        IO.println(projeto);
    }
}
