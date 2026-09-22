public class Universo {
    public static void main(String[] args) {
        // O motor existe ANTES do carro — é criado de fora
        Motor motorV8 = new Motor(400);

        // O carro recebe o motor por parâmetro
        Carro fusca = new Carro("Azul", "VW", motorV8);

        System.out.println(fusca); // VW Azul | Vel: 0 | Motor 400cv | Rotações: 0

        fusca.acelerar();
        System.out.println(fusca); // VW Azul | Vel: 200 | Motor 400cv | Rotações: 500

        fusca.acelerar();
        System.out.println(fusca); // VW Azul | Vel: 600 | Motor 400cv | Rotações: 1000
    }
}
