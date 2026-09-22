public class TesteFiguras {
    public static void main(String[] args) {
        // Figura f = new Figura("azul"); // ❌ ERRO! Não compila!

        Figura[] figuras = new Figura[2];
        figuras[0] = new Circulo("vermelho", 5.0);
        figuras[1] = new Retangulo("azul", 4.0, 3.0);

        for (Figura f : figuras) {
            f.desenhar(); // Cada figura se desenha do seu jeito!
        }
    }
}
