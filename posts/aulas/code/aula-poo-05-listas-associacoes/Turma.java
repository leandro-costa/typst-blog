import java.util.ArrayList;
import java.util.List;

class Turma {
    String nome;
    List<Aluno> alunos;
    List<Professor> professores;

    Turma(String nome) {
        this.nome = nome;
        this.alunos = new ArrayList<>();
        this.professores = new ArrayList<>();
    }

    void adicionarAluno(Aluno aluno) {
        if (!alunos.contains(aluno)) {
            alunos.add(aluno);
        }
    }

    void adicionarProfessor(Professor professor) {
        if (!professores.contains(professor)) {
            professores.add(professor);
        }
    }

    List<Aluno> getAlunos() {
        return alunos;
    }

    List<Professor> getProfessores() {
        return professores;
    }
}
