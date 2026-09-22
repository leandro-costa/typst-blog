public class Criatura {
    String nome;
    int vida;
    String tipo;
    int forca;

    Criatura(String nome, int vida, String tipo, int forca) {
        this.nome = nome;
        this.vida = vida;
        this.tipo = tipo;
        this.forca = forca;
    }

    // Definindo o critério de igualdade: criaturas com mesmo nome são iguais
    public boolean equals(Criatura outra) {
        return this.nome.equals(outra.nome);
    }

    // ... demais métodos ...
}
