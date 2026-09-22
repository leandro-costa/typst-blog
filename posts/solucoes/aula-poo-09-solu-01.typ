#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução: O Grande Banquete da Metamorfose",
  date: "2026-07-22",
  tags: ("java", "polimorfismo", "heranca", "greenfoot", "poo", "solucao"),
  excerpt: "isTouching(Maca.class) só pega maçã; trocar para isTouching(Fruta.class) e o personagem passa a comer qualquer fruta, sem tocar em mais nenhuma linha do resto do código.",
)

#let body = [

== Abordagem

Três hierarquias saindo de `Alimento` (que só guarda `energia` e um getter): `Fruta` (`Maca`, `Banana`, `Uva`), `Vegetal` (`Cenoura`, `Brocolis`, `Tomate`) e uma terceira independente, `Doce` (`Bolo`, `Sorvete`, `Chocolate`). O `Personagem` só come frutas — e o pulo do gato está em qual classe passamos pro `isTouching`.

#figure(
  raw(read("code/aula-poo-09-solu-01/Alimento.java"), lang: "java", block: true),
  caption: [Classe base `Alimento`, com `energia` privada e getter.]
)

#figure(
  raw(read("code/aula-poo-09-solu-01/Fruta.java"), lang: "java", block: true),
  caption: [`Fruta`, base para as frutas concretas.]
)

#figure(
  raw(read("code/aula-poo-09-solu-01/Maca.java"), lang: "java", block: true),
  caption: [`Maca`, `Banana` e `Uva` seguem o mesmo molde — cada uma só define energia e cor.]
)

#figure(
  raw(read("code/aula-poo-09-solu-01/Vegetal.java"), lang: "java", block: true),
  caption: [`Vegetal`, base para `Cenoura`, `Brocolis` e `Tomate`.]
)

#figure(
  raw(read("code/aula-poo-09-solu-01/Doce.java"), lang: "java", block: true),
  caption: [`Doce`, a terceira hierarquia, totalmente independente de `Fruta`/`Vegetal`.]
)

#figure(
  raw(read("code/aula-poo-09-solu-01/Bolo.java"), lang: "java", block: true),
  caption: [`Bolo` — mesmo padrão das outras subclasses concretas.]
)

== O personagem e a detecção

#figure(
  raw(read("code/aula-poo-09-solu-01/Personagem.java"), lang: "java", block: true),
  caption: [`Personagem`, com o experimento de polimorfismo documentado em comentário.]
)

== O mundo, gerando alimentos aleatórios

#figure(
  raw(read("code/aula-poo-09-solu-01/MundoBanquete.java"), lang: "java", block: true),
  caption: [`MundoBanquete`, sorteando um tipo de alimento a cada quadro (com baixa probabilidade).]
)

== Pontos-chave

- `isTouching(Maca.class)` só detecta objetos cuja classe real é exatamente `Maca` — uma `Banana` colidindo não conta, mesmo sendo fruta.
- Trocar para `isTouching(Fruta.class)` (comentado no código) muda o comportamento sem tocar em mais nada: `Maca`, `Banana` e `Uva` são todas subclasses de `Fruta`, então todas passam a ser detectadas de uma vez. Isso é polimorfismo puro — o método `isTouching` decide sozinho, olhando a árvore de herança.
- `Vegetal` e `Doce` existem no mundo (o `MundoBanquete` sorteia os três tipos), mas nunca são comidos pelo personagem — prova de que a detecção por tipo é seletiva, não é "qualquer coisa que colidir".
- `MundoBanquete.spawnAlimento()` usa um `switch` sobre um número aleatório pra decidir qual das nove subclasses concretas instanciar — nenhuma delas precisa saber das outras.

]

#post-layout(meta, body)
