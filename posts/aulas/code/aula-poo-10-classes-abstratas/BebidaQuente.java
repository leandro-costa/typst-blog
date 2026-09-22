public abstract class BebidaQuente {
    // Template method — define o esqueleto do algoritmo
    public final void preparar() {
        ferverAgua();
        prepararIngrediente(); // Método abstrato — cada bebida faz diferente
        servir();
    }

    private void ferverAgua() {
        IO.println("Fervendo água...");
    }

    protected abstract void prepararIngrediente();

    private void servir() {
        IO.println("Servindo na xícara.");
        IO.println("Aproveite sua bebida!");
    }
}

class Cafe extends BebidaQuente {
    @Override
    protected void prepararIngrediente() {
        IO.println("Adicionando pó de café ao filtro.");
        IO.println("Passando água quente pelo pó...");
    }
}

class Cha extends BebidaQuente {
    @Override
    protected void prepararIngrediente() {
        IO.println("Colocando o saquinho de chá na xícara.");
        IO.println("Despejando água quente...");
    }
}

class ChocolateQuente extends BebidaQuente {
    @Override
    protected void prepararIngrediente() {
        IO.println("Adicionando chocolate em pó ao leite.");
        IO.println("Misturando bem...");
    }
}
