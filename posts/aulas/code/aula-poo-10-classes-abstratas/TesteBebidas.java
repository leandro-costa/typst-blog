public class TesteBebidas {
    public static void main(String[] args) {
        BebidaQuente[] bebidas = {
            new Cafe(),
            new Cha(),
            new ChocolateQuente()
        };

        for (BebidaQuente b : bebidas) {
            IO.println("--- Preparando ---");
            b.preparar();
            IO.println("");
        }
    }
}
