#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#show: codly-init.with()
#codly(languages: codly-languages)

#set page(height: auto, margin: 0pt)

= Aula 07

Nesta aula você vai aprender a inserir os quatro tipos de conteúdo visual mais comuns em um documento Typst: **código**, **tabela**, **imagem** e **diagrama**. A regra é única: todo conteúdo visual precisa estar dentro de um `#figure(...)` com uma `caption` e um `kind`.

== Bloco de código

Para incluir um trecho de código, use um bloco delimitado por três crases e envolva-o em `#figure` com `kind: "code"`:

#figure(
  ```typ
  #let saudacao(nome) = [#text(size: 1.2em)["Olá, #nome!"]]
  #saudacao("Mundo")
  ```,
  caption: [Função simples em Typst.],
  supplement: [Código],
  kind: "code",
)

== Tabela

Tabelas também são figuras. Use a sintaxe nativa de tabela do Typst e informe `kind: "table"`:

#figure(
  table(
    columns: 3,
    [*Linguagem*], [*Tipo*], [*Uso*],
    [Typst], [Markup], [Tipografia],
    [Python], [Script], [Automação],
    [Bash], [Shell], [Comandos],
  ),
  caption: [Comparação entre linguagens usadas no curso.],
  supplement: [Tabela],
  kind: "table",
)

== Imagem

Imagens entram com `image("caminho.ext")`. Aqui usamos um conteúdo gerado como placeholder, já que o projeto ainda não tem arquivos de imagem:

#figure(
  box(
    width: 100%,
    height: 3cm,
    fill: gradient.linear(angle: 0deg, rgb(37, 99, 235), rgb(168, 85, 247)),
    inset: 1em,
    align(center + horizon)[
      #text(size: 1.4em, fill: white)[Imagem de exemplo]
    ],
  ),
  caption: [Ilustração de exemplo para demonstrar o uso de `#figure`.],
  supplement: [Imagem],
  kind: "image",
)

== Diagrama

Um diagrama pode ser desenhado com primitivas do Typst (`rect`, `line`, `circle`, `text`). Este exemplo mostra um fluxo simples de build:

#figure(
  grid(
    columns: 2,
    rows: (auto, auto),
    column-gutter: 1.5em,
    row-gutter: 1em,
    align(center)[
      #box(width: 100%, height: 1.6cm, fill: rgb(238, 242, 255), radius: 4pt, inset: 0.4em)[
        #text(weight: "bold")[Post .typ]
      ]
    ],
    align(center)[
      #box(width: 100%, height: 1.6cm, fill: rgb(238, 242, 255), radius: 4pt, inset: 0.4em)[
        #text(weight: "bold")[Template .typ]
      ]
    ],
    align(center)[
      #box(width: 100%, height: 1.6cm, fill: rgb(254, 243, 199), radius: 4pt, inset: 0.4em)[
        #text(weight: "bold")[Build (Bun)]
      ]
    ],
    align(center)[
      #box(width: 100%, height: 1.6cm, fill: rgb(220, 252, 231), radius: 4pt, inset: 0.4em)[
        #text(weight: "bold")[Site + PDF]
      ]
    ],
  ),
  caption: [Fluxo do build: conteúdo vira site e livro.],
  supplement: [Diagrama],
  kind: "diagram",
)

== Code 



```typ
#import "templates/book-template.typ": book-template, book-post

#book-template(title: "Meu Livro")[
  #book-post(meta1, body1, 1)
  #book-post(meta2, body2, 2)
  // ...
]
```

== Conclusão

Com `#figure(caption: ..., supplement: ..., kind: ...)` você garante que todo conteúdo visual tenha legenda e seja numerado corretamente — no blog e no livro. Os `kind` aceitos são `code`, `table`, `image` e `diagram`.

