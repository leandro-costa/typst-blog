#import "../../templates/post.typ": post-layout

#let meta = (
  title: "Aula 01 - Introdução ao Typst",
  date: "2026-08-14 11:00:00",
  
  tags: ("typst", "typesetting", "tutorial"),
  excerpt: "Uma introdução ao Typst, o sistema de tipografia moderno que substitui o LaTeX.",
)

#let body = [

O Typst é um sistema de tipografia baseado em markup, projetado para ser tão poderoso quanto o LaTeX, mas muito mais fácil de aprender e usar. Ele foi criado por Laurenz Mädje e Martin Haug, e desde seu lançamento tem ganhado tração significativa na comunidade acadêmica e técnica.

== Por que Typst?

Existem várias razões para escolher o Typst:

- *Velocidade*: Compilação em milissegundos
- *Sintaxe limpa*: Mais legível que LaTeX
- *Tipografia matemática nativa*: Sem pacotes extras
- *Exportação HTML experimental*: Ideal para blogs
- *Bundle export*: Múltiplos arquivos de uma só vez

== Um exemplo rápido

Aqui está uma equação famosa:

$ sum_(i=1)^n i = frac(n(n+1), 2) $

E um código simples:

```typ
#let nome = "Typst"
Olá, *#nome*!
```

== HTML Export

A partir da versão 0.13, o Typst introduziu suporte experimental para exportação HTML. Na versão 0.15, isso evoluiu para o *bundle export*, permitindo gerar múltiplas páginas HTML a partir de um único arquivo:

```typ
#document("index.html", title: [Home])[
  = Bem-vindo!
]

#document("sobre.html", title: [Sobre])[
  = Sobre mim
]
```

Isso torna o Typst uma ferramenta viável para geração de sites estáticos, especialmente quando combinado com o Tinymist para uma experiência de desenvolvimento completa.
]

#post-layout(meta, body)


