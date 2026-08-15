#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Um segundo post, só pra testar a lista",
  date: "2026-08-15",
  tags: ("teste", "build"),
  excerpt: "Confirma que o build descobre vários arquivos em posts/ e ordena por data.",
)

#let body = [

Este post existe só pra confirmar que o build consegue descobrir vários arquivos na pasta `posts/` sozinho, gerar o `site.typ` e o `book.typ` automaticamente, e ordenar os posts do mais novo pro mais antigo na página inicial.

Se você está lendo isso na lista do blog e ele aparece *antes* do "Meu primeiro post", a ordenação por data está funcionando.
]

#post-layout(meta, body)
