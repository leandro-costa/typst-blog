#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: Classes, Atributos, Métodos e Construtores",
  date: "2026-02-19 07:40:00",
  tags: ("java", "classe", "atributo", "metodo", "construtor", "exercicio"),
  excerpt: "Molde a classe Conta com construtor, saque, depósito, transferência entre contas e extrato — e teste tudo no BlueJ.",
)

#let body = [

== Missão

Sua primeira criatura básica já existe — agora o universo precisa de algo mais sofisticado: uma *Conta* bancária, com saldo, limite e vontade própria de sacar e depositar.

+ Projete a classe `Conta` com os atributos: número, cliente (nome), saldo e limite.
+ Defina um construtor para que toda conta nasça com um titular e um número, começando com saldo zero e limite zero.
+ Implemente os métodos: `depositar`, `sacar` (com validação!), `transferir` (para outra conta) e `exibirExtrato`.
+ Crie um *segundo construtor* para contas com limite (cheque especial), em que o limite é informado na criação.
+ No BlueJ, crie pelo menos *3 contas*, faça operações entre elas e inspecione os estados.

== Requisitos técnicos

- Classe `Conta` com atributos: `int numero`, `String cliente`, `double saldo`, `double limite`.
- Construtor que recebe `numero` e `cliente` (saldo e limite iniciam em 0).
- Segundo construtor que recebe `numero`, `cliente` e `limite`.
- Método `void depositar(double valor)` — adiciona valor ao saldo.
- Método `boolean sacar(double valor)` — retorna `true` se o saque foi possível (saldo + limite ≥ valor), `false` caso contrário.
- Método `boolean transferir(Conta destino, double valor)` — saca de si e deposita no destino.
- Método `void exibirExtrato()` — exibe número, cliente, saldo e limite.
- Teste no BlueJ com pelo menos 3 contas e operações entre elas.

== Critérios de avaliação

#figure(
  table(
    columns: 2,
    [*Critério*], [*Pontos*],
    [Classe com atributos corretos], [10],
    [Construtor básico funcional], [15],
    [Segundo construtor (com limite)], [10],
    [Método `depositar` correto], [10],
    [Método `sacar` com validação e retorno], [20],
    [Método `transferir` entre contas], [20],
    [Método `exibirExtrato`], [5],
    [Teste no BlueJ com pelo menos 3 contas], [10],
    [*Total*], [*100*],
  ),
  caption: [Distribuição de pontos do exercício.]
)

== Dica

O método `transferir` não precisa reinventar a roda: se você já tem `sacar` e `depositar` prontos, por que não reaproveitá-los? Um bom código não repete trabalho — ele compõe comportamentos que já existem.

]

#post-layout(meta, body)
