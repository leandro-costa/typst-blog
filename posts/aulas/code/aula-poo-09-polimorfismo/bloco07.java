ControleDeBonificacoes controle = new ControleDeBonificacoes();

Gerente gerente = new Gerente();
gerente.setSalario(5000.0);
controle.registra(gerente); // Gerente é um Funcionario!

Funcionario func = new Funcionario();
func.setSalario(1000.0);
controle.registra(func);

IO.println(controle.getTotalDeBonificacoes()); // 750 + 100 = 850
