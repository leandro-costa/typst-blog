public class Universo {
    public static void main(String[] args) {
        Criatura c1 = new Criatura("Fênix", 100, "Ave de Fogo", 30);
        Criatura c2 = c1; // c2 aponta para a MESMA criatura!

        c2.nome = "Fênix Renascida";
        IO.println(c1.nome); // Imprime "Fênix Renascida"!
    }
}
