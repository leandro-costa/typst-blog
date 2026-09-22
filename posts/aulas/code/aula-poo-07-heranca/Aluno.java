class Aluno extends Pessoa {
    int matricula;

    // Erro: Pessoa(String) deve ser chamado explicitamente
    public Aluno(int matricula) {
        this.matricula = matricula;
    }
}
