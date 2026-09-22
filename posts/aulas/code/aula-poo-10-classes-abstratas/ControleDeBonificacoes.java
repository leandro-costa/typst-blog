class ControleDeBonificacoes {
    private double total = 0;

    public void registra(Funcionario f) {
        total += f.getBonificacao();
        IO.println("Registrado: " + f.nome + " -> bônus de R$ " + f.getBonificacao());
    }

    public double getTotal() {
        return total;
    }
}

public class TesteBonificacao {
    public static void main(String[] args) {
        ControleDeBonificacoes controle = new ControleDeBonificacoes();
        controle.registra(new Gerente("Ana", "111.111.111-11", 8000, 1234));
        controle.registra(new Diretor("Carlos", "222.222.222-22", 12000));
        controle.registra(new Presidente("Maria", "333.333.333-33", 20000));
        IO.println("Total de bonificações: R$ " + controle.getTotal());
    }
}
