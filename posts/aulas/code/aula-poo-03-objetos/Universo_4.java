public class Universo {
    public static void main(String[] args) {
        Criatura c1 = new Criatura("Fênix", 100, "Ave de Fogo", 30);
        Criatura c2 = new Criatura("Fênix", 100, "Ave de Fogo", 30);

        if (c1 == c2) {
            IO.println("Mesma criatura!");
        } else {
            IO.println("Criaturas diferentes!"); // ✅ Este é o resultado!
        }
    }
}
