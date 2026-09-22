#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: Associações, Agregação e Composição",
  date: "2026-03-11",
  tags: ("java", "associacao", "agregacao", "composicao", "poo", "solucao"),
  excerpt: "Fornecedor entra por agregação no Produto; ItemPedido nasce por composição dentro do Pedido — as duas relações convivendo no mesmo sistema.",
)

#let body = [

== Abordagem

Quatro classes, duas relações diferentes:

- `Produto` recebe `Fornecedor` *por parâmetro* — agregação. O fornecedor existe fora do produto e continua existindo se o produto sumir.
- `Pedido` *cria* seus próprios `ItemPedido` dentro de `adicionarProduto` — composição. Sem o pedido, os itens não fazem sentido sozinhos.

#figure(
  raw(read("code/aula-poo-04-solu-01/Fornecedor.java"), lang: "java", block: true),
  caption: [Classe `Fornecedor`.]
)

#figure(
  raw(read("code/aula-poo-04-solu-01/Produto.java"), lang: "java", block: true),
  caption: [`Produto`, recebendo o `Fornecedor` por agregação.]
)

#figure(
  raw(read("code/aula-poo-04-solu-01/ItemPedido.java"), lang: "java", block: true),
  caption: [`ItemPedido`, com `getSubtotal()`.]
)

#figure(
  raw(read("code/aula-poo-04-solu-01/Pedido.java"), lang: "java", block: true),
  caption: [`Pedido`, criando `ItemPedido` internamente — composição.]
)

== Testando

#figure(
  raw(read("code/aula-poo-04-solu-01/Testa.java"), lang: "java", block: true),
  caption: [Um fornecedor, três produtos e um pedido com os três itens.]
)

Saída:

```
Teclado mecânico - R$ 250.0 (fornecido por Distribuidora Central)
Mouse sem fio - R$ 90.0 (fornecido por Distribuidora Central)
Monitor 24" - R$ 800.0 (fornecido por Distribuidora Central)

Pedido 1 - Cliente: Ana Beatriz
  1x Teclado mecânico = R$ 250.0
  2x Mouse sem fio = R$ 180.0
  1x Monitor 24" = R$ 800.0
Total: R$ 1230.0
```

== Pontos-chave

- O mesmo `Fornecedor` é passado para os três produtos — prova de que ele existe independentemente de qualquer um deles (agregação de verdade).
- `adicionarProduto` recebe um `Produto` e uma quantidade, e *é ele quem instancia* o `ItemPedido` correspondente — o chamador nunca cria um `ItemPedido` diretamente.
- `calcularTotal` soma os subtotais percorrendo a lista — nenhuma duplicação de lógica de preço, que já mora em `ItemPedido.getSubtotal()`.

]

#post-layout(meta, body)
