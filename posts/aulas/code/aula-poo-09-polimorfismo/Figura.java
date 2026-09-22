class Figura {
    public void desenhar() {
        IO.println("Desenhando uma figura genérica...");
    }
}

class Circulo extends Figura {
    @Override
    public void desenhar() {
        IO.println("⬤ Desenhando um círculo");
    }
}

class Retangulo extends Figura {
    @Override
    public void desenhar() {
        IO.println("▬ Desenhando um retângulo");
    }
}

class Quadrado extends Retangulo {
    @Override
    public void desenhar() {
        IO.println("◻ Desenhando um quadrado");
    }
}
