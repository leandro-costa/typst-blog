public class TesteFaculdade {
    public static void main(String[] args) {
        Pessoa[] pessoas = new Pessoa[2];
        pessoas[0] = new Aluno(1001, "Clara", 8.5);
        pessoas[1] = new Professor(2001, "Dr. Santos", 9500.0);

        for (Pessoa p : pessoas) {
            p.entrar();
            p.estacionar();
        }
    }
}
