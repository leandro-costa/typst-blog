#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício: Listas nas Associações",
  date: "2026-04-14 13:30:00",
  tags: ("java", "associacao", "lista", "arraylist", "exercicio"),
  excerpt: "Em duplas, modelar em UML e Java dois cenários com associações de lista: gestão de projetos e uma loja de roupas com carrinho.",
)

#let body = [

== Missão

Em duplas, desenvolva um modelo UML e um código Java para cada um dos cenários abaixo. A ideia é praticar associações 1:N e N:N usando listas de verdade — sem gambiarra.

+ Modele um sistema de *Projeto de Software* com `Projeto`, `Tarefa` e `Funcionario`. Um projeto tem várias tarefas, e cada tarefa pode ser atribuída a vários funcionários.
+ Modele um sistema de *Loja de Roupas* com `Departamento`, `Produto`, `Cliente` e `Carrinho`. Um cliente pode ter vários carrinhos, e cada carrinho pode conter vários produtos.

Para cada cenário, entregue o diagrama UML (com as multiplicidades das associações) e as classes Java correspondentes, usando `List` onde a relação for de "muitos".

]

#post-layout(meta, body)
