public class Universo {
    public static void main(String[] args) {
        Criatura fenix = new Criatura();
        fenix.nome = "Fênix";
        fenix.vida = 100;
        fenix.tipo = "Ave de Fogo";

        boolean sobreviveu = fenix.receberDano(30);
        if (sobreviveu) {
            IO.println("A criatura resistiu ao golpe!");
        } else {
            IO.println("O golpe foi demais para a criatura!");
        }

        IO.println("Está viva? " + fenix.estaViva());
    }
}
