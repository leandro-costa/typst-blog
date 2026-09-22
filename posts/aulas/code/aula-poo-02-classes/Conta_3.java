class Conta {
    int numero;       // atributo
    String cliente;   // atributo
    double saldo;     // atributo
    double limite;    // atributo

    void sacar(double valor) { // método sem retorno
        if (valor <= saldo + limite) {
            saldo -= valor;
        }
    }

    double consultarSaldo() { // método com retorno
        return saldo;
    }
}
