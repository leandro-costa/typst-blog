public class Universo {
    public static void main(String[] args) {
        Conta c1 = new Conta(1, "Leandro");
        Conta c2 = new Conta(2, "Maria");

        c1.depositar(1000);

        c1.exibirExtrato(); // Saldo: 1000
        c2.exibirExtrato(); // Saldo: 0

        c1.transferir(c2, 200);

        c1.exibirExtrato(); // Saldo: 800
        c2.exibirExtrato(); // Saldo: 200
    }
}
