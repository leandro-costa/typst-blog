public abstract class Figura {
    private String cor;

    public Figura(String cor) {
        this.cor = cor;
    }

    public String getCor() {
        return cor;
    }

    // Profecia Aberta: toda figura deve se desenhar
    public abstract void desenhar();
}

class Circulo extends Figura {
    private double raio;

    public Circulo(String cor, double raio) {
        super(cor);
        this.raio = raio;
    }

    @Override
    public void desenhar() {
        IO.println("⬤ Desenhando um círculo " + getCor() + " de raio " + raio);
    }
}

class Retangulo extends Figura {
    private double largura, altura;

    public Retangulo(String cor, double largura, double altura) {
        super(cor);
        this.largura = largura;
        this.altura = altura;
    }

    @Override
    public void desenhar() {
        IO.println("▬ Desenhando um retângulo " + getCor() +
                    " (" + largura + " x " + altura + ")");
    }
}
