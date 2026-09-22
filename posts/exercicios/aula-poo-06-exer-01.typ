#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: O Tesouro do Dragão Ancestral",
  date: "2026-05-19 15:30:00",
  tags: ("java", "encapsulamento", "exercicio"),
  excerpt: "O dragão Smaug quer um sistema de tesouro impenetrável: ouro e diamantes protegidos por private, com validação em cada ritual de depósito e saque.",
)

#let body = [

== Missão

O dragão Smaug guarda um tesouro colossal na montanha — mas anda desconfiado de ladrões e deuses menores tentando "ajustar" a contagem de ouro e diamantes durante seus cochilos. Ele quer um sistema de gestão de tesouro absolutamente impenetrável: nada de acesso direto, só rituais (métodos) que sigam a vontade do dragão.

+ Crie a classe `Tesouro` com os atributos `quantidadeOuro` e `quantidadeDiamantes` estritamente *privados*.
+ Implemente `depositarOuro(int valor)`: se o valor for positivo, o ouro é adicionado; se for zero ou negativo, emita o aviso _"O Dragão não aceita oferendas vazias ou dívidas!"_ e não altere o saldo.
+ Implemente `sacarOuro(int valor)`: o saque só é permitido se houver ouro suficiente; se tentar sacar mais do que existe, exiba _"Tentar roubar mais do que existe é um convite ao fogo do dragão!"_.
+ Implemente `adicionarDiamantes(int valor)`. Diamantes são preciosos demais para serem retirados — a classe *não deve ter* nenhum método de saque para eles.
+ Implemente `toString()` ou `exibirInventario()` mostrando a quantidade atual de ouro e diamantes.

== Requisitos técnicos

- Atributos `quantidadeOuro` e `quantidadeDiamantes` declarados `private`.
- Validação correta no depósito de ouro (não aceita valor não positivo).
- Validação correta no saque de ouro (não deixa saldo negativo).
- Validação correta no depósito de diamantes.
- Nenhum método de saque de diamantes disponível.
- `toString()` ou `exibirInventario()` implementado corretamente.
- O construtor também usa os métodos de validação, para o tesouro nunca nascer num estado inválido.

== Critérios de avaliação

#figure(
  table(
    columns: 2,
    [*Critério*], [*Pontos*],
    [Atributos declarados como `private`], [30],
    [Validação correta no depósito de ouro (não negativo)], [10],
    [Validação correta no saque de ouro (não exceder saldo)], [20],
    [Validação correta no depósito de diamantes], [10],
    [Impossibilidade de retirar diamantes (sem método de saque)], [15],
    [Implementação correta do `toString`/`exibirInventario`], [15],
    [*Total*], [*100*],
  ),
  caption: [Distribuição de pontos do exercício.]
)

== Dica

O construtor também deve usar os métodos de validação — senão o tesouro pode nascer num estado inválido, e aí de nada adiantou blindar os métodos.

]

#post-layout(meta, body)
