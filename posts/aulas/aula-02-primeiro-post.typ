#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Aula - 02 Meu primeiro post",
  date: "2026-08-14",
  tags: ("typst", "html"),
  excerpt: "Primeiro post do blog, escrito inteiramente em Typst e exportado como HTML estático.",
)

#let body = [

Este é o primeiro post do blog, escrito inteiramente em *Typst* e exportado como HTML estático.

== Por que Typst?

Porque dá pra usar a mesma linguagem de marcação tanto para gerar PDFs quanto páginas web, com funções, variáveis e tudo mais que você já usaria em um documento normal.

- Listas funcionam normalmente.
- Fórmulas também: $ x^2 + y^2 = r^2 $
- E código:

```python
print("Olá, mundo!")
```
]

#post-layout(meta, body)


