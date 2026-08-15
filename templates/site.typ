// templates/site.typ
// Layout de página do site, "aware de alvo":
// - html/bundle (build) → elementos HTML (nav, hero, cards, footer)
// - paged (preview do Tinymist) → versão tipografada
// Links usam caminhos absolutos de raiz (/index.html, /book.pdf, /assets/...).

#let site-title = "2026.2 POO"
#let site-subtitle = "Blog + livro"

#let head(page-title) = {
  html.elem("meta", attrs: (charset: "utf-8"))
  html.elem("meta", attrs: (name: "viewport", content: "width=device-width, initial-scale=1"))
  html.elem("title", page-title)
  html.elem("link", attrs: (rel: "stylesheet", href: "/assets/css/style.css"))
  html.elem("script", attrs: (src: "/assets/js/search.js", defer: "defer"))
}

#let category-label(t) = if t == "aula" { "Aulas" } else if t == "exercicio" { "Exercícios" } else if t == "solucao" { "Soluções" } else if t == "trabalho" { "Trabalhos" } else { t }

#let nav(brand: site-title, categories: ()) = html.elem("nav", attrs: (class: "navbar"))[
  #html.elem("a", attrs: (href: "/index.html", class: "brand"))[#brand]
  #html.elem("div", attrs: (class: "nav-search"))[
    #html.elem("input", attrs: (id: "search", type: "search", placeholder: "Buscar..."))
    #html.elem("div", attrs: (id: "search-results", class: "search-results"))
  ]
  #html.elem("div", attrs: (class: "nav-links"))[
    #for cat in categories {
      html.elem("a", attrs: (href: "/categorias/" + cat + ".html", class: "nav-cat"))[#category-label(cat)]
    }
    #html.elem("a", attrs: (href: "/book.pdf"))[📖 Download Livro]
    #html.elem("a", attrs: (href: "/rss.xml", class: "rss-link"))[RSS]
  ]
]

#let footer() = html.elem("footer", attrs: (class: "footer"))[
  #html.elem("p")[
    Gerado com #html.elem("a", attrs: (href: "https://typst.app"))[Typst] ·
    #html.elem("a", attrs: (href: "/book.pdf"))[Baixar PDF do Livro]
  ]
]

// Envolve o conteúdo de uma página. HTML → página completa (main + sidebar opcional);
// paged → só o conteúdo. `sidebar-left` põe a sidebar à esquerda (com toggle colapsável no mobile).
#let site-layout(title: site-title, brand: site-title, sidebar: none, sidebar-left: false, categories: (), body) = context {
  if target() == "html" or target() == "bundle" {
    html.elem("html", attrs: (lang: "pt-BR"))[
      #html.elem("head")[#head(title)]
      #html.elem("body")[
        #nav(brand: brand, categories: categories)
        #if sidebar == none [
          #html.elem("main", attrs: (class: "container"))[#body]
        ] else if sidebar-left [
          #html.elem("div", attrs: (class: "layout toc-left"))[
            #html.elem("div", attrs: (class: "layout-grid"))[
              #sidebar
              #html.elem("main", attrs: (class: "content"))[#body]
            ]
          ]
        ] else [
          #html.elem("div", attrs: (class: "layout"))[
            #html.elem("main", attrs: (class: "content"))[#body]
            #sidebar
          ]
        ]
        #footer()
      ]
    ]
  } else {
    body
  }
}

// Hero. HTML → bloco com botão; paged → título e subtítulo centrados.
#let hero(title: site-title, subtitle: site-subtitle) = context {
  if target() == "html" or target() == "bundle" {
    html.elem("header", attrs: (class: "hero"))[
      #html.elem("h1")[#title]
      #html.elem("p", attrs: (class: "subtitle"))[#subtitle]
      #html.elem("a", attrs: (href: "/book.pdf", class: "btn-primary"))[📖 Baixar Livro em PDF]
    ]
  } else {
    [
      #align(center)[
        #text(size: 2em, weight: "bold")[#title]
        #v(0.4em)
        #text(size: 1.1em, gray)[#subtitle]
      ]
      #v(1.5em)
    ]
  }
}

