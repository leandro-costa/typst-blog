public class Testa {
    public static void main(String[] args) {
        Guerreiro conan1 = new Guerreiro("Conan", 100, 25, "Cimérios");
        Guerreiro conan2 = new Guerreiro("Conan", 100, 25, "Cimérios");
        Guerreiro thorin = new Guerreiro("Thorin", 120, 20, "Anões da Montanha");
        Guerreiro legolas = new Guerreiro("Legolas", 90, 18, "Elfos Silvanos");

        IO.println(conan1);
        IO.println(conan2);
        IO.println(thorin);
        IO.println(legolas);

        IO.println("");
        IO.println("conan1 == conan2 ? " + (conan1 == conan2));
        IO.println("conan1.equals(conan2) ? " + conan1.equals(conan2));
        IO.println("conan1.equals(thorin) ? " + conan1.equals(thorin));

        IO.println("");
        conan1.atacar(thorin);
        IO.println(thorin);
    }
}
