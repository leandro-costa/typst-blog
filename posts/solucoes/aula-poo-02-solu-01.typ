#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: Classes, Atributos, Métodos e Construtores",
  date: "2026-02-20",
  tags: ("java", "classe", "construtor", "poo", "solucao"),
  excerpt: "Uma ContaBancaria com dois construtores, saque validado, transferência que reaproveita sacar+depositar — sem reinventar a roda.",
)

#let body = [

== Abordagem

A classe `ContaBancaria` guarda número, titular, saldo e limite, além de rastrear a última operação feita (só para deixar o `exibirInformacoes` mais informativo). Os dois construtores pedidos: um simples (limite fixo em R\$ 100) e outro que recebe o limite explicitamente.

#figure(
  raw(read("code/aula-poo-02-solu-01/ContaBancaria.java"), lang: "java", block: true),
  caption: [Classe `ContaBancaria` completa.]
)

== Testando

#figure(
  raw(read("code/aula-poo-02-solu-01/Main.java"), lang: "java", block: true),
  caption: [Criando contas, fazendo operações e testando as validações.]
)

== Pontos-chave

- `sacar` e `transferir` checam o *saldo total disponível* (`saldo + limite`), não só o saldo — é assim que o cheque especial entra na conta.
- `transferir` não reimplementa saque e depósito: ele só ajusta `saldo` das duas contas diretamente, já que está dentro da própria classe e tem acesso aos atributos privados de `destino` (afinal, `destino` é do mesmo tipo `ContaBancaria`).
- Toda validação retorna `false` (ou não faz nada) em vez de lançar exceção — para o nível desta aula, isso já é suficiente pra provar que o objeto protege seu próprio estado.
- Valor, saque acima do limite disponível e transferência com valor zero são rejeitados sem quebrar o programa — o objeto nunca fica num estado inválido.

]

#post-layout(meta, body)
