public class Tesouro {
    private int quantidadeOuro;
    private int quantidadeDiamantes;

    Tesouro() {
        this.quantidadeOuro = 0;
        this.quantidadeDiamantes = 0;
    }

    Tesouro(int ouroInicial, int diamantesIniciais) {
        this();
        depositarOuro(ouroInicial);
        adicionarDiamantes(diamantesIniciais);
    }

    void depositarOuro(int valor) {
        if (valor <= 0) {
            IO.println("O Dragão não aceita oferendas vazias ou dívidas!");
            return;
        }
        this.quantidadeOuro += valor;
    }

    void sacarOuro(int valor) {
        if (valor <= 0 || valor > this.quantidadeOuro) {
            IO.println("Tentar roubar mais do que existe é um convite ao fogo do dragão!");
            return;
        }
        this.quantidadeOuro -= valor;
    }

    void adicionarDiamantes(int valor) {
        if (valor <= 0) {
            IO.println("O Dragão não aceita oferendas vazias ou dívidas!");
            return;
        }
        this.quantidadeDiamantes += valor;
    }

    // Note: propositalmente NÃO existe nenhum método de saque de diamantes.

    @Override
    public String toString() {
        return "Tesouro do Dragão: " + this.quantidadeOuro + " moedas de ouro, "
            + this.quantidadeDiamantes + " diamantes.";
    }
}
