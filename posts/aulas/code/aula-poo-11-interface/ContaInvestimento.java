public interface Tributavel {
    void calcularTributo();
}

public interface ContaTributavel extends Conta, Tributavel {
    // sem métodos próprios: só herda as obrigações dos dois pactos
}

public class ContaInvestimento implements ContaTributavel {
    private double saldo;

    public ContaInvestimento(double saldoInicial) {
        this.saldo = saldoInicial;
    }

    @Override
    public void deposita(double valor) {
        this.saldo += valor;
    }

    @Override
    public void saca(double valor) {
        this.saldo -= valor;
    }

    @Override
    public void calcularTributo() {
        IO.println("Tributo calculado sobre o investimento.");
    }
}
