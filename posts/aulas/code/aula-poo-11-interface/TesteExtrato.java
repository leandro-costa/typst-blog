public class TesteExtrato {
    public static void main(String[] args) {
        GeradorDeExtrato gerador = new GeradorDeExtrato();

        Conta poupanca = new ContaPoupanca(1000.0);
        Conta corrente = new ContaCorrente(500.0);
        Conta previdencia = new PrevidenciaPrivada(20000.0);

        gerador.geraExtrato(poupanca);
        gerador.geraExtrato(corrente);
        gerador.geraExtrato(previdencia);
    }
}
