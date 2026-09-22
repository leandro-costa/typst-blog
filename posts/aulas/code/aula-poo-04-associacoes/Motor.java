public class Motor {
    int cavalos;
    int rotacoes;

    Motor(int cavalos) {
        this.cavalos = cavalos;
        this.rotacoes = 0;
    }

    void aumentarGiros() {
        this.rotacoes += 500;
    }

    void diminuirGiros() {
        if (this.rotacoes >= 500) {
            this.rotacoes -= 500;
        }
    }

    int trabalhoDoMotor() {
        return this.cavalos * this.rotacoes;
    }

    @Override
    public String toString() {
        return "Motor " + this.cavalos + "cv | Rotações: " + this.rotacoes;
    }
}
