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

    void depositar(double valor) {
        this.saldo += valor;
    }

    boolean sacar(double valor) {
        if (this.saldo + this.limite >= valor) {
            this.saldo -= valor;
            return true;
        }
        return false;
    }

    boolean transferir(Conta destino, double valor) {
        if (this.sacar(valor)) {
            destino.depositar(valor);
            return true;
        }
        return false;
    }

    @Override
    public String toString() {
        return "Conta " + this.numero + " | " + this.cliente
                + " | Saldo: R$" + this.saldo + " | Limite: R$" + this.limite;
    }
}
