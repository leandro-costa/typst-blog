#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: Listas nas Associações",
  date: "2026-04-15",
  tags: ("java", "associacao", "lista", "arraylist", "poo", "solucao"),
  excerpt: "Dois cenários com List<>: um projeto com tarefas e funcionários, e uma loja com carrinhos cheios de produtos.",
)

#let body = [

== Cenário 1: Projeto de Software

`Projeto` tem uma lista de `Tarefa`; cada `Tarefa` tem uma lista de `Funcionario` atribuídos a ela — uma associação 1:N encadeada em outra 1:N.

#figure(
  raw(read("code/aula-poo-05-solu-01/projeto/Funcionario.java"), lang: "java", block: true),
  caption: [Classe `Funcionario`.]
)

#figure(
  raw(read("code/aula-poo-05-solu-01/projeto/Tarefa.java"), lang: "java", block: true),
  caption: [`Tarefa`, com uma lista de `Funcionario`.]
)

#figure(
  raw(read("code/aula-poo-05-solu-01/projeto/Projeto.java"), lang: "java", block: true),
  caption: [`Projeto`, com uma lista de `Tarefa`.]
)

#figure(
  raw(read("code/aula-poo-05-solu-01/projeto/Testa.java"), lang: "java", block: true),
  caption: [Um projeto com duas tarefas, cada uma com dois funcionários.]
)

Saída:

```
Projeto Site novo do curso (2 tarefa(s)):
  - Desenhar layout (2 funcionário(s))
  - Implementar API (2 funcionário(s))
```

== Cenário 2: Loja de Roupas

`Cliente` tem uma lista de `Carrinho`; cada `Carrinho` tem uma lista de `Produto`; cada `Produto` está associado a um `Departamento`.

#figure(
  raw(read("code/aula-poo-05-solu-01/loja/Departamento.java"), lang: "java", block: true),
  caption: [Classe `Departamento`.]
)

#figure(
  raw(read("code/aula-poo-05-solu-01/loja/Produto.java"), lang: "java", block: true),
  caption: [`Produto`, associado a um `Departamento`.]
)

#figure(
  raw(read("code/aula-poo-05-solu-01/loja/Carrinho.java"), lang: "java", block: true),
  caption: [`Carrinho`, com uma lista de `Produto`.]
)

#figure(
  raw(read("code/aula-poo-05-solu-01/loja/Cliente.java"), lang: "java", block: true),
  caption: [`Cliente`, com uma lista de `Carrinho`.]
)

#figure(
  raw(read("code/aula-poo-05-solu-01/loja/Testa.java"), lang: "java", block: true),
  caption: [Um cliente com um carrinho de três produtos.]
)

Saída:

```
Renata (1 carrinho(s))
Carrinho com 3 item(ns), total R$ 489.7
```

== Pontos-chave

- Nos dois cenários, quem "tem muitos" declara a lista (`Projeto` tem `List<Tarefa>`, `Cliente` tem `List<Carrinho>`) — e é sempre inicializada com `new ArrayList<>()` no construtor, nunca deixada `null`.
- `Cliente.novoCarrinho()` cria o carrinho, adiciona à própria lista *e* devolve a referência — assim quem chama pode continuar mexendo nele sem precisar buscar de volta na lista.
- `Carrinho.calcularTotal()` e `Tarefa`/`Projeto` seguem o mesmo padrão: percorrer a lista com `for` e acumular — o jeito mais direto de "somar tudo que está associado".

]

#post-layout(meta, body)
