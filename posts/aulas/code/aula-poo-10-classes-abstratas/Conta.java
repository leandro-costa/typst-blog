public abstract class Conta {
    private String numero;
    private double saldo;

    public Conta(String numero, double saldoInicial) {
        this.numero = numero;
        this.saldo = saldoInicial;
    }

    public double getSaldo() {
        return saldo;
    }

    public void deposita(double valor) {
        if (valor > 0) {
            saldo += valor;
        }
    }

    protected void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    // Método abstrato: cada tipo de conta gera extrato diferente
    public abstract void imprimeExtrato();
}

class ContaPoupanca extends Conta {
    private int diaAniversario;

    public ContaPoupanca(String numero, double saldoInicial, int diaAniversario) {
        super(numero, saldoInicial);
        this.diaAniversario = diaAniversario;
    }

    @Override
    public void imprimeExtrato() {
        IO.println("=== EXTRATO CONTA POUPANÇA ===");
        IO.println("Saldo: R$ " + getSaldo());
        IO.println("Aniversário: dia " + diaAniversario);
    }
}

class ContaCorrente extends Conta {
    private double limite;

    public ContaCorrente(String numero, double saldoInicial, double limite) {
        super(numero, saldoInicial);
        this.limite = limite;
    }

    @Override
    public void imprimeExtrato() {
        IO.println("=== EXTRATO CONTA CORRENTE ===");
        IO.println("Saldo: R$ " + getSaldo());
        IO.println("Limite: R$ " + limite);
    }
}
