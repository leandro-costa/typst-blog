public interface ExemploInterface {
    void metodoAbstrato();

    default void metodoDefault() {
        IO.println("Implementação padrão do método default.");
    }
}

public class ExemploClasse implements ExemploInterface {
    @Override
    public void metodoAbstrato() {
        IO.println("Implementação do método abstrato.");
    }
}

public class TesteDefault {
    public static void main(String[] args) {
        ExemploInterface exemplo = new ExemploClasse();
        exemplo.metodoAbstrato();
        exemplo.metodoDefault(); // usa a implementação padrão do pacto
    }
}
