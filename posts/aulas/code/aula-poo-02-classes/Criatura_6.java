public class Criatura {
    String nome;
    int vida;
    String tipo;
    int forca;

    // Ritual completo
    Criatura(String nome, int vida, String tipo, int forca) {
        this.nome = nome;
        this.vida = vida;
        this.tipo = tipo;
        this.forca = forca;
    }

    // Ritual simplificado — criatura nasce com valores padrão
    Criatura(String nome) {
        this(nome,100,"Desconhecido",10);
    }

    // ... métodos ...
}
