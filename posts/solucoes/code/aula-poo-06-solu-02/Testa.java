public class Testa {
    public static void main(String[] args) {
        AparelhoDVD dvd = new AparelhoDVD();

        // Tentando operar desligado: nada deve acontecer
        dvd.aumentarVolume();
        IO.println("Volume (desligado, deve continuar 2): " + dvd.volume);

        dvd.ligar();
        IO.println("Ligado? " + dvd.ligado);

        dvd.aumentarVolume();
        dvd.aumentarVolume();
        IO.println("Volume após aumentar duas vezes: " + dvd.volume);

        Filme filme = new Filme();
        filme.nome = "De Volta para o Futuro";
        filme.categoria = "Ficção científica";
        filme.duracao = 116;

        String resultado = dvd.play();
        IO.println("Play sem filme inserido: " + resultado);

        dvd.inserirFilme(filme);
        resultado = dvd.play();
        IO.println("Play com filme inserido: " + resultado);

        dvd.stop();
        IO.println("Em play após stop? " + dvd.emPlay);
    }
}
