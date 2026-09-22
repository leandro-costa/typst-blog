public class Conta {
    // 🔒 Segredos Sagrados: ninguém de fora toca aqui
    private double saldo;
    private String titular;

    public Conta(String titular, double saldoInicial) {
        this.titular = titular;
        // Usamos o setter para garantir que o saldo inicial seja válido
        setSaldo(saldoInicial);
    }

    // 🚪 Portal de Leitura (Getter)
    public double getSaldo() {
        return saldo;
    }

    public String getTitular() {
        return titular;
    }

    // 🚪 Portal de Escrita (Setter) com a Lei do Universo
    public void setSaldo(double novoSaldo) {
        if (novoSaldo >= 0) {
            this.saldo = novoSaldo;
        } else {
            IO.println("⚠️ Lei Violada: O saldo não pode ser negativo!");
        }
    }

    public void setTitular(String novoTitular) {
        if (novoTitular != null && !novoTitular.isBlank()) {
            this.titular = novoTitular;
        }
    }
}

public class Universo {
    public static void main(String[] args) {
        Conta conta = new Conta("Mortal", 1000.0);
        
        // Tentativa de interferência:
        // conta.saldo = -5000.0; // ❌ Erro de compilação! A armadura protege.
        
        conta.setSaldo(-5000.0); // ⚠️ A lei é aplicada e o valor é recusado.
        IO.println("Saldo final: " + conta.getSaldo()); // Continua 1000.0
    }
}
