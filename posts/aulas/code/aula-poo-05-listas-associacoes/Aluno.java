class Aluno {
    String nome;
    String matricula;
    List<Turma> turmas;

    Aluno(String matricula, String nome) {
        this.nome = nome;
        this.matricula = matricula;
        this.turmas = new ArrayList<>();
    }

    void adicionarTurma(Turma turma) {
        if (!turmas.contains(turma)) {
            turmas.add(turma);
        }
    }

    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof Aluno)) return false;
        Aluno outro = (Aluno) obj;
        return this.matricula.equals(outro.matricula);
    }

    @Override
    String toString() {
        return nome + " (" + matricula + ")";
    }
}

class Professor {
    String nome;
    String especialidade;

    Professor(String nome, String especialidade) {
        this.nome = nome;
        this.especialidade = especialidade;
    }

    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (!(obj instanceof Professor)) return false;
        Professor outro = (Professor) obj;
        return this.nome.equals(outro.nome) && this.especialidade.equals(outro.especialidade);
    }

    @Override
    String toString() {
        return nome + " - " + especialidade;
    }
}

class AulaPrincipal {
    public static void main(String[] args) {
        Turma turma = new Turma("POO - 2026");
        Aluno aluno = new Aluno("A001", "João");
        Professor professor = new Professor("Mariana", "Java");

        turma.adicionarAluno(aluno);
        turma.adicionarProfessor(professor);

        //turma.getAlunos().forEach(System.out::println);
        for (int i = 0; i < turma.getAlunos().size(); i++) {
            Aluno a = turma.getAlunos().get(i);
            System.out.println(a);
        }
        //turma.getProfessores().forEach(System.out::println);
        for (Professor p : turma.getProfessores()) {
            System.out.println(p);
        }
    }
}
