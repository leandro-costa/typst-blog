import java.util.List;

public class Simulador {
    public static void main(String[] args) {
        List<Animal> animais = List.of(
            new Peixe("Nemo"),
            new Anfibio("Frogg"),
            new Passaro("Sky")
        );

        for (Animal animal : animais) {
            animal.mover(); // cada animal se move à sua maneira!
        }
    }
}
