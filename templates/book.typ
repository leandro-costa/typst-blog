// templates/book.typ
// Livro em A4: capa, página de rosto, sumário e capítulos.

#import "codly.typ": apply-codly

#let book-template(
  title: "Livro",
  subtitle: none,
  author: none,
  date: none,
  posts: (),
  body,
) = {
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2.5cm),
    numbering: "1",
    number-align: center + bottom,
  )

  set text(size: 11pt, lang: "pt", region: "BR")
  set heading(numbering: "1.")
  set par(justify: true, leading: 0.65em)

  // Capa
  page(margin: 0cm)[
    #set align(center + horizon)
    #v(3cm)
    #text(size: 2.4em, weight: "bold")[#title]
    #if subtitle != none {
      v(0.8em)
      text(size: 1.4em, style: "italic", gray)[#subtitle]
    }
    #v(2cm)
    #line(length: 60%)
    #v(1cm)
    #if author != none {
      text(size: 1.1em)[#author]
      v(0.5em)
    }
    #if date != none {
      text(size: 0.9em, gray)[#date]
    }
    #v(3cm)
    #text(size: 0.8em, gray)[Compilado automaticamente com Typst]
  ]

  // Página de rosto
  pagebreak()
  set align(center + horizon)
  text(size: 1.6em, weight: "bold")[#title]
  if subtitle != none {
    v(0.5em)
    text(size: 1.2em, style: "italic")[#subtitle]
  }
  v(1cm)
  if author != none {
    text(size: 1em)[#author]
  }

  // Sumário
  pagebreak()
  set align(left + top)
  heading(outlined: false)[Sumário]
  v(1em)
  for post in posts {
    box(width: 100%)[
      #post.title
      #h(1fr)
      #text(size: 0.85em, gray)[#post.date]
    ]
    v(0.4em)
  }

  // Conteúdo
  pagebreak()
  apply-codly(body)
}