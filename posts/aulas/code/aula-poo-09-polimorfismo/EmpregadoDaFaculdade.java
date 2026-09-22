class EmpregadoDaFaculdade {
    private String nome;
    private double salario;

    double getGastos() {
        return this.salario;
    }

    String getInfo() {
        return "nome: " + this.nome + " com salário " + this.salario;
    }
}

class ProfessorDaFaculdade extends EmpregadoDaFaculdade {
    private int horasDeAula;

    @Override
    double getGastos() {
        return this.getSalario() + this.horasDeAula * 10;
    }

    @Override
    String getInfo() {
        return super.getInfo() + " horas de aula: " + this.horasDeAula;
    }
}

class Reitor extends EmpregadoDaFaculdade {
    @Override
    String getInfo() {
        return super.getInfo() + " e ele é um reitor";
    }
    // não sobrescrevemos getGastos()!
}
