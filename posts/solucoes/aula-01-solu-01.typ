#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Solução 1: Markup do Typst",
  date: "2026-08-14",
  tags: ("typst", "exercicio"),
  excerpt: "Resolução do exercício 1.",
)

#let body = [

== Resolução

1. Equação inline: $x^2 + y^2 = r^2$.
2. Lista marcada:
   - Primeiro item
   - Segundo item
   - Terceiro item
3. Bloco de código:

```typ
#let ola = "mundo"
Olá, *#ola*!
```
]

#post-layout(meta, body)
