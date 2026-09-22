#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: Associações, Agregação e Composição",
  date: "2026-03-10 08:30:00",
  tags: ("java", "associacao", "agregacao", "composicao", "exercicio"),
  excerpt: "Montar um sistema de pedidos: Fornecedor, Produto, ItemPedido e Pedido — misturando agregação e composição no mesmo sistema.",
)

#let body = [

== Missão

Seu sistema cresceu, e as coisas precisam se conectar: um pedido tem itens, cada item referencia um produto, e cada produto tem um fornecedor. As relações são o que dão vida ao sistema.

+ Crie a classe `Fornecedor` com atributos: nome e CNPJ.
+ Crie a classe `Produto` com atributos: nome, preço e fornecedor (*agregação* — o fornecedor existe fora do produto).
+ Crie a classe `ItemPedido` com atributos: produto, quantidade e um método que calcula o subtotal.
+ Crie a classe `Pedido` com atributos: número, cliente (`String`) e uma lista de itens. O pedido deve *criar* os itens internamente ao adicionar um produto (*composição*).
+ Implemente `toString()` em *todas* as classes.
+ No `main`, demonstre: um fornecedor que fornece para múltiplos produtos, um pedido com pelo menos 3 itens, e o total do pedido calculado corretamente.

== Requisitos técnicos

- Classe `Fornecedor` com atributos `String nome`, `String cnpj` e construtor.
- Classe `Produto` com atributos `String nome`, `double preco`, `Fornecedor fornecedor` — agregação (fornecedor vem por parâmetro).
- Classe `ItemPedido` com atributos `Produto produto`, `int quantidade` e método `double getSubtotal()`.
- Classe `Pedido` com atributo `List<ItemPedido> itens` — composição (itens criados internamente pelo método `adicionarProduto`).
- Método `void adicionarProduto(Produto produto, int quantidade)` no `Pedido` que cria o `ItemPedido` internamente.
- Método `double calcularTotal()` no `Pedido`.
- `toString()` implementado nas 4 classes.
- Demonstração no `main` com pelo menos 1 fornecedor, 3 produtos e 1 pedido com 3+ itens.

== Critérios de avaliação

#figure(
  table(
    columns: 2,
    [*Critério*], [*Pontos*],
    [Classe `Fornecedor` com construtor e `toString`], [10],
    [Classe `Produto` com agregação de `Fornecedor`], [15],
    [Classe `ItemPedido` com `getSubtotal`], [15],
    [Classe `Pedido` com composição de `ItemPedido`], [25],
    [Método `calcularTotal` correto], [10],
    [`toString()` funcional em todas as classes], [15],
    [Demonstração no `main` com dados válidos], [10],
    [*Total*], [*100*],
  ),
  caption: [Distribuição de pontos do exercício.]
)

== Dica

Se o `Pedido` recebe o `Produto` de fora mas cria o `ItemPedido` por dentro, você tem agregação e composição convivendo no mesmo sistema. Observe quem cria quem — essa é a chave para não se perder.

]

#post-layout(meta, body)
