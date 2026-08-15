#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Terceiro post: bastou criar o arquivo",
  date: "2026-08-16",
  tags: ("build",),
  excerpt: "Criar um novo arquivo em posts/ é suficiente para o post aparecer no site e no livro.",
)

#let body = [

Não editei o `site.typ` nem o `book.typ` pra este post aparecer aqui. Só criei este arquivo em `posts/` seguindo o padrão de nome `AAAA-MM-DD-slug.typ` e rodei o build de novo.
]

#post-layout(meta, body)