// Card de post. HTML → <article>; paged → linha tipografada.
#let post-card(post) = context {
  if target() == "html" or target() == "bundle" {
    html.elem("article", attrs: (class: "post-card"))[
      #html.elem("h3")[
        #html.elem("a", attrs: (href: "/posts/" + post.slug + ".html"))[#post.title]
      ]
      #html.elem("div", attrs: (class: "post-card-meta"))[
        #html.elem("time")[#post.date-pt]
        #if post.at("type", default: none) != none {
          html.elem("span", attrs: (class: "badge badge-" + post.type))[#post.type]
        }
        #if post.at("author", default: none) != none {
          html.elem("span")[ · #post.author]
        }
        #if post.at("reading-time", default: none) != none {
          html.elem("span")[ · #post.reading-time min]
        }
      ]
      #if post.at("excerpt", default: none) != none {
        html.elem("p")[#post.excerpt]
      }
      #if post.at("tags", default: ()) != () {
        html.elem("div", attrs: (class: "tags"))[
          #for tag in post.tags {
            html.elem("span", attrs: (class: "tag"))[#tag]
          }
        ]
      }
    ]
  } else {
    [
      #box(width: 100%)[
        #text(size: 1.2em, weight: "bold")[#post.title]
        #v(0.2em)
        #text(size: 0.85em, gray)[#post.date-pt]
      ]
      #if post.at("excerpt", default: none) != none [
        #v(0.3em)
        #post.excerpt
      ]
      #if post.at("tags", default: ()) != () [
        #v(0.3em)
        #for tag in post.tags [#text(size: 0.8em, gray)[#tag]]
      ]
      #v(0.8em)
      #line(length: 100%)
      #v(0.8em)
    ]
  }
}

// Lista de cards de posts. HTML → <section>; paged → heading + lista.
// Ordenada por data, mais recente primeiro.
#let post-list(posts) = context {
  let ordered = posts.sorted(by: (a, b) => a.date > b.date)
  if target() == "html" or target() == "bundle" {
    html.elem("section", attrs: (class: "posts-list"))[
      #html.elem("h2")[Últimos Posts]
      #for post in ordered { post-card(post) }
    ]
  } else {
    [
      #heading(level: 1, outlined: false)[Últimos Posts]
      #for post in ordered { post-card(post) }
    ]
  }
}

// Lista filtrada por tag (HTML only). Ordenada por data, mais recente primeiro.
#let post-list-filtered(posts, tag) = context {
  let ordered = posts.sorted(by: (a, b) => a.date > b.date)
  if target() == "html" or target() == "bundle" {
    html.elem("section", attrs: (class: "posts-list"))[
      #html.elem("h2")[Posts com a tag “#tag”]
      #for post in ordered {
        if post.at("tags", default: ()) != () and post.tags.contains(tag) { post-card(post) }
      }
    ]
  } else {
    []
  }
}

// Lista filtrada por tipo/categoria (HTML only). Ordenada por data, mais recente primeiro.
#let post-list-by-type(posts, type) = context {
  let ordered = posts.sorted(by: (a, b) => a.date > b.date)
  if target() == "html" or target() == "bundle" {
    html.elem("section", attrs: (class: "posts-list"))[
      #html.elem("h2")[Categoria: #category-label(type)]
      #for post in ordered {
        if post.at("type", default: none) == type { post-card(post) }
      }
    ]
  } else {
    []
  }
}

// Navegação anterior/próximo (HTML only). `prev`/`next` são dicts de meta ou none.
#let post-nav(prev: none, next: none) = context {
  if target() == "html" or target() == "bundle" {
    html.elem("nav", attrs: (class: "post-nav"))[
      #if prev != none [
        #html.elem("a", attrs: (href: "/posts/" + prev.slug + ".html", class: "nav-prev"))[← #prev.title]
      ]
      #if next != none [
        #html.elem("a", attrs: (href: "/posts/" + next.slug + ".html", class: "nav-next"))[#next.title →]
      ]
    ]
  } else {
    []
  }
}