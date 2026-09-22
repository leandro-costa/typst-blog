public class Conta {
    public double saldo; // ⚠️ Exposto! Qualquer deus pode mexer.
    public String titular;

    public Conta(String titular, double saldoInicial) {
        this.titular = titular;
        this.saldo = saldoInicial;
    }
}

public class Universo {
    public static void main(String[] args) {
        Conta conta = new Conta("Mortal", 1000.0);
        
        // Interferência Divina Caótica:
        conta.saldo = -5000.0; // 💥 Erro! Saldo negativo impossível, mas o Java permitiu.
        IO.println("Saldo atual: " + conta.saldo);
    }
}
