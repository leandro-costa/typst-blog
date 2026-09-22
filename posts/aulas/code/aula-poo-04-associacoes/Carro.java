public class Carro {
    String cor;
    String marca;
    int velocidade;
    Motor motor; // 🔗 Associação: Carro TEM UM Motor

    // O motor é recebido de fora — ele já existe antes do carro
    Carro(String cor, String marca, Motor motor) {
        this.cor = cor;
        this.marca = marca;
        this.motor = motor;
        this.velocidade = 0;
    }

    void acelerar() {
        this.motor.aumentarGiros();
        this.velocidade += this.motor.trabalhoDoMotor() / 1000;
    }

    void parar() {
        this.velocidade = 0;
        this.motor.diminuirGiros();
    }

    @Override
    public String toString() {
        return this.marca + " " + this.cor + " | Vel: " + this.velocidade
                + " | " + this.motor;
    }
}
