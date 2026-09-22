public class Conta {
    int numero;
    String cliente;
    double saldo;
    double limite;

    Conta(int numero, String cliente) {
        this.numero = numero;
        this.cliente = cliente;
        this.saldo = 0;
        this.limite = 0;
    }

    @Override
    public String toString() {
        return "Conta " + this.numero + " | " + this.cliente
                + " | Saldo: R$" + this.saldo + " | Limite: R$" + this.limite;
    }

    // ... demais métodos ...
}
