public class Universo {
    public static void main(String[] args) {
        Criatura c1 = new Criatura("Fênix", 100, "Ave de Fogo", 30);
        Criatura c2 = new Criatura("Fênix", 150, "Ave de Gelo", 40);

        IO.println(c1 == c2);      // false — endereços diferentes
        IO.println(c1.equals(c2)); // true  — mesmo nome!
    }
}
