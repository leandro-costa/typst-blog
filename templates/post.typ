// templates/post.typ
// Moldura do artigo. Usada pelo post individual (preview), pelo site e pelo livro.
// - target "html" (site)     → emite <article> com cabeçalho e tags
// - target padrão/paged (preview e livro) → tipografia do artigo

#import "codly.typ": apply-codly

// Formata "YYYY-MM-DD[ HH:MM[:SS]]" → "DD/MM/YYYY[ HH:MM]" (padrão brasileiro).
#let format-date-br(date-str) = {
  let date = date-str.split(" ").at(0)
  let time = if date-str.split(" ").len() > 1 { date-str.split(" ").at(1) } else { none }
  let parts = date.split("-")
  if parts.len() != 3 {
    date-str
  } else {
    let out = parts.at(2) + "/" + parts.at(1) + "/" + parts.at(0)
    if time != none { out = out + " " + time.slice(0, 5) }
    out
  }
}

// Moldura do artigo. Usada pelo post individual (preview), pelo site e pelo livro.
// `default-author` é o autor do blog/livro, usado quando o post não define autor.
#let post-layout(meta, body, default-author: none) = context {
  let author = meta.at("author", default: none)
  if author == none { author = default-author }
  let date-display = meta.at("date-pt", default: format-date-br(meta.at("date", default: "")))
  if target() == "html" {
    html.elem("article", attrs: (class: "post"))[
      #html.elem("header", attrs: (class: "post-header"))[
        #html.elem("div", attrs: (class: "post-title-row"))[
          #html.elem("h1")[#meta.title]
          #html.elem("button", attrs: (id: "toggle-fullscreen", class: "icon-btn", type: "button", title: "Modo leitura (sem sidebar e navbar)", "aria-label": "Modo leitura"))[⛶]
        ]
        #html.elem("div", attrs: (class: "post-meta"))[
          #html.elem("time")[#date-display]
          #if author != none {
            html.elem("span")[ · #author]
          }
          #if meta.at("tags", default: ()) != () {
            html.elem("div", attrs: (class: "tags"))[
              #for tag in meta.tags {
                html.elem("span", attrs: (class: "tag"))[#tag]
              }
            ]
          }
        ]
      ]
      #html.elem("div", attrs: (class: "post-content"))[#body]
    ]
  } else {
    apply-codly([
      #align(center)[
        #text(size: 1.6em, weight: "bold")[#meta.title]
        #v(0.4em)
        #text(size: 0.9em, gray)[
          #date-display
          #if author != none {
            " · " + author
          }
        ]
      ]
      #v(1em)
      #line(length: 100%)
      #v(1em)
      #body
      #v(1em)
    ])
  }
}