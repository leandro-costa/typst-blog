class Conta {
    int numero;       // atributo
    String cliente;   // atributo
    double saldo;     // atributo
    double limite;    // atributo
    // Construtor
    Conta(int numero, String cliente, double saldo, double limite) {
        this.numero = numero;
        this.cliente = cliente;
        this.saldo = saldo;
        this.limite = limite;
    }
    void sacar(double valor) { // método sem retorno
        if (valor <= saldo + limite) {
            saldo -= valor;
        }
    }

    double consultarSaldo() { // método com retorno
        return saldo;
    }

}
