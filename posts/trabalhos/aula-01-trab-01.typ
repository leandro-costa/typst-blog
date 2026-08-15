#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Trabalho 1: Publicar um post",
  date: "2026-08-16",
  tags: ("trabalho",),
  excerpt: "Trabalho para publicar um post no blog.",
)

#let body = [

== Enunciado

Crie um post em `posts/aulas/` e publique no site.

== Critérios

- Usar `meta` com título, data e tags.
- Incluir ao menos uma equação e um bloco de código.
- Conferir que aparece no site e no livro.
]

#post-layout(meta, body)
