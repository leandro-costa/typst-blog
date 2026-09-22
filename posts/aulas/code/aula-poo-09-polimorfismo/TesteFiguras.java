public class TesteFiguras {
    public static void main(String[] args) {
        Figura[] figuras = new Figura[3];
        figuras[0] = new Circulo();
        figuras[1] = new Retangulo();
        figuras[2] = new Quadrado();

        for (Figura f : figuras) {
            f.desenhar();
        }
    }
}
