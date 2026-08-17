#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Do Blog ao Livro com Typst novo",
  date: "2026-08-17",
  author: "Autor do Blog",
  tags: ("typst", "pdf", "livro", "automação"),
  excerpt: "Como usar o mesmo conteúdo para gerar um blog em HTML e um livro em PDF simultaneamente.",
)

#let body = [

Uma das grandes vantagens do Typst é a capacidade de publicar para múltiplos formatos a partir da mesma fonte. Neste post, vou mostrar como estruturar um projeto que gera simultaneamente:

1. Um *blog* em HTML (multi-página)
2. Um *livro* em PDF (single-file)

== Arquitetura do projeto

A ideia central é separar o conteúdo da apresentação:

```
posts/          ← Conteúdo puro (markup)
templates/      ← Templates HTML e PDF
scripts/        ← Automação (TypeScript)
assets/         ← CSS, imagens, fontes
```

Cada post é um arquivo `.typ` independente com metadados:

```typ
#let meta = (
  title: "Título do Post",
  date: "2026-08-14",
  slug: "titulo-do-post",
)

= #meta.title

Conteúdo aqui...
```

== O Bundle Export

Introduzido no Typst 0.15, o bundle export @bundle-export permite emitir múltiplos arquivos:
#figure(
  ```typ
  #document("index.html", title: [Home])[
    // conteúdo da home
  ]

  #document("post.html", title: [Post])[
    // conteúdo do post
  ]

  #asset("style.css", read("style.css", encoding: none))
  ```,
  caption: [Legenda do código.],
)

== O Livro em PDF

Para o livro, concatenamos todos os posts em um único documento:

```typ
#import "templates/book-template.typ": book-template, book-post

#book-template(title: "Meu Livro")[
  #book-post(meta1, body1, 1)
  #book-post(meta2, body2, 2)
  // ...
]
```

== Automação com GitHub Actions

O workflow de CI/CD faz todo o trabalho:

1. Instala Typst e Bun
2. Executa o script de build
3. Compila o site (bundle HTML)
4. Compila o livro (PDF)
5. Faz deploy no GitHub Pages

O PDF fica disponível em `https://seu-usuario.github.io/seu-repo/book.pdf`.

== Conclusão

Com essa arquitetura, você escreve uma vez e publica em múltiplos formatos. O Typst cuida da tipografia, o script de build cuida da orquestração, e o GitHub Actions cuida do deploy.

#bibliography("../../refs.bib", title: "Referências")
]

#post-layout(meta, body)
