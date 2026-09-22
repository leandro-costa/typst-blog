public class Conta {
    int numero;
    String cliente;
    double saldo;
    double limite;

    // ... construtores e métodos ...

    // Duas contas são iguais se tiverem o mesmo número
    public boolean equals(Conta outraConta) {
        return this.numero == outraConta.numero;
    }
}
