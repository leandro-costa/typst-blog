#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Exercício 1: Markup do Typst",
  date: "2026-08-14",
  tags: ("typst", "exercicio"),
  excerpt: "Pratique markup básico do Typst.",
)

#let body = [

== Questões

1. Escreva uma equação inline.
2. Crie uma lista marcada com 3 itens.
3. Inclua um bloco de código com realce.

== Dica

Lembre-se de usar `$...$` para matemática e `` `...` `` para código inline.
]

#post-layout(meta, body)
